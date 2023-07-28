<?php
namespace App\Modules\Website\Controllers;

class Home extends BaseController 
{
     
    function __construct()
    {
        // write your __construct
   
    }



    public function index()
    {
        
        $data['title']        = display("Home");  
        @$cat_id              = $this->web_model->catidBySlug('home');
        $data['article']      = $this->web_model->article($cat_id->cat_id);
  
        #-------------------------------#
        #pagination starts
        #-------------------------------#
        $limit                  = 15;
        $page                   = ($this->uri->getSegment(1)) ? $this->uri->getSegment(1) : 0;
        $page_number            = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1); 
         
        $data['nfts']           = $result = $this->web_model->getAllNfts($limit, $page_number);  
        $total                  = $this->common_model->countRow('nfts_store', ['nfts_store.status' => 3]);

        $data['topCollections'] = $this->web_model->topCollections();

        $data['topSellers']     = $this->web_model->topSellers();
        
        $featuredItemInfo = null;
        if($this->common_model->where_row('nfts_store', ['is_featured' => 1])){
            $featuredItemInfo = $this->web_model->getFeaturedNfts(); 
        }else{
            $featuredItemInfo = (isset($data['nfts'][0])) ? $data['nfts'][0] : null;
        }

        

        if(isset($featuredItemInfo)){
            $data['featured'] = $featuredItemInfo;
            $data['featuredCollection'] = $this->common_model->where_row('nft_collection', ['id' => $featuredItemInfo->collection_id])->title;
            $data['featuredOwner']      = $this->common_model->where_row('user', ['user_id' => $featuredItemInfo->user_id]);
        }
        
         
        $data['pager']   = $this->pager->makeLinks($page_number, $limit, $total);  
         #------------------------
         # pagination ends
         #------------------------ 
        $data['isUser']            = $this->isUser;
        $data['settings']           = $this->common_model->where_row('setting');
        $data['frontendAssets']     = base_url('public/assets/website');
        $data['total_data']         = $total;
        $data['page_limit']         = $limit;
        $data['content']            = view('themes/'.$this->templte_name->name.'/index',$data);

