<?php 
namespace App\Modules\Nfts\Controllers\Users;
class User_nfts extends BaseController 
{
  
	public function index()
  {

    if (!$this->session->get('isLogIn') && !$this->session->get('user_id')) {
        return redirect()->to(base_url());
    }
    if ($this->session->get('isLogIn') && $this->session->get('isAdmin')) {
        return redirect()->to('backend/home');
    }



    $data['title']  = "My NFTs";

    #-------------------------------#
     #pagination starts
    #-------------------------------#
    $page           = ($this->uri->getSegment(3)) ? $this->uri->getSegment(3) : 0;
    $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1); 
    $builder = $this->db->table('nfts_store');
    $builder->select('nfts_store.*, nfts_store.id as nftId, user.f_name, user.l_name, nft_category.cat_name, nft_collection.title as collection_title');
    $builder->where(['nfts_store.user_id' => $this->session->get('user_id'), 'nfts_store.is_minted' => 1]);
    $builder->limit(10,($page_number-1)*10);
    $builder->orderBy('nfts_store.id', 'DESC');
    $builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
    $builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
    $builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left');  
    $query = $builder->get(); 
    $data['nfts'] = $query->getResult();
  
     
    $total           = $this->common_model->countRow('nfts_store', ['nfts_store.user_id' => $this->session->get('user_id')]);
    $data['pager']   = $this->pager->makeLinks($page_number, 10, $total);  
     #------------------------
     #pagination ends
     #------------------------

    $data['networks'] = $this->common_model->get_all('nfts_store', $pagewhere=array(),20,($page_number-1)*20,'id','desc');