        return $this->template->website_layout($data);

    }


    public function nft_details($tokenid=null, $nftTableId=null, $contractAdd=null)
    {
         
        if ($tokenid == null || $nftTableId == null) {
            return redirect()->to(base_url());
        }

        $data['nftInfo'] = $info = $this->web_model->getNftDetails($tokenid, $nftTableId);
        if(!isset($info)){ 
            return redirect()->to(base_url());
        }
        
        $data['listings']               = $this->web_model->getListings($tokenid, $nftTableId);
        $data['moreNftsFromCollection'] = $this->web_model->getNfts(['nfts_store.status'=> 3, 'nfts_store.id !='=>$nftTableId,'nft_listing.status'=> 0, 'nfts_store.collection_id'=>$info->collection_id], 5);
         
        $data['favourite']          = $this->common_model->countRow('favorite_items', ['nft_id'=> $nftTableId, 'user_id'=>$this->userId]);
       $data['bid_info']            = $this->web_model->getNftWiseBid($info->nftId, $info->listing_id);
        $data['activities']         = $this->common_model->item_activity($nftTableId, $tokenid);
        
 
        if ($this->session->getFlashdata('exception') != null) {  
            $data['exception'] = $this->session->getFlashdata('exception');
        }else if($this->session->getFlashdata('message') != null){
            $data['message'] = $this->session->getFlashdata('message');
        }
          
        $data['frontendAssets']     = base_url('public/assets/website');
        $data['userId']             = (isset($this->userId)) ? $this->userId : ''; 
        $data['isUser']             = (isset($this->isUser) ? $this->isUser : ''); 

        $data['loggedinWallet']     = (isset($this->isUser) ? $this->common_model->where_row('user', ['user_id'=>$this->userId])->wallet_address : ''); 

        $data['title']              = display("NFT Details"); 
        $data['networks']           = $this->common_model->where_row('blockchain_network', array('id' => $info->blockchain_id));
      
        $data['content']            = view('themes/'.$this->templte_name->name.'/nft_details',$data);
        
        return $this->template->website_layout($data);
    }


    public function collectionWiseNfts(String $slug = null)
    {
        
        if ($slug == null) {
            return redirect()->to(base_url());
        }
        
        $data['collectionInfo'] = $collectionInfo = $this->common_model->where_row('nft_collection', ['slug'=>$slug]);
        if(empty($collectionInfo)){
            return redirect()->to(base_url());
        }
        $data['ownerInfo'] = $this->common_model->where_row('user', ['user_id'=>$collectionInfo->user_id]);
         
        $data['totalItem'] = $this->web_model->countRow('nfts_store', ['collection_id'=>$collectionInfo->id, 'status'=>3]);
        $data['nftOwner'] = $this->web_model->countNftOwnerInCollection('nfts_store', ['collection_id'=>$collectionInfo->id]);
        $data['floorPrice'] = $this->web_model->getMinPrice('nfts_store', ['collection_id'=>$collectionInfo->id, 'status'=>3], 'price');

        $data['collections'] = $this->common_model->where_rows('nft_collection', array('category_id'=>$collectionInfo->category_id), 'id', 'asc');

        $data['ctegories'] = $this->common_model->where_rows('nft_category', array(), 'id', 'asc');
        $data['networks'] = $this->common_model->where_rows('blockchain_network', array('status' => 1), 'id', 'asc');

        $data['frontendAssets'] = base_url('public/assets/website');
        $data['title']        = str_replace('-', ' ', $slug);
        $data['content']        = view('themes/'.$this->templte_name->name.'/collection_wise_nfts',$data);
        return $this->template->website_layout($data);
    }


    public function ajax_coll_nfts($collectionId = null, $loadmore = 1)
    {
        $limit = 20;
        $data['nfts'] = $this->web_model->getNfts(['nfts_store.collection_id'=>$collectionId], ($loadmore*$limit)); 
        $result = view('themes/'.$this->templte_name->name.'/ajax_nfts',$data);
        
        echo json_encode(['status'=>true, 'data'=>$result]); 
    }


    public function categoryWiseNfts($slug = null)
    {
  
        if (empty($slug)) {

            return redirect()->to(base_url('/'));

        }

        $data['categoryInfo']   = $categoryInfo = $this->common_model->where_row('nft_category', ['slug'=>$slug]);

        if(!isset($categoryInfo)){
            return redirect()->to(base_url()); 
        }

        $data['collections']    = $this->common_model->where_rows('nft_collection', array('category_id'=>$categoryInfo->id), 'id', 'asc');
        $data['actegories']     = $this->common_model->where_rows('nft_category', array(), 'id', 'asc'); 
        $data['total']          = $this->web_model->countRow('nfts_store', ['category_id'=>$categoryInfo->id, 'status'=>3]);

        $data['networks']       = $this->common_model->where_rows('blockchain_network', array('status' => 1), 'id', 'asc');

        $data['frontendAssets'] = base_url('public/assets/website');
        $data['title']          = display('All Nfts');
        $data['content']        = view('themes/'.$this->templte_name->name.'/category_wise_nfts',$data);
        return $this->template->website_layout($data);
    }

    public function ajax_cat_nfts($categoryId = null, $loadmore = 1)
    {
        $limit = 20;  
        $data['nfts'] = $this->web_model->getNfts(['nfts_store.category_id' => $categoryId, 'nfts_store.status'=> 3, 'nft_listing.status'=> 0], ($loadmore*$limit));
        $result = view('themes/'.$this->templte_name->name.'/ajax_nfts',$data);
        
        echo json_encode(['status'=>true, 'data'=>$result]); 
    }

    public function userWiseNfts(String $wallet = null)
    {
        
        if ($wallet == null) {
            return redirect()->to(base_url());
        }


        $data['networks']    = $this->common_model->where_rows('blockchain_network', ['status'=>1], 'id', 'asc');  
        $data['userInfo']   = $userInfo = $this->common_model->where_row('user', ['wallet_address'=>$wallet]);  
        $data['totalItem']  = $this->web_model->countRow('nfts_store', ['user_id'=>$userInfo->user_id]); 
        $data['collections'] = $this->common_model->where_rows('nft_collection', ['user_id'=>$userInfo->user_id], 'id', 'asc');
        $data['ctegories']  = $this->common_model->where_rows('nft_category', array(), 'id', 'asc');
         
        $data['frontendAssets'] = base_url('public/assets/website');
        $data['title']          = str_replace('-', ' ', $wallet);
        $data['content']        = view('themes/'.$this->templte_name->name.'/user_wise_nfts',$data);
        return $this->template->website_layout($data);
    }


    public function ajax_user_nfts($userId = null, $loadmore = 1)
    {
        $limit = 20;   
        $data['nfts'] = $this->web_model->getNfts(['nfts_store.user_id'=>$userId], ($loadmore*$limit)); 
        $result = view('themes/'.$this->templte_name->name.'/ajax_nfts',$data);
        
        echo json_encode(['status'=>true, 'data'=>$result]); 
    }


    public function all_nfts()
    {
        $data['collections']    = $this->common_model->where_rows('nft_collection', array(), 'id', 'asc');
        $data['actegories']     = $this->common_model->where_rows('nft_category', array(), 'id', 'asc');
        $data['total']          = $this->web_model->countRow('nfts_store', ['status'=> 3]);  
        $data['networks']       = $this->common_model->where_rows('blockchain_network', array('status'=>1), 'id', 'asc');

        $data['frontendAssets'] = base_url('public/assets/website');
        $data['title']          = display('All Nfts');
        $data['content']        = view('themes/'.$this->templte_name->name.'/all_nfts',$data);
        return $this->template->website_layout($data);
    }

    

    public function ajax_all_nfts($categoryId = null, $collId = null, $loadmore = 1)
    {
        $limit = 20;    
        $where = ['nfts_store.status'=> 3, 'nft_listing.status'=> 0];

        if($categoryId != 'no'){
            $where['nfts_store.category_id'] = $categoryId;
        }
        if($collId != 'no'){
            $where['nfts_store.collection_id'] = $collId;
        }

        $data['nfts']   = $this->web_model->getNfts($where, ($loadmore*$limit));  
        $result         = view('themes/'.$this->templte_name->name.'/ajax_nfts',$data);
        
        echo json_encode(['status'=>true, 'data'=>$result]); 
    }



    

    public function contact()
    {
        
        $data['title']      = display('contact');

        $cat_id             = $this->web_model->catidBySlug('contact');
        $data['article']    = $this->web_model->article($cat_id->cat_id);
        $data['cat_info']   = $this->web_model->cat_info('contact');


        if ($this->session->getFlashdata('exception') != null) {  
            $data['exception'] = $this->session->getFlashdata('exception');
        }else if($this->session->getFlashdata('message') != null){
            $data['message'] = $this->session->getFlashdata('message');
        }

        $googleapikey = $this->db->table('external_api_setup')->select('data')->where('id',4)->where('status',1)->get()->getRow();  
        $data['googleapikeydecode'] = json_decode($googleapikey->data,true);
        $data['frontendAssets'] = base_url('public/assets/website');
        $data['content']    = view('themes/'.$this->templte_name->name.'/contact',$data);
        return $this->template->website_layout($data);
     
    } 
 
    public function about()
    {

        $data['title']          = display('About'); 

        $cat_id                 = $this->web_model->catidBySlug('about');
        $data['article']        = $this->web_model->article($cat_id->cat_id);
        $data['cat_info']       = $this->web_model->cat_info('about');
        
        $data['content']        = view('themes/'.$this->templte_name->name.'/about',$data);
        return $this->template->website_layout($data);
        
    }
    
    public function faq()
    {

        $data['title']      = display('FAQ');        
        $cat_id             = $this->web_model->catidBySlug('faq');
        $data['article']    = $this->web_model->article($cat_id->cat_id);
        $data['cat_info']   = $this->web_model->cat_info('faq');
        
        $data['content']    = view('themes/'.$this->templte_name->name.'/faq',$data);
        return $this->template->website_layout($data);
        
    }
    
    public function privacy()
    {

        $data['title']      = display('Privacy Policy');  

        $cat_id             = $this->web_model->catidBySlug('privacy');      
        $data['article']    = $this->web_model->article($cat_id->cat_id);
        $data['cat_info']   = $this->web_model->cat_info('privacy');
        
        $data['content']    = view('themes/'.$this->templte_name->name.'/privacy',$data);
        return $this->template->website_layout($data);
        
    }
    
    public function terms()
    {

        $data['title']      = display('Terms'); 

        $cat_id             = $this->web_model->catidBySlug('terms');
        $data['article']    = $this->web_model->article($cat_id->cat_id);
        $data['cat_info']   = $this->web_model->cat_info('terms');
        
        $data['content']    = view('themes/'.$this->templte_name->name.'/terms',$data);
        return $this->template->website_layout($data);
        
    }

   

    public function register()
    {
       if ($this->session->userdata('isLogIn'))
            return redirect()->to(base_url('home'));

        helper('text');
        $cat_id = $this->web_model->catidBySlug($this->uri->getSegment(1));

         
        $data['lang']       = $this->langSet();
        $lang               = $this->langSet();

        $data['title']      = $this->uri->getSegment(1);
        
        $data['cat_info']   = $this->web_model->cat_info($this->uri->getSegment(1));

        $dlanguage = $this->db->table('setting')->select('language')->get()->getRow();
        $appSetting = $this->common_model->get_setting(); 

       
        $this->validation->setRule('username', display('username'),'required|alpha_numeric|max_length[12]|min_length[6]|is_unique[user.username]');
        $this->validation->setRule('email', display('email'),'required|valid_email|max_length[100]|is_unique[user.email]');
        $this->validation->setRule('password', display('password'),'required|min_length[8]|max_length[32]|matches[conf_pass]');
        $this->validation->setRule('conf_pass', display('password'),'required|max_length[32]');
      
        $this->validation->setRule('accept_terms', display('accept_terms_privacy'),'required');

        //From Validation Check
        if ($this->validation->withRequest($this->request)->run()) {

            $data = array(); 
            $data = [
                'username'  => $this->request->getVar('username',FILTER_SANITIZE_STRING),                
                'email'     => $this->request->getVar('email',FILTER_SANITIZE_EMAIL)
            ];


            $usercheck=$this->web_model->checkUser($data);
            if (!empty($usercheck->getRow())) { 

                $this->session->setFlashdata('exception', display('email_used')." ".display('username_used'));
                redirect()->to(base_url('user/signin')); 
            }
            $userid = strtoupper(random_string('alnum', 6)); 
            $data = [ 
                'username'  => $this->request->getVar('username',FILTER_SANITIZE_STRING),
                'user_id'       => $userid,  
                'email'         => $this->request->getVar('email',FILTER_SANITIZE_EMAIL), 
                'password'      => md5($this->request->getVar('password',FILTER_SANITIZE_STRING)),
                'status'        => 0,
                'reg_ip'        => $this->request->getIpAddress()
            ]; 

            if($uid = $this->web_model->registerUser($data)){
                // User wallet create 
                $obj_value = (object) ["user_id"=> $userid, "password"=> $this->request->getVar('password',FILTER_SANITIZE_STRING)];
                $this->blockchain->createWallet($obj_value);  
                
                $this->common_model->insert('user_account', ['user_id'=>$userid, 'currency_id'=>'2', 'symbol'=>SYMBOL(), 'balance'=>'0']);

                $template = array( 
                    'fullname'      => '#',
                    'amount'        => '0',
                    'balance'       => '0',
                    'pre_balance'   => '0',
                    'new_balance'   => '0',
                    'user_id'       => '#',
                    'receiver_id'   => '#',
                    'verify_code'   => '#',
                    'date'          => date('d F Y')
                );

                $config_var = array( 
                    'template_name' => 'registration',
                    'template_lang' => $lang=='english'?'en':'fr',
                );

                $message    = $this->common_model->email_msg_generate($config_var, $template);
                $send_email = array(
                    'title'         => $appSetting->title,
                    'to'            => $this->request->getVar('email',FILTER_SANITIZE_EMAIL),
                    'subject'       => $message['subject'],
                    'message'       => $message['message'],
                );

                $data['title']      = $appSetting->title; 
                $data['to']         = $this->request->getVar('email',FILTER_SANITIZE_STRING);
                $data['subject']    = $message['subject'];
                $data['message']    = $message['message']." <a target='_blank' href='".site_url('home/activeAcc/').strtolower($userid).md5($userid)."'>".site_url('home/activeAcc/').strtolower($userid).md5($userid)."</a>";

                $emailSend = $this->common_model->send_email($data);

                if($emailSend == 0){
                    $this->session->setFlashdata('exception', 'Registration success! But mail has not been sent to your email, Please contract admin');
                    return redirect()->to(base_url('user/signin'));
                }
                $this->session->setFlashdata('message', display('account_create_active_link'));
                return redirect()->to(base_url('user/signin'));
            }else{
                $this->session->setFlashdata('exception',  display('please_try_again'));
                return redirect()->to(base_url('signup'));
            } 

        }

        $error=$this->validation->listErrors();
        if($this->request->getMethod() == "post"){
            $this->session->setFlashdata('exception', $error);
            return  redirect()->to(base_url('signup'));
        }
        if ($this->session->getFlashdata('exception') != null) {  
            $data['exception'] = $this->session->getFlashdata('exception');
        }else if($this->session->getFlashdata('message') != null){
            $data['message'] = $this->session->getFlashdata('message');
        }

        
        $data['frontendAssets'] = base_url('public/assets/website');
        $builder = $this->db->table('themes');
        $template = $builder->select('name')->where('status',1)->get()->getRow(); 
        $data['settings'] = $this->common_model->where_row('setting'); 
        return view('themes/'.$template->name.'/register', $data);
        
    }



    public function login()
    { 
        if ($this->session->userdata('isLogIn'))
            return redirect()->to(base_url('/'));

        $data['frontendAssets'] = base_url('public/assets/website');
        $builder = $this->db->table('themes');
        $template = $builder->select('name')->where('status',1)->get()->getRow();

        $data['settings'] = $this->common_model->where_row('setting');
 
        $data['content']    = view('themes/'.$this->templte_name->name.'/login',$data);
        return $this->template->website_layout($data);
  
    }

    public function login_action()
    {

        $walletAddress = $this->request->getVar('walletAddress',FILTER_SANITIZE_STRING);
        $chainId       = $this->request->getVar('chainId',FILTER_SANITIZE_STRING);

        $userid = $this->randomID(); 
        $data = [ 
            'chain_id'       => $chainId,
            'wallet_address' => $walletAddress,
            'user_id'       => $userid,  
            'status'        => 1,
            'reg_ip'        => $this->request->getIpAddress()
        ];

        $checkExit = $this->web_model->findById('user', array('wallet_address' => $walletAddress));

        if(!$checkExit){

            $uid    = $this->web_model->save_return_id('user', $data);
            $userId = $userid;

        } else {

            $uid    = $checkExit->uid;
            $userId = $checkExit->user_id;
        }

 
        $sData = array(

            'isLogIn' => true,
            'isUser'  => true,
            'id'      => $uid,
            'user_id' => $userId,
            'chain_id'=> $chainId,
        );

        $this->session->set($sData);
       

        if($uid){

            echo json_encode(array('status' => 'success', 'msg' => 'You are successfully connected.'));

        } else {
            
            echo json_encode(array('status' => 'failed', 'msg' => 'Something went wrong.'));
        }
    }

    public function network_update()
    {
        $userInfo = $this->web_model->findById('user', array('user_id'=> $this->userId));

        $chainId = $this->request->getVar('chainId',FILTER_SANITIZE_STRING);
        $data    = ['chain_id' => $chainId];

        $this->web_model->update('user', $data, array('user_id' => $this->userId));
 
        $sData = array( 

            'isLogIn' => true,
            'isUser'  => true, 
            'id'      => $userInfo->uid,
            'user_id' => $this->userId,
            'chain_id'=> $chainId,
        );

        $this->session->set($sData); 

        if($userInfo->uid){

            echo json_encode(array('status' => 'success', 'msg' => 'You are successfully.'));

        } else {
            
            echo json_encode(array('status' => 'failed', 'msg' => 'Something went wrong.'));
        }
    }

    //Ajax Subscription Action
    public function subscribe()
    {
        $data = array();
        $data['email'] =  $this->request->getVar('subscribe_email',FILTER_SANITIZE_STRING);

        if($this->common_model->insert('web_subscriber',$data)){
            $this->session->setFlashdata('message', display('save_successfully'));
            
        }
        else{
            $this->session->setFlashdata('exception',  display('please_try_again')); 
        }
    }

    //Ajax Contact Message Action
    public function contactMsg()
    {
        $appSetting = $this->common_model->get_setting();
        
        $data['fromName']       = $this->request->getVar('full_name',FILTER_SANITIZE_STRING);
        $data['from']           = $this->request->getVar('email',FILTER_SANITIZE_EMAIL);
        $data['to']             = $appSetting->email;
        $data['subject']        = 'Contact us a message';
        $data['title']          = $this->request->getVar('email',FILTER_SANITIZE_STRING);
        $data['message']    = "<b>Phone: </b>".$this->request->getVar('phone',FILTER_SANITIZE_STRING)."<br><b>Message: </b>".$this->request->getVar('comment',FILTER_SANITIZE_STRING);

        $send = $this->common_model->send_email($data); 
        if($send == 1){
            $this->session->setFlashdata('message', display('save_successfully'));
            return redirect()->to(base_url("contact")); 
        }else{
            $this->session->setFlashdata('exception', display('please_try_again'));
            return redirect()->to(base_url("contact")); 
        }
         
    }

    public function activeAcc($activecode='')
    {
        if($activecode){
            $activecode = strtoupper(substr($activecode, 0, 6));

        }
        $user = $this->web_model->activeAccountSelect($activecode);

        if ($user->CountAll() > 0){
            $this->web_model->activeAccount($activecode);
            $this->session->setFlashdata('message', display('Activated_your_account._You_can_login_now!'));
            return redirect()->to(base_url("user/signin"));

        } else {
            $this->session->setFlashdata('exception', display('wrong_try_activation'));
            return redirect()->to(base_url("user/signin"));
        }

    }
 
     

    public function forgotPassword()
    {

        //Set Rules From validation
        $this->validation->setrule('email', display('email'),'required');

        //From Validation Check
        if ($this->validation->withRequest($this->request)->run()) {
            $userdata = array(
                'email'       => $this->request->getVar('email',FILTER_SANITIZE_EMAIL),
            );

            $userInfo = $this->common_model->where_row('user', $userdata);
            if(empty($userInfo)){
                $this->session->setFlashdata('exception', display("incorrect_email"));
                return redirect()->to(base_url('user/signin'));
            }

            $varify_code = $this->randomID();



            /******************************
            *  Email Verify
            ******************************/
            $appSetting = $this->common_model->get_setting();

            $post = array(
                'title'             => $appSetting->title,
                'subject'           => 'Password Reset Verification!',
                'to'                => $this->request->getVar('email',FILTER_SANITIZE_EMAIL),
                'message'           => 'The Verification Code is <h1>'.$varify_code.'</h1>'
            );


            //Send Mail Password Reset Verification
            $send = $this->common_model->send_email($post);
             
            if(isset($send)){

                $varify_data = array(

                    'ip_address'    => $this->request->getIpAddress(),
                    'user_id'       => $this->session->userdata('user_id'),
                    'session_id'    => $this->session->userdata('isLogIn'),
                    'verify_code'   => $varify_code,
                    'data'          => json_encode($userdata)
                );
                
                $this->common_model->insert('verify_tbl',$varify_data);
             
                $id = $this->db->insertId();

                $this->session->setFlashdata('message', "Password reset code sent.Check your email.");
                
                return redirect()->to(base_url("user/signin"));

            }
        }else{
            $this->session->setFlashdata('exception',display('email')." Required");
            return redirect()->to(base_url('user/signin'));

        }

    }

    public function resetPassword()
    {

        @$cat_id = $this->web_model->catidBySlug('forgot-password');     

        $data['title'] = display("Reset Password");   
       
        $data['cat_info'] = $this->web_model->cat_info('forgot-password');

        $code = $this->request->getVar('verificationcode',FILTER_SANITIZE_STRING);
        $newpassword = $this->request->getVar('newpassword',FILTER_SANITIZE_STRING);
        
        $chkdata = $this->db->table('verify_tbl')->select('*')
                            ->where('verify_code',$code)
                            ->where('status', 1)
                            ->get()
                            ->getRow();

        //Set Rules From validation
        $this->validation->setRule('verificationcode',display('enter_verify_code'),'required');
        $this->validation->setRule('newpassword',display('password'),'required|min_length[8]|max_length[32]|matches[r_pass]');
       

        //From Validation Check
        if ($this->validation->withRequest($this->request)->run()) {
            
            if($chkdata!=NULL) {
                $p_data = ((array) json_decode($chkdata->data));
                $password   = array('password' => md5($newpassword));
                $status     = array('status'   => 0);
                $where = array('verify_code' => $code);
                $userwhere = array('email' => $p_data['email']);
                $this->common_model->update('verify_tbl',$where,$status);
                $this->common_model->update('user',$userwhere,$password);

                $this->session->setFlashdata('message',display('update_successfully'));
                return redirect()->to(base_url('user/signin'));

            }else{
                $this->session->setFlashdata('exception',display('wrong_try_activation'));
                return redirect()->to(base_url('resetPassword'));
            }

        }else{
            $error=$this->validation->listErrors();
            if($this->request->getMethod() == "post"){
                $this->session->setFlashdata('exception', $error);
                return redirect()->to(base_url('resetPassword'));
            }
            if ($this->session->getFlashdata('exception') != null) {  
                $data['exception'] = $this->session->getFlashdata('exception');
            }else if($this->session->getFlashdata('message') != null){
                $data['message'] = $this->session->getFlashdata('message');
            }
                $data['content']        = view('themes/'.$this->templte_name->name.'/passwordreset',$data);
            return $this->template->website_layout($data);
           
        }

    }

    
    //Ajax Language Change
    public function langChange()
    { 
        $newdata = array(
            'lang'  => $this->request->getVar('lang',FILTER_SANITIZE_STRING)
        );   

        /**
         * Is User
         */
        if ($this->session->userdata('isUser')) {
            $data['lang'] = $this->request->getVar('lang',FILTER_SANITIZE_STRING);
            $where = array('user_id' => $this->session->userdata('user_id'));
            $this->common_model->update('dbt_user',$where,$data);
            $this->session->set($newdata);
        }
        /**
         * Is Admin
         */
        elseif($this->session->userdata('isAdmin')) {
            
            $data['lang'] = $this->request->getVar('lang',FILTER_SANITIZE_STRING);
            $where = array('id' => $this->session->userdata('id'));
            $this->common_model->update('admin', $where, $data); 
            $this->session->set($newdata);
        }
        /**
         * Is Visitor
         */
        else {
            $this->session->set($newdata);
        } 
        
    }


    /******************************
    * Language Set For User
    ******************************/
    public function langSet(){

        $lang = "";
        
            $builder = $this->db->table('setting');
            $alang = $builder->select('language')->get()->getRow();
            if ($alang->language=='french') {
                $lang ='french';
                $newdata = array(
                    'lang'  => 'french'
                );
                $this->session->set($newdata);

            }else{
                if ($this->session->lang=='french') {
                    $lang ='french';

                }
                else{
                    $lang ='english';
                }

            }


        return $lang;
    }

  

  

    /******************************
    * Converter Percent of Number
    ******************************/
    public function getPercentOfNumber($number, $percent){
        return ($percent / 100) * $number;
    }


    /******************************
    * Rand ID Generator
    ******************************/
    public function randomID($mode = 2, $len = 6)
    {
        $result = "";
        if($mode == 1):
            $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        elseif($mode == 2):
            $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        elseif($mode == 3):
            $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
        elseif($mode == 4):
            $chars = "0123456789";
        endif;

        $charArray = str_split($chars);
        for($i = 0; $i < $len; $i++) {
            $randItem = array_rand($charArray);
            $result .="".$charArray[$randItem];

        }
        return $result;

    }

    public function logout()
    { 
        //destroy session
        $ipadd = $this->request->getIPAddress();
        $this->session->destroy();
        return redirect()->to(base_url());
    }

    public function logout_action()
    { 
        //destroy session
        $ipadd = $this->request->getIPAddress();
        $this->session->destroy();
        echo 1;
    }


    public function saleConfirm($type=null, $nftId=null)
    {

        $bidInfo = $this->db->table('nft_biding')->select('*')->where(['nft_id'=> $nftId, 'cancel_status'=> 0, 'accept_status'=> 0])->orderBy('bid_datetime', 'DESC')->get()->getRow(); 

        if($type == 'bid' && !empty($bidInfo)){
         
            $listingInfo = $this->common_model->where_row('nft_listing', ['id'=>$bidInfo->nft_listing_id]); 
            $nftInfo = $this->common_model->where_row('nfts_store', ['id'=>$listingInfo->nft_store_id, 'token_id'=>$listingInfo->nft_token_id]); 
            
            $sellerAcInfo = $this->common_model->where_row('user_account', ['user_id'=>$listingInfo->list_from]);
            $buyerAcInfo = $this->common_model->where_row('user_account', ['user_id'=>$bidInfo->bid_from_id]);

            $sellerWalletInfo = $this->common_model->where_row('user_wallet', ['user_id'=>$listingInfo->list_from]);
            $buyerWalletInfo  = $this->common_model->where_row('user_wallet', ['user_id'=>$bidInfo->bid_from_id]);
            
            if($buyerAcInfo->balance){  

              $sellerBalance = ($sellerAcInfo->balance+$bidInfo->bid_amount);
              $buyerBalance = ($buyerAcInfo->balance-$bidInfo->bid_amount);

              $sellerBalanceSet = $this->common_model->update('user_account', ['ac_id'=>$sellerAcInfo->ac_id], ['balance'=>$sellerBalance]);
              $buyerBalanceSet = $this->common_model->update('user_account', ['ac_id'=>$buyerAcInfo->ac_id], ['balance'=>$buyerBalance]);

              $buyerwalletBalanceSet = $this->common_model->update('user_wallet', ['user_id'=>$buyerAcInfo->user_id], ['balance'=>$buyerBalance]);
              $sellerwalletBalanceSet = $this->common_model->update('user_wallet', ['user_id'=>$sellerAcInfo->user_id], ['balance'=>$sellerBalance]);

              
              $nftUpdateArr = [
                'user_id' => $bidInfo->bid_from_id,
                'owner_wallet' => '0x'.$buyerWalletInfo->wallet_address,
                'status' => 1,
              ];

             
              $sellerPrivateData = $this->blockchain->privateCredential($sellerWalletInfo); 
               
              // amount transfer blockchain

              $dataArr = (Object) [ 
                'fromAddress'    => $buyerWalletInfo->wallet_address,
                'toAddress'      => $sellerWalletInfo->wallet_address,
                'sendAmount'     => $bidInfo->bid_amount, 
                'netWork'     => 'ropsten', 
              ];

              $res = $this->blockchain->sendBuyerToSellerAccount($dataArr);
               
              $trxHash = isset($res->data->txHash) ? $res->data->txHash : '';  
              $trxStatus = isset($res->status) ? $res->status : '';


              if($trxStatus == 'success'){
                $privatekey = '0x';
                $address = '0x';
                if($sellerPrivateData->status === 'success'){
                  $privatekey = $sellerPrivateData->data->privatekey;
                  $address = $sellerPrivateData->data->address;
                } 

                // blockchain transfer
                $transferArr = [ 
                  "formAddress" => '0x'.$sellerWalletInfo->wallet_address,
                  "tokenID" => $listingInfo->nft_token_id,
                  "toAddress" => '0x'.$buyerWalletInfo->wallet_address,
                  "privateKey" => str_replace("0x","",$privatekey),
                  "contractAddress" => $nftInfo->contract_address,
                  "netWork" => 'ropsten'
                ];
                 
                            
                  $transfered = $this->blockchain->adminToSendNft($transferArr); 

                  $this->common_model->update('nfts_store', ['id'=>$listingInfo->nft_store_id, 'token_id'=>$listingInfo->nft_token_id], $nftUpdateArr);
                  $this->common_model->update('nft_listing', ['id'=>$bidInfo->nft_listing_id], ['status'=>1]);
                  $this->common_model->update('nft_biding', ['nft_listing_id'=>$bidInfo->nft_listing_id], ['cancel_status'=>1]);
                  $this->common_model->update('nft_biding', ['id'=>$bidInfo->id], ['cancel_status'=>0,'accept_status'=>1]);
                  
                  echo  json_encode(['status'=>1, 'msg'=>'success']);
                  return;
              } 
              echo  json_encode(['status'=>0, 'msg'=>'error']);
                  return;
            } 
            
        }

        echo  json_encode(['status'=>0, 'msg'=>'error']);
        return;
      
    }
 

    public function todayBidAcceptation() 
    {

        
        $endListing = $this->common_model->getListingWithNftstoreInfo();

        if(!empty($endListing)){

            $contractAdd      = $this->common_model->where_row('contract_setup', ['status'=>1]); 
            $networkdata      = $this->common_model->where_row('blockchain_network', array('status' => 1)); 
            $adminInfo        = $this->common_model->where_row('admin_wallet');
            
            foreach ($endListing as $key => $listingVal) {

                $bidInfo    = $this->common_model->getAcceptableBidInfo($listingVal->id, $listingVal->nft_store_id); 
                

                if(!empty($bidInfo)){ 

                    $buyerInfo  = $this->common_model->where_row('user', ['user_id' => $bidInfo->bid_from_id]);
                     
                    $adminPrivateData  = $this->blockchain->privateCredential($adminInfo);  
                    $privatekey   = '';
                    $address      = '';

                    if($adminPrivateData->status === 'success'){

                        $privatekey = $adminPrivateData->data->privatekey;
                        $address = $adminPrivateData->data->address;

                    } 
                    
                    $fees = $this->db->table('fees_tbl')->where('level', 'sale')->get()->getRow()->fees;
                     
                    $buyArr = [
                        "privateKey"      => $privatekey,
                        "rpc_url"         => $networkdata->rpc_url, 
                        "contractAddress" => $contractAdd->contract_address, 
                        "tokenID"         => (int) $listingVal->nft_token_id,
                        "sellPrice"       => (string) $bidInfo->bid_amount,
                        "fees"            => (int) $fees,
                        "winner"          => $buyerInfo->wallet_address,
                        "netWork"         => $networkdata->network_slug, 
                    ];

                    /* List buyItems API Call */ 
                    $result = $this->blockchain->buy('api/transaction/buyItems', $buyArr);
                  

                    if(isset($result->status)){ 
                         
                        echo  json_encode(['status'=>0, 'msg-0' => $result->msg]);
                        return;

                    }else{

                        $resultDecode = json_decode($result);

                    }


                    if(isset($resultDecode)){  
                         
                        if($resultDecode->status == 'error'){
                             
                            echo  json_encode(['status'=>0, 'msg-1' => $resultDecode->msg]);
                            return;

                        }

                    }
 
                    $nftUpdateArr = [
                        'user_id'       => $bidInfo->bid_from_id,
                        'owner_wallet'  => $buyerInfo->wallet_address,
                        'status'        => 1,
                    ];
                     
                    $admin_wallet = $this->common_model->where_row('admin_wallet'); 
                    $marketPlaceFee = (($bidInfo->bid_amount * $fees) / 100) + ($admin_wallet->earned_fees);
                    
                    $this->common_model->update('admin_wallet', ['awid'=>$admin_wallet->awid], ['earned_fees'=>$marketPlaceFee]);
                    
                    $this->common_model->update('nfts_store', ['id'=>$listingVal->nft_store_id, 'token_id'=>$listingVal->nft_token_id], $nftUpdateArr);  
                    $this->common_model->update('nft_listing', ['id'=>$bidInfo->nft_listing_id], ['status'=>1]); 
                    $this->common_model->update('nft_biding', ['nft_listing_id'=>$bidInfo->nft_listing_id], ['cancel_status'=>1]);
                    $this->common_model->update('nft_biding', ['id'=>$bidInfo->id], ['cancel_status'=>0,'accept_status'=>1]);


                    /* Log save */
                    $this->common_model->nftStoreLogSave($listingVal->nft_store_id, 'buy', $result);
                    $this->common_model->saveListingLog2($listingVal->id, 1, $bidInfo->bid_from_id, $buyerInfo->wallet_address, $result);


                      
                    echo  json_encode(['status'=>1, 'msg'=>'success']);
                    return; 
  

                } else { 

                    $adminPrivateData  = $this->blockchain->privateCredential($adminInfo);  
                    $privatekey   = '';
                    $address      = '';

                    if($adminPrivateData->status === 'success'){

                        $privatekey = $adminPrivateData->data->privatekey;
                        $address = $adminPrivateData->data->address;

                    } 
  
                    $unListArr = [

                        "privateKey"      => $privatekey,   
                        "rpc_url"         => $networkdata->rpc_url, 
                        "contractAddress" => $contractAdd->contract_address, 
                        "tokenID"         => (int) $listingVal->nft_token_id, 
                        "netWork"         => $networkdata->network_slug,

                    ];

                    /* List buyItems API Call */ 
                    $result = $this->blockchain->unListForSale('api/transaction/unListingToken', $unListArr);
                    
                    if(isset($result->status)){ 
                         
                        echo  json_encode(['status'=>0, 'msg-0' => $result->msg]);
                        return;

                    }else{

                        $resultDecode = json_decode($result);

                    }


                    if(isset($resultDecode)){  
                         
                        if($resultDecode->status == 'error'){
                             
                            echo  json_encode(['status'=>0, 'msg-1' => $resultDecode->msg]);
                            return;

                        }

                    }
                    /* Expired listing */
                    $this->common_model->update('nft_listing', ['id'=>$listingVal->id], ['status'=>2]);
                    $this->common_model->update('nfts_store', ['id'=>$listingVal->nft_store_id], ['status'=>1]);


                    /* Log save */
                    $this->common_model->nftStoreLogSave($listingVal->nft_store_id, 'buy', $result);
                    $this->common_model->saveListingLog2($listingVal->id, 2);


                }
                    
            }

        }
        
        echo json_encode(['status'=>'true', 'msg'=>'Empty']);   
      
    }
  
    public function saveAuctionTnxInfo()
    { 
        $tnx_info = 100; //$this->request->getVar('tnx_info');
        $nftId = $this->request->getVar('nft_id');
        
        if($nftId){ 
            $logId = $this->common_model->nftStoreLogSave($nftId, 'buy', $tnx_info);

            if($logId){
                echo json_encode(['status'=>'success', 'msg'=>'successfully']); 
                exit; 
            }else{
                echo json_encode(['err'=>'errors', 'msg'=>'err']); 
                exit; 
            }
            

        }
         
        //$this->common_model->nftStoreLogSave($nftId, 'buy');
        
    }


    public function checkEmail($email=null)
    {
        if($email){
            $result = $this->common_model->where_row('user', ['email'=>$email]);
            if($result){
                echo json_encode(['status'=>'err', 'msg'=>'This email already exists!']); 
           }else{
                echo json_encode(['status'=>'success', 'msg'=>'Valid', 'class'=>'text-success']);
           }
            
        }else{
            echo json_encode(['status'=>'err', 'msg'=>'email not found']);
        } 
    }

    public function checkUsername($username=null)
    {
        if($username){
            $result = $this->common_model->where_row('user', ['username'=>$username]);
            if($result){
                echo json_encode(['status'=>'err', 'msg'=>'This username already exists!', 'class'=>'text-danger']); 
           }else{
                echo json_encode(['status'=>'success', 'msg'=>'Valid', 'class'=>'text-success']);
           }
            
        }else{
            echo json_encode(['status'=>'err', 'msg'=>'Username not found', 'class'=>'text-danger']);
        } 
    }
 
    public function favouriteItems(int $nft_id=null)
    {   

        if($this->userId && $nft_id){ 
            $nftInfo = $this->common_model->where_row('nfts_store', ['id' => $nft_id]);

            $inserArr = [
                'user_id'    => $this->userId,
                'nft_id'     => $nft_id,
                'network_id'     => (isset($nftInfo)) ? $nftInfo->blockchain_id : NULL,
                'created_at' => date('Y-m-d H:i:s')
            ];
            $favoriteItemInfo = $this->common_model->where_row('favorite_items', ['user_id'=>$this->userId, 'nft_id'=> $nft_id ]);

            if($favoriteItemInfo){
                $result = $this->db->table('favorite_items')->where('nft_id', $nft_id)->where('user_id', $this->userId)->delete();
                echo json_encode(['status'=>'success', 'value'=>0, 'msg'=>'favourite item save']);
            }else{
                $this->common_model->insert('favorite_items', $inserArr); 
                echo json_encode(['status'=>'success', 'value'=>1, 'msg'=>'favourite delete']);
            }
        }else{
            echo json_encode(['status'=>'err', 'msg'=>'You are not login']);
        }  
         
    }


    public function autocomplete_search($key = null)
    {
        if($key != null){
            $nfts = $this->common_model->getSearchingValues('nfts_store', 'name', ['is_minted'=>1, 'token_id !='=>0], $key);
            $collections = $this->common_model->getSearchingValues('nft_collection', 'title', [], $key);
            $returnVal = '';
            if($collections != false){ 
                $returnVal .= '<h6 class="mb-3">Collections</h6>';
                foreach ($collections as $key => $collection) { 
                    if($collection->logo_image){
                        $img = base_url().$collection->logo_image;
                    }else{
                        $img = base_url().'/public/assets/website/img/sellers/01.jpg';
                    } 
                    $url = base_url().'/collection/'.$collection->slug;
                    $returnVal .= '<a href="'.$url.'" class="creators creator-primary d-flex align-items-center mb-3">';
                    $returnVal .= '<div class="d-flex align-items-center">';
                    $returnVal .= '<div class="position-relative d-inline-flex">';
                    $returnVal .= '<img src="'.$img.'" class="avatar avatar-md-sm shadow-md rounded-pill" alt="">'; 
                    $returnVal .= '</div>';
                    $returnVal .= '<div class="ms-3">';
                    $returnVal .= '<h6 class="mb-0 fw-bold">'.$collection->title.'</h6>'; 
                    $returnVal .= '</div>';
                    $returnVal .= '</div>';
                    $returnVal .= '</a> '; 
                }
            }
            if($nfts != false){

                $returnVal2 = '';
                $returnVal2 .= '<h6 class="mb-3">Items</h6>';
                foreach ($nfts as $key => $nft) {  

                    if($nft->file){
                        $img = base_url().$nft->file;
                    }else{
                        $img = base_url().'/public/assets/website/img/sellers/01.jpg';
                    } 
                    $detail = base_url().'/nft/asset/details/'.$nft->token_id.'/'.$nft->id.'/'.$nft->contract_address;
                    $returnVal2 .= '<a href="'.$detail.'" class="creators creator-primary d-flex align-items-center mb-3">';
                    $returnVal2 .= '<div class="d-flex align-items-center">';
                    $returnVal2 .= '<div class="position-relative d-inline-flex">';
                    $returnVal2 .= '<img src="'.$img.'" class="avatar avatar-md-sm shadow-md rounded-pill" alt="">'; 
                    $returnVal2 .= '</div>';
                    $returnVal2 .= '<div class="ms-3">';
                    $returnVal2 .= '<h6 class="mb-0 fw-bold">'.$nft->name.'</h6>'; 
                    $returnVal2 .= '</div>';
                    $returnVal2 .= '</div>';
                    $returnVal2 .= '</a> '; 
                }
            
            }

            $return = '';
            $return .= isset($returnVal) ? $returnVal : '';
            $return .= isset($returnVal2) ? $returnVal2 : '';


            echo json_encode(['status'=>'success', 'data'=>$return]);
        }else{
           echo json_encode(['status'=>'err', 'msg'=>'rong']); 
        }
    }


    public function get_nft_activity()
    {


        $data['title'] = display('NFTs Activities');
        $data['content']        = view('themes/'.$this->templte_name->name.'/activity',$data); 
        return $this->template->website_layout($data); 
    }


    public function get_nft_rtankings()
    {

        $data['title'] = display('NFTs Rtankings');
        $data['content']        = view('themes/'.$this->templte_name->name.'/rtankings',$data); 
        return $this->template->website_layout($data); 
    }


    public function get_trx_info()
    {
          
        $nfts = $this->common_model->where_rows('nfts_store', array('token_id'=>null), 'id', 'asc');
        $msg = ''; 
        if($nfts){
            foreach ($nfts as $key => $value) { 

                $result = $this->blockchain->getTokenid($value->trx_hash); 
                if($result){
                    if(isset($result->data->data)){
                       $tokenid = $result->data->data;
                        $this->common_model->update('nfts_store', ['id'=>$value->id], ['token_id'=>$tokenid]);
                        $msg .= "success ".$tokenid; 
                    } 
                    else{
                        $msg .= "Nft Id = ".$value->id." this transaction is not complete!";
                    }
                }
                else{
                    $msg .= "Please try again";
                }
                
            }
        }
        else{
            $msg .= "Empty";
        }
        echo esc($msg);
        exit;
    } 

}