    $data['content'] = $this->BASE_VIEW . '\nfts\index';
    return $this->template->customer_layout($data);
  } 

  /*
  |----------------------------------------------
  |   Datatable Ajax data Pagination+Search
  |----------------------------------------------     
  */

  public function list_collection()
  {
    if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
        return redirect()->to('admin');
    } 
    $uri = service('uri','<?php echo base_url(); ?>'); 
    #-------------------------------#
    #pagination starts
    #-------------------------------#
    $data['limit'] = $limit = 20;
    $page           = ($uri->getSegment(3)) ? $uri->getSegment(3) : 0;
    $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1);
    $data['collections']  = $this->nfts_model->get_all_collection('nft_collection',$where=array('user_id'=>$this->session->get('user_id')),$limit,($page_number-1)*$limit,'id','desc');

    $data['total'] = $total           = $this->common_model->countRow('nft_collection', $where);
    $data['pager']   = $this->pager->makeLinks($page_number, $limit, $total);  
    #------------------------
    #pagination ends
    #------------------------

    $data['title']  = 'My Collections'; 
    $data['frontendAssets'] = base_url('public/assets/website');
    $data['content']        = view($this->BASE_VIEW . '\nfts\list_collection',$data);
    return $this->template->website_layout($data); 
  }

  public function add_collection()
  {
    ini_set('memory_limit', '44M');
    if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
          return redirect()->to('admin');
    } 
    if(!$this->session->get('user_id')){
      return redirect()->to();
    }

    $this->validation->setRule('col_name', 'Collection Name','required|is_unique[nft_collection.title]');  
 
    $this->validation->setRule('category', 'Category','required'); 
    $this->validation->setRule('banner_img', 'Banner image', 'ext_in[banner_img,png,jpg,gif,ico,jpeg]|is_image[banner_img]');
    $this->validation->setRule('profile_img', 'Profile image', 'ext_in[profile_img,png,jpg,gif,ico,jpeg]|is_image[profile_img]');

    if($this->validation->withRequest($this->request)->run()){

      $banner_img = $this->request->getFile('banner_img',FILTER_SANITIZE_STRING);
      $profile_img = $this->request->getFile('profile_img',FILTER_SANITIZE_STRING);

      if($profile_img->getSize() == 0){
        $this->session->setFlashdata('exception',  'profile image is required'); 
        return  redirect()->to(base_url('user/add-collection'));
      }else if(($profile_img->getSize() / 1024) > 2049){
        $this->session->setFlashdata('exception',  'NTFs file size must be less than 2 MB'); 
        return  redirect()->to(base_url('user/add-collection'));
      }

      if($banner_img->getSize() == 0){
        $this->session->setFlashdata('exception',  'Banner image is required'); 
        return  redirect()->to(base_url('user/add-collection'));
      }else if(($banner_img->getSize() / 1024) > 4096){
        $this->session->setFlashdata('exception',  'NTFs file size must be less than 4 MB'); 
        return  redirect()->to(base_url('user/add-collection'));
      } 

      if($banner_img){
        $savepath="public/uploads/collection/banner/";
        $old_image = $this->request->getVar('old_image', FILTER_SANITIZE_STRING); 
        $image=$this->imagelibrary->image($banner_img,$savepath,$old_image,1400,400);
      }else{
        $image = null;
      }

      if($profile_img){
        $savepath="public/uploads/collection/profile/";
        $old_image = $this->request->getVar('old_image', FILTER_SANITIZE_STRING); 
        $froImage=$this->imagelibrary->image($profile_img,$savepath,$old_image,350,350);
      }else{
        $froImage = null;
      } 
    } 


    if ($this->validation->withRequest($this->request)->run()){ 
          $slug = $this->request->getVar('slug', FILTER_SANITIZE_STRING);
          if(empty($slug)){
            $slug = $this->_clean($this->request->getVar('col_name', FILTER_SANITIZE_STRING));
          }
           
          $data = [
              'user_id' => $this->user_id,
              'title' => $this->request->getVar('col_name', FILTER_SANITIZE_STRING),
              'slug' => strtolower($slug),
              'description' => $this->request->getVar('description', FILTER_SANITIZE_STRING), 
              'category_id' => $this->request->getVar('category', FILTER_SANITIZE_STRING),   
              'banner_image' => $image, 
              'logo_image' => $froImage, 
              'created_at' => date('Y-m-d H:i:s'),
          ];

          $builder = $this->db->table('nft_collection');
          $ins = $builder->insert($data);

          if($ins){
              $this->session->setFlashdata('message',display('save_successfully')); 
              return  redirect()->to(base_url('user/add-collection')); 
          }else{ 
              $this->session->setFlashdata('exception', display('please_try_again')); 
              return  redirect()->to(base_url('user/add-collection'));
          } 

    }
    $error=$this->validation->listErrors();
    if($this->request->getMethod() == "post"){
          $this->session->setFlashdata('exception', $error);
          return  redirect()->to(base_url('user/add-collection'));
    }
    if ($this->session->getFlashdata('exception') != null) {  
        $data['exception'] = $this->session->getFlashdata('exception');
    }else if($this->session->getFlashdata('message') != null){
        $data['message'] = $this->session->getFlashdata('message');
    }

     
    $data['user_id']    = $this->user_id;
    $data['categories']  = $this->db->table('nft_category')->select('id, cat_name')->get()->getResult();
    $data['blockchain']  = $this->db->table('blockchain_network')->select('id, network_name')->where(['status'=>1])->get()->getRow(); 
    $data['settings']  = $this->db->table('setting')->get()->getRow(); 
    
    $data['title']  = "Add New Collection";
    $data['frontendAssets'] = base_url('public/assets/website');
    $data['content']        = view($this->BASE_VIEW . '\nfts\add_collection',$data);
    return $this->template->website_layout($data); 
  }

  
  private function _clean($string) {
     $string = str_replace(' ', '-', $string); // Replaces all spaces with hyphens.

     return preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
  }



  public function update_collection($cid=null)
  {
    ini_set('memory_limit', '44M');
    if (!$this->session->get('isLogIn')) {
          return redirect()->to(base_url('admin'));
    }
    if (empty($cid)) {
      return redirect()->to(base_url('user/dashboard'));
    } 
    $info = $this->db->table('nft_collection')->select('*')->where(['id'=>$cid])->get()->getRow();
    
    $this->validation->setRule('col_name', 'Collection Name','required');   
    $this->validation->setRule('banner_img', 'Banner image', 'ext_in[banner_img,png,jpg,gif,ico,jpeg]|is_image[banner_img]');
    $this->validation->setRule('profile_img', 'Profile image', 'ext_in[profile_img,png,jpg,gif,ico,jpeg]|is_image[profile_img]');

    if($this->validation->withRequest($this->request)->run()){
      $banner_img = $this->request->getFile('banner_img',FILTER_SANITIZE_STRING);
      $profile_img = $this->request->getFile('profile_img',FILTER_SANITIZE_STRING);
      if($banner_img){
        $savepath="public/uploads/collection/banner/";
        $old_image = $info->banner_image; 
        $image=$this->imagelibrary->image($banner_img,$savepath,$old_image,1400,400);
      }else{
        $image = null;
      }

      if($profile_img){
        $savepath="public/uploads/collection/profile/";
        $old_image = $info->logo_image;
        $froImage=$this->imagelibrary->image($profile_img,$savepath,$old_image,350,350);
      }else{
        $froImage = null;
      } 
    } 

    if ($this->validation->withRequest($this->request)->run()){

          $slug = $this->_clean($this->request->getVar('slug', FILTER_SANITIZE_STRING));
          if(empty($slug)){
            $slug = $this->_clean($this->request->getVar('col_name', FILTER_SANITIZE_STRING));
          }
          

          $data = [ 
              'title' => $this->request->getVar('col_name', FILTER_SANITIZE_STRING),
              'slug' => strtolower($slug),
              'description' => $this->request->getVar('description', FILTER_SANITIZE_STRING),     
          ];
          if ($image) {
            $data['banner_image'] = $image ;
          }
          if($froImage){
            $data['logo_image'] = $froImage;
          }
          

          $builder = $this->db->table('nft_collection');
          $update = $this->common_model->update('nft_collection', ['id'=>$cid], $data);

          if($update){
              $this->session->setFlashdata('message',display('update_successfully')); 
              return  redirect()->to(base_url('user/edit-collection/'.$cid)); 
          }else{ 
              $this->session->setFlashdata('exception', display('please_try_again')); 
              return  redirect()->to(base_url('user/edit-collection/'.$cid));
          } 

    }
    $error=$this->validation->listErrors();
    if($this->request->getMethod() == "post"){
          $this->session->setFlashdata('exception', $error);
          return  redirect()->to(base_url('customer/edit_collection'));
    }
    if ($this->session->getFlashdata('exception') != null) {  
        $data['exception'] = $this->session->getFlashdata('exception');
    }else if($this->session->getFlashdata('message') != null){
        $data['message'] = $this->session->getFlashdata('message');
    }

    $data['info']  = $info;
     
    $data['categories']  = $this->db->table('nft_category')->select('id, cat_name')->get()->getResult();
    $data['blockchain']  = $this->db->table('blockchain_network')->select('id, network_name')->where(['status'=>1])->get()->getRow();
    $data['settings']  = $this->db->table('setting')->get()->getRow(); 
     
      
    $data['title']  = "Update Collection";
    $data['frontendAssets'] = base_url('public/assets/website');
    $data['content']        = view($this->BASE_VIEW . '\nfts\edit_collection',$data);
    return $this->template->website_layout($data); 
  }
 
    

  public function nftDetails($id=null)
  {


    if (empty($id)) {
      redirect()->to(base_url('nft/list'));
    }

    $data['info'] = $this->common_model->where_row('nfts_store', ['id'=>$id]);

    $data['title']  = "NFT Details";
    $data['content'] = $this->BASE_VIEW . '\nfts\details';
    return $this->template->admin_layout($data);
  } 

  public function create_new_nft()
  {
    $data['contract']     = $this->common_model->where_row('contract_setup', array('status' => 1));
    $data['network']      = $this->common_model->where_row('blockchain_network', array('status' => 1));
    $data['collections']  = $this->common_model->where_rows('nft_collection', ['user_id'=>$this->session->get('user_id')], 'id', 'asc');
    $data['title']  = "Create New NFT";  
    $data['frontendAssets'] = base_url('public/assets/website');
    $data['content']        = view($this->BASE_VIEW . '\nfts\create_nft',$data);
    return $this->template->website_layout($data); 
  }


  public function create_new_nft_action()
  {
    ini_set('memory_limit', '44M');
    $this->validation->setRule('item_name', 'Nft Name','required'); 
    $this->validation->setRule('collection', 'Colleection','required'); 
  
      
    if ($this->validation->withRequest($this->request)->run()){

      $file = $this->request->getFile('nft_file',FILTER_SANITIZE_STRING);
       
      if($file->getSize() == 0){

        
        die(json_encode(['status' => 'err', 'msg' => 'NFTs file is required']));

      }else if(($file->getSize() / 1024) > 10245){

        die(json_encode(['status' => 'err', 'msg' => 'NTFs file size must be less than 10 MB'])); 

      }
      
      $file_ext = pathinfo($_FILES["nft_file"]["name"], PATHINFO_EXTENSION);


      /* File Upload im serve */
      if($file_ext == 'mp4' || $file_ext =='webm'){
        $path1 = 'public/uploads/nfts/video';
        if ($file->isValid() && ! $file->hasMoved()) {
          $newName = $file->getRandomName();
          $file->move($path1, $newName);
          $image = '/'.$path1.'/'.$newName;
        }else{
          die(json_encode(['status' => 'err', 'msg' => 'This video is not valid'])); 
        }
        
      }else if($file_ext == 'mp3'){ 
        $path2 = 'public/uploads/nfts/audio';
        
        if ($file->isValid() && ! $file->hasMoved()) {
          $newName = $file->getRandomName();
          $file->move($path2, $newName);
          $image = '/'.$path2.'/'.$newName; 
        }else{
          die(json_encode(['status' => 'err', 'msg' => 'This audio is not valid']));  
        }
      }else{
        $savepath="public/uploads/nfts";
        if ($file->isValid() && ! $file->hasMoved()) {
          $newName = $file->getRandomName();
          $file->move($savepath, $newName);
          $image = '/'.$savepath.'/'.$newName; 
        }else{

          die(json_encode(['status' => 'err', 'msg' => 'This image is not valid']));  
        }
      }

      
      $typ = $this->request->getVar('opt_type[]', FILTER_SANITIZE_STRING);
      $val = $this->request->getVar('opt_val[]', FILTER_SANITIZE_STRING);
      $properties = null;
      if(isset($typ)){
        for ($i=0; $i < count($typ); $i++) { 
          $properties[$typ[$i]] = $val[$i];
        } 
      } 
      

      $collection_id  = $this->request->getVar('collection', FILTER_SANITIZE_STRING);
      $col            = $this->common_model->where_row('nft_collection', ['id'=>$collection_id]); 
      $contractAdd    = $this->common_model->where_row('contract_setup', ['status'=>1]);
      $blockchainNetwork = $this->common_model->where_row('blockchain_network', ['status'=>1]);

      if(!isset($contractAdd)){ 

        die(json_encode(['status' => 'err', 'msg' => 'Marketplace not setup, please contact to admin'])); 

      }

      /* Data for Database Insert */
      $data = array( 
        'user_id' => $this->user_id,
        'name' => $this->request->getVar('item_name', FILTER_SANITIZE_STRING),
        'description' => $this->request->getVar('description', FILTER_SANITIZE_STRING), 
        'collection_id' => $this->request->getVar('collection', FILTER_SANITIZE_STRING), 
        'blockchain_id' => $blockchainNetwork->id,
        'properties' => json_encode($properties),  
        'file' => $image,  
        'category_id' => $col->category_id, 
        'status' => 0,
        'token_standard'  => 'ERC721', 
        'created_by'  => $this->session->get('user_id'),
        'created_at'  => date('Y-m-d H:i:s'),
        'is_minted' => 1, 
        'token_id' => null, 
        'contract_address' => '',  
        'trx_hash' => '',  
        'owner_wallet' => '',  
      );

      $returnId = $this->common_model->save_return_id('nfts_store', $data);

      $returnIdInfo = $this->common_model->where_row('nfts_store', array('id' =>$returnId));
      $contractInfo = $this->common_model->where_row('contract_setup', array('status' => 1));

      $retunData = array(
        'contractAddress' => $contractInfo->contract_address,
        'img_path'        => base_url().$returnIdInfo->file,
        'nft_id'          => $returnId,
      );

      echo json_encode($retunData);

    }
  }

  public function new_nft_update(){ 
    
       $nftId             = $this->request->getPost('nftId', FILTER_SANITIZE_STRING);
       $token_id          = $this->request->getPost('token_id', FILTER_SANITIZE_STRING);
       $contract_address  = $this->request->getPost('contract_address', FILTER_SANITIZE_STRING);
       $owner_wallet      = $this->request->getPost('owner_wallet', FILTER_SANITIZE_STRING);
       $trx_hash          = $this->request->getPost('trx_hash', FILTER_SANITIZE_STRING);

        $data = array( 
       
          'token_id'          => $token_id, 
          'contract_address'  => $contract_address,  
          'owner_wallet'      => $owner_wallet,  
          'trx_hash'          => $trx_hash,  
        );

      $response = $this->common_model->update('nfts_store', array('id' => $nftId, 'user_id' => $this->user_id), $data);

      if($response){

        echo 1;
        
      } 
  }


  public function new_nft_delete(){

    $nftId = $this->request->getPost('nftId', FILTER_SANITIZE_STRING);
    $this->common_model->deleteRow('nfts_store', array('id' => $nftId, 'user_id' => $this->user_id));

    echo 1;
  }



  public function updateNft($tokenId = null, $nftId = null, $contract_address = null)
  {
      if (!$this->session->get('isLogIn')) {
        return redirect()->to('admin');
      } 
       
       
      $info = $this->common_model->where_row('nfts_store', ['id'=>$nftId, 'token_id'=>$tokenId]);


      $this->validation->setRule('item_name', 'Nft Name','required');  
      
        
      if ($this->validation->withRequest($this->request)->run()){
       
        $typ = $this->request->getVar('opt_type[]', FILTER_SANITIZE_STRING);
        $val = $this->request->getVar('opt_val[]', FILTER_SANITIZE_STRING);
        $properties = null;
        if(isset($typ)){
          for ($i=0; $i < count($typ); $i++) { 
            $properties[$typ[$i]] = $val[$i];
          } 
        } 


          $data = [ 
            'name' => $this->request->getVar('item_name', FILTER_SANITIZE_STRING),
            'description' => $this->request->getVar('description', FILTER_SANITIZE_STRING),      
            'properties' => json_encode($properties), 
          ]; 

          
          $builder = $this->db->table('nfts_store');
          $builder->where(['id'=>$nftId, 'token_id'=>$tokenId]);
          $up = $builder->update($data);
             
          if($up){  
            $this->session->setFlashdata('message',display('update_successfully')); 
            return  redirect()->to(base_url("user/mynft_update/{$tokenId}/{$nftId}/{$contract_address}")); 
          }else{ 
            $this->session->setFlashdata('exception', display('please_try_again')); 
            return  redirect()->to(base_url("user/mynft_update/{$tokenId}/{$nftId}/{$contract_address}"));
          } 

      }


      $error=$this->validation->listErrors();
      if($this->request->getMethod() == "post"){
            $this->session->setFlashdata('exception', $error);
            return  redirect()->to(base_url('user/mynft_update/'.$tokenId.'/'.$nftId.'/'.$contract_address));
      }
      if ($this->session->getFlashdata('exception') != null) {  
          $data['exception'] = $this->session->getFlashdata('exception');
      }else if($this->session->getFlashdata('message') != null){
          $data['message'] = $this->session->getFlashdata('message');
      }

      
      $data['collections'] = $this->db->table('nft_collection')->select('id, title')->where(['user_id'=>$this->session->get('user_id')])->get()->getResult(); 
      $data['blockchain']  = $this->db->table('blockchain_network')->select('id, network_name')->where(['status'=>1, 'network_name'=>'ETHEREUM'])->get()->getRow();
      $data['network'] = $this->common_model->where_row('blockchain_network', array('status' => 1));

      $data['info']  = $info; 
      $data['title']  = "Update NFT"; 
      $data['frontendAssets'] = base_url('public/assets/website');
      $data['content']        = view($this->BASE_VIEW . '\nfts\editnft',$data);
      return $this->template->website_layout($data); 
  }


      

  public function checkWallet($address=null)
  { 

    if(!empty($address)){
      $result = $this->blockchain->checkValidWalletAddress($address);

      echo json_encode($result);
    }else{
      echo json_encode(['status'=>'err', 'value'=>'not found']);
    }
    
  }



  public function transferNft($nftId=null, $tokenId=null, $contractAdd=null)
  {  
 
    if(empty($nftId) || empty($tokenId)){
      return redirect()->to(base_url());
    }  

    $nftInfo = $this->common_model->where_row('nfts_store', ['id'=> $nftId]);

    if($nftInfo->user_id !== $this->user_id){
        $this->session->setFlashdata('exception', display('access_denied'));
        return redirect()->to(base_url('user/dashboard'));
    }

    if ($nftInfo->status == 2) {

      $this->session->setFlashdata('exception', 'This NFT is on sale!'); 
      return redirect()->to(base_url('user/dashboard'));

    }else if($nftInfo->status == 3){

      $this->session->setFlashdata('exception', 'This NFT is suspend!');
      return redirect()->to(base_url('user/dashboard'));

    }
 
    $data['fees']  = $this->common_model->where_row('fees_tbl', ['level'=>'transfer']);; 
    $data['nftInfo']  = $nftInfo; 
    $data['title']  = "Update NFT"; 
    $data['frontendAssets'] = base_url('public/assets/website');
    $data['content']        = view($this->BASE_VIEW . '\nfts\transfer',$data);
    return $this->template->website_layout($data);  

  }


  public function transferAvailability()
  {
    $towallet   = $this->request->getVar('towallet');
    $nftId      = $this->request->getVar('nftId');
    $token_id   = $this->request->getVar('token_id');

    $transferFee  = $this->common_model->where_row('fees_tbl', ['level' => 'transfer']);
    $contractInfo = $this->common_model->where_row('contract_setup', ['status' => 1]);

    $toExist  = $this->common_model->where_row('user', ['wallet_address' => $towallet]);
    $nftExist = $this->common_model->where_row('nfts_store', ['id' => $nftId, 'token_id'=> $token_id, 'user_id' => $this->user_id]);

    if(!empty($toExist) && !empty($nftExist)){

      echo json_encode(['status' => 'success', 'msg' => 'This is available', 'fee'=> (!empty($transferFee) ? $transferFee->fees : 0), 'contract'=>(!empty($contractInfo) ? $contractInfo->contract_address : '')]);

    } else {

      echo json_encode(['status' => 'err', 'msg' => 'This wallet is not available in the marketplace']);

    }

  }

  public function confirmTransfer()
  {  

    $toWallet       = $this->request->getVar('towallet'); 
    $nftId          = $this->request->getVar('nftId'); 
    $trx_info       = $this->request->getVar('trx_info'); 

    $networkInfo    = $this->common_model->where_row('blockchain_network', array('status' => 1));
    $contractInfo   = $this->common_model->where_row('contract_setup', ['status' => 1]);
    $fees           = $this->common_model->where_row('fees_tbl', ['level'=>'transfer']);

    if(!isset($networkInfo) || !isset($contractInfo) || !isset($fees)){

      $this->session->setFlashdata('exception', 'Please contact to admin for error setup');
      return redirect()->to(base_url('user/dashboard'));

    }

    $toWalletInfo     = $this->common_model->where_row('user', ['wallet_address'=>$toWallet]); 
    $fromWalletInfo   = $this->common_model->where_row('user', ['user_id' => $this->user_id]);

    if($toWalletInfo){ 
  
      $upData = array(
        'owner_wallet' => $toWallet,
        'user_id'      => $toWalletInfo->user_id 
      );

      $admin_wallet = $this->common_model->where_row('admin_wallet');
      $marketPlaceFee = ($admin_wallet->earned_fees + $fees->fees);
      
      $this->common_model->update('admin_wallet', ['awid'=>$admin_wallet->awid], ['earned_fees'=>$marketPlaceFee]);  
      $this->common_model->update('nfts_store', ['id'=>$nftId], $upData); 
      $this->nfts_model->nftStoreLogSave($nftId, 'transfer');

      $info = [
        'fee' => $fees->fees,
        'type' => 'transfer',
        'nft_id' => $nftId,
        'user_id' => $fromWalletInfo->user_id,
      ];
      $this->nfts_model->saveEarnings($info, $trx_info);

      echo json_encode(['status' => 'success', 'msg' => 'Successfully transfered your item']);
      die();
    }else{ 
      echo json_encode(['status' => 'err', 'msg' => 'This wallet not found the marketplace']);
      die();
    }
         
  }


  public function getFixBuyInfo()
  {
    $nftId = $this->request->getVar('nft_id'); 

    $nftInfo  = $this->common_model->where_row('nfts_store', ['id' => $nftId]); 
    $fee     = $this->common_model->where_row('fees_tbl', ['level' => 'sale']);

    if(!empty($nftInfo)){

      $returnArr = ['status' => 'success', 'fee' => ($fee) ? $fee->fees : 0, 'token_id' => $nftInfo->token_id, 'contract' => $nftInfo->contract_address, 'price' => $nftInfo->price];
      echo json_encode($returnArr);
      die;

    }else{

      $returnArr = ['status' => 'err'];
      echo json_encode($returnArr);
      die;

    }


  }


  public function fixSellConfirm()
  {
      $nftId    = $this->request->getVar('nft_id'); 
      $tokenid  = $this->request->getVar('token_id'); 
      $trx_info = $this->request->getVar('trx_info'); 
 
      $nftInfo = $this->nfts_model->nfts_with_listing_info($tokenid, $nftId) ;
     
      if(empty($nftInfo)){ 

        echo json_encode(['status' => 'err', 'msg' => 'This is not lis for sale']);
        die();
      }
       
      if($nftInfo->user_id === $this->user_id){
         
        echo json_encode(['status' => 'err', 'msg' => 'This is my nft!']);
        die();
      }
 
 
      $listingWhere = ['nft_store_id'=>$nftId, 'nft_token_id'=>$tokenid, 'nft_listing.status'=> 0]; 
      $listingInfo  = $this->common_model->getListingWithNftstoreInfo($listingWhere); 
        
 
      $buyerInfo    = $this->common_model->where_row('user', ['user_id' => $this->user_id]); 
      $networkdata  = $this->common_model->where_row('blockchain_network', array('status' => 1)); 
       
  
  
      $fees = $this->db->table('fees_tbl')->where('level', 'sale')->get()->getRow()->fees;
     

      $nftUpdateArr = [
          'user_id'       => $buyerInfo->user_id,
          'owner_wallet'  => $buyerInfo->wallet_address,
          'status'        => 1,
      ];
      
      $admin_wallet = $this->common_model->where_row('admin_wallet');
      $gotFee = (($listingInfo->min_price * $fees) / 100);
      $marketPlaceFee = ($gotFee + ($admin_wallet->earned_fees)); 
      $this->common_model->update('admin_wallet', ['awid'=>$admin_wallet->awid], ['earned_fees'=>$marketPlaceFee]);


      $this->common_model->update('nfts_store', ['id'=>$nftId, 'token_id'=>$tokenid], $nftUpdateArr);
      $this->common_model->update('nft_listing', ['id'=>$listingInfo->id], ['status'=>1]);
      $this->common_model->update('nft_biding', ['nft_listing_id'=>$listingInfo->id], ['cancel_status'=>1]); 
      /* Earnings save */
      $info = [
        'fee' => $gotFee,
        'type' => 'sell',
        'nft_id' => $nftId,
        'user_id' => $listingInfo->list_from,
      ];
      $this->nfts_model->saveEarnings($info, $trx_info);
      /* Log save */ 
      $this->nfts_model->nftStoreLogSave($nftId, 'buy');
      $this->nfts_model->saveListingLog2($listingInfo->id, 1, $buyerInfo->user_id, $buyerInfo->wallet_address, $trx_info);
           

      echo json_encode(['status' => 'success', 'msg' => 'Successfully buy your nft']);
      die(); 


  }

  public function assetMethods($method=null, $tokenid=null, $nftTableId=null, $contract=null)
  {

    if(empty($tokenid)){
      redirect()->to(base_url());
    }

    if(empty($method)){
      redirect()->to(base_url());
    }
   
    if($method ==='bid'){ 

      $this->validation->setRule('amount', 'bid amount','required');  

      $nftInfo = $this->nfts_model->nfts_with_listing_info($tokenid, $nftTableId);

      if(@$nftInfo->user_id === $this->session->get('user_id')){
        
        $this->session->setFlashdata('exception', 'This is my nft'); 
        return  redirect()->to(base_url('user/dashboard'));
      }


      if ($this->validation->withRequest($this->request)->run()){
       
        $arr = [
          'nft_listing_id' => @$nftInfo->listing_id,
          'nft_id' => @$nftInfo->nftId, 
          'bid_from_id' => $this->session->get('user_id'),
          'bid_start_at' => date('Y-m-d H:i:s'),
          'bid_end_at' => date('Y-m-d H:i:s'),
          'bid_amount' => (string) $this->request->getVar('bid_amount', FILTER_SANITIZE_STRING), 
          'status' => 1,
        ];


        $builder = $this->db->table('nft_biding'); 
        $builder->insert($arr);
        $bidId = $this->db->insertID();

        if($bidId){
          /**  nft_listing table total bid update  */
          $bidInfo = $this->common_model->where_row('nft_biding', ['id'=>$bidId]);
          $listingInfo = $this->common_model->where_row('nft_listing', ['id'=>$bidInfo->nft_listing_id]);
          
          $this->common_model->update('nft_listing', ['id'=>$bidInfo->nft_listing_id], ['total_bid' => $listingInfo->total_bid+1]);

          $this->session->setFlashdata('message',display('save_successfully')); 
          return  redirect()->to(base_url("nft/asset/details/{$tokenid}/{$nftTableId}/{$contract}")); 
        }else{ 
            $this->session->setFlashdata('exception', display('please_try_again')); 
            return  redirect()->to(base_url("user/asset/bid/{$tokenid}/{$nftTableId}/{$contract}"));
        }

        $error=$this->validation->listErrors();
        if($this->request->getMethod() == "post"){
              $this->session->setFlashdata('exception', $error);
              return  redirect()->to(base_url("user/asset/bid/{$tokenid}/{$nftTableId}/{$contract}"));
        }
        if ($this->session->getFlashdata('exception') != null) {  
            $data['exception'] = $this->session->getFlashdata('exception');
        }else if($this->session->getFlashdata('message') != null){
            $data['message'] = $this->session->getFlashdata('message');
        }
      }
      $data['nftInfo'] = $nftInfo;
      $data['allBid'] = $this->nfts_model->get_all('nft_biding', ['nft_id'=>$nftTableId, 'nft_listing_id'=>@$nftInfo->listing_id], 'bid_start_at', 'DESC');
      $data['acInfo'] = $this->common_model->where_row('user_account', ['user_id'=>$this->session->get('user_id')]);
     
 

      $data['title']  = "Bid place for ".@$nftInfo->name;
      $data['frontendAssets'] = base_url('public/assets/website');
      $data['content']        = view($this->BASE_VIEW . '\nfts\bid',$data);
      return $this->template->website_layout($data); 
 
    } elseif($method ==='sale_cancel'){ 

      $nftInfo = $this->common_model->where_row('nfts_store', ['id'=>$nftTableId,'token_id'=>$tokenid]);
      $listingInfo = $this->common_model->where_row('nft_listing', ['nft_store_id'=>$nftTableId, 'nft_token_id'=>$tokenid]);

      
      if(!empty($nftInfo) && !empty($listingInfo) && $this->session->get('user_id') == $nftInfo->user_id){
        
        $update = $this->common_model->update('nft_listing', ['nft_store_id'=>$nftTableId, 'nft_token_id'=>$tokenid], ['status'=>3, 'updated_at'=>date('Y-m-d H:i:s')]);
        if($update){
          $res = $this->nfts_model->saveListingLog($listingInfo, 3);
          $this->common_model->update('nfts_store', ['id'=>$nftTableId], ['status'=>1]);
          $this->session->setFlashdata('message', 'Cancel Successfully'); 
          return  redirect()->to(base_url('user/dashboard')); 
        }else{
            $this->session->setFlashdata('exception', display('please_try_again')); 
            return  redirect()->to(base_url('user/dashboard'));
        }
      }else{
        
        $this->session->setFlashdata('exception', display('please_try_again'));     
        return  redirect()->to(base_url('user/dashboard'));
      }


    }elseif($method ==='sale'){


      $this->validation->setRule('price', 'price','required'); 
      $this->validation->setRule('duration', 'duration','required'); 

      $nftInfo = $this->common_model->where_row('nfts_store', ['id'=>$nftTableId,'token_id'=>$tokenid]);
      $listingInfo = $this->common_model->where_row('nft_listing', ['nft_store_id'=>$nftInfo->id]);
     
      if($nftInfo->is_verified != 1){
        echo json_encode(array('status'=>'fail', 'msg' => 'This item is not verified'));
        exit();
      }


      if($nftInfo->status == 3){
        echo json_encode(array('status'=>'fail', 'msg' => 'Already listed this item'));
        exit();
      }

      if ($this->validation->withRequest($this->request)->run()){

        $duration   = explode('-', $this->request->getVar('duration', FILTER_SANITIZE_STRING));
        $start      = str_replace('/', '-', $duration[0]);
        $end        = str_replace('/', '-', $duration[1]);

        $start_date = date('Y-m-d H:i:s', strtotime($start));
        $end_date   = date('Y-m-d H:i:s', strtotime($end));        

        $arr = [ 
          'nft_store_id'  => $nftInfo->id,
          'nft_token_id'  => $nftInfo->token_id,
          'auction_type'  => $this->request->getVar('sale_type', FILTER_SANITIZE_STRING),
          'min_price'     => $this->request->getVar('price', FILTER_SANITIZE_STRING), 
          'reserve_price' => $this->request->getVar('reserve_price', FILTER_SANITIZE_STRING), 
          'list_from'     => $this->session->get('user_id'), 
          'status'        => 0, 
          'start_date'    => $start_date,
          'end_date'      => $end_date,
          'created_at'    => date('Y-m-d H:i:s'),
        ];

        $contractAdd    = $this->common_model->where_row('contract_setup', ['status'=>1]); 
        $networkdata    = $this->common_model->where_row('blockchain_network', array('status' => 1));         

        $builder = $this->db->table('nft_listing'); 
        $builder->insert($arr);
        $listingId = $this->db->insertID();

        if($listingId){ 

          //$arr['trx_info']   = $listResult; //need this data from ajax
          $arr['trx_info']   = $this->request->getPost('trx_info');
          $arr['listing_id'] = $listingId; 
          $this->common_model->insert('nft_listing_log', $arr);
          $this->common_model->update('nfts_store', ['id'=>$nftInfo->id], ['status'=>3, 'price'=>$this->request->getVar('price', FILTER_SANITIZE_STRING)]);

          echo json_encode(array('status'=>'success', 'msg' => display('save_successfully')));
          exit();

        } else { 
           
            echo json_encode(array('status'=>'fail', 'msg' => display('please_try_again')));
            exit();
        }
      }

      if($this->request->getMethod() == "post"){

        $error = $this->validation->getErrors();
        echo json_encode(array('status'=>'validation', 'msg' => $error));
        exit();
      }

      if ($this->session->getFlashdata('exception') != null) {  
        $data['exception'] = $this->session->getFlashdata('exception');
      }else if($this->session->getFlashdata('message') != null){
        $data['message'] = $this->session->getFlashdata('message');
      }

      $data['selling_types'] = $this->common_model->where_rows('nft_selling_type', [], 'type_id','asc');
      $data['nftInfo'] = $nftInfo;

      //echo "<pre>";
      //print_r($data['selling_types']);


      $data['title']  = "List item for sale";
      $data['frontendAssets'] = base_url('public/assets/website');
      $data['content']        = view($this->BASE_VIEW . '\nfts\sale',$data);
      return $this->template->website_layout($data); 
    }
  }



  public function bidlist($nftId=null)
  {
    if(empty($nftId)){
      $this->session->setFlashdata('exception', 'Your are worng');
      return  redirect()->to(base_url('user/dashboard'));
    }
     
    $data['allBid']  = $this->common_model->where_rows('nft_biding', ['nft_id'=>$nftId,'accept_status'=>0, 'cancel_status'=>0], 'bid_datetime', 'DESC');
    $data['title']  = "Bid List";
    $data['content'] = $this->BASE_VIEW . '\nfts\bidlist';
    return $this->template->customer_layout($data);
    
  }


  public function checkColelctionName($data=null)
  {
      if($data){
          $data = base64_decode($data);
          $result = $this->common_model->where_row('nft_collection', ['title'=>$data]);
          if($result){
              echo json_encode(['status'=>'err', 'msg'=>'This collection already exists!', 'class'=>'text-danger']); 
         }else{
              echo json_encode(['status'=>'success', 'msg'=>'Valid Collection', 'class'=>'text-success']);
         }
          
      }else{
          echo json_encode(['status'=>'err', 'msg'=>'Collection not found', 'class'=>'text-danger']);
      } 
  }

  public function checkColelctionSlug($data=null)
  {
      if($data){
          $data = base64_decode($data);
          $result = $this->common_model->where_row('nft_collection', ['slug'=>$data]);
          if($result){
              echo json_encode(['status'=>'err', 'msg'=>'This URL already exists!', 'class'=>'text-danger']); 
         }else{
              echo json_encode(['status'=>'success', 'msg'=>'Valid URL', 'class'=>'text-success']);
         }
          
      }else{
          echo json_encode(['status'=>'err', 'msg'=>'Username not found', 'class'=>'text-danger']);
      } 
  }


  public function biding_old()
  {

    $userId       = $this->session->get('user_id');
    $acInfo       = $this->common_model->where_row('user_account', ['user_id'=>$userId]);
    $offerAmount  = $this->request->getVar('amount', FILTER_SANITIZE_STRING);

   

    $offerId;
    if(!empty($acInfo) && $acInfo->balance > $offerAmount){

      /* Hold balace */
      $holdBalance = ($acInfo->hold_balance + $offerAmount);

      /* check previous bid this user */
      $where = [
        'nft_listing_id'  => $this->request->getVar('listing_id', FILTER_SANITIZE_STRING),
        'nft_id'          => $this->request->getVar('nft_id', FILTER_SANITIZE_STRING),
        'bid_from_id'     => $userId,
      ];
      
      $getCheck = $this->common_model->where_row('nft_biding', $where);

      if($getCheck){ 
        echo json_encode(['status'=>'err', 'msg' => 'You are already offered this nfts']);
        return;
      } 

      $arr = [
        'nft_listing_id'  => $this->request->getVar('listing_id', FILTER_SANITIZE_STRING),
        'nft_id'          => $this->request->getVar('nft_id', FILTER_SANITIZE_STRING),
        'bid_from_id'     => $userId,
        'bid_start_at'    => date('Y-m-d H:i:s'), 
        'bid_amount'      => $offerAmount,
        'status'          => 1,
      ]; 


      $builder = $this->db->table('nft_biding')->insert($arr);
      $offerId = $this->db->insertID();


      $this->common_model->update('nfts_store', ['id'=>$this->request->getVar('nft_id', FILTER_SANITIZE_STRING)], ['status'=>3, 'price'=>$offerAmount]);
    }

    if($offerId){ 

      $arr['nft_bid_id'] = $offerId; 
      $this->db->table('nft_biding_log')->insert($arr);

      echo json_encode(['status'=>'success']);

    }else{

      echo json_encode(['status'=>'err']);

    }
    
  }



  public function biding() {

    $userId       = $this->session->get('user_id');
    $acInfo       = $this->common_model->where_row('user_account', ['user_id'=>$userId]);
    $offerAmount  = $this->request->getPost('amount', FILTER_SANITIZE_STRING);

    $where = [
      'nft_listing_id'  => $this->request->getPost('listing_id', FILTER_SANITIZE_STRING),
      'nft_id'          => $this->request->getPost('nft_id', FILTER_SANITIZE_STRING),
      'bid_from_id'     => $userId,
    ];
      
    $getCheck = $this->common_model->where_row('nft_biding', $where);
    if($getCheck){ 
      $this->common_model->update('nfts_store', ['id'=>$this->request->getPost('nft_id', FILTER_SANITIZE_STRING)], ['status'=>3, 'price'=>$offerAmount]);
      // $this->common_model->update('nft_biding_log', ['nft_bid_id'=>$getCheck->id], ['status'=>3]);
    } 

    $arr = [

      'nft_listing_id'  => $this->request->getPost('listing_id', FILTER_SANITIZE_STRING),
      'nft_id'          => $this->request->getPost('nft_id', FILTER_SANITIZE_STRING),
      'bid_from_id'     => $userId,
      'bid_start_at'    => date('Y-m-d H:i:s'), 
      'bid_amount'      => $offerAmount,
      'status'          => 1,
    ];

    $builder = $this->db->table('nft_biding')->insert($arr);
    $offerId = $this->db->insertID(); 

    if($offerId){ 
      $this->common_model->update('nfts_store', ['id'=>$this->request->getVar('nft_id', FILTER_SANITIZE_STRING)], ['price'=>$offerAmount]);
      $this->common_model->update('nft_listing', ['nft_store_id'=>$this->request->getVar('nft_id', FILTER_SANITIZE_STRING), 'status' => 0], ['min_price'=>$offerAmount]);
      $arr['nft_bid_id'] = $offerId; 
      $this->db->table('nft_biding_log')->insert($arr);
      echo json_encode(['status'=>'success', 'msg' => 'Your bid placed successfully done.']);

    } else {

      echo json_encode(['status'=>'err', 'msg' => 'Something went wrong, Please try again.']);

    }
  }
 
    
}