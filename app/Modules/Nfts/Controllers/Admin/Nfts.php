<?php 
namespace App\Modules\Nfts\Controllers\Admin;
class Nfts extends BaseController 
{
  


    public function index()
    {    
        if($this->request->getVar('type') == 'Bid'){
          $data['title']  = display('Auction based listed NFTs');
        }
        elseif ($this->request->getVar('type') == 'Fix') {
          $data['title']  = display('Fixed sale listed NFTs');
        }else {
          $data['title']  = display('NFT List');
        }
        

        $uri = service('uri','<?php echo base_url(); ?>'); 

        #-------------------------------#
        #pagination starts
        #-------------------------------#
        $page           = ($uri->getSegment(3)) ? $uri->getSegment(3) : 0;
        $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1);
       
        $total           = $this->common_model->countRow('user');
        $data['pager']   = $this->pager->makeLinks($page_number, 20, $total);  
        #------------------------
        #pagination ends
        #------------------------

        $data['content'] = $this->BASE_VIEW . '\nfts\index';
        return $this->template->admin_layout($data);
    }

    /*
    |----------------------------------------------
    |   Datatable Ajax data Pagination+Search
    |----------------------------------------------     
    */
    public function ajax_list()
    {
        ini_set('memory_limit', '1024M');
        $table = 'nfts_store';

        $column_order = array(null, 'nfts_store.name','nfts_store.token_id','nft_category.cat_name', 'nft_collection.title', 'nfts_store.user_id', 'user.f_name', 'nfts_store.owner_wallet','nfts_store.status'); //set column field database for datatable orderable

        $column_search = array('nfts_store.name','nfts_store.token_id', 'nfts_store.user_id', 'nfts_store.owner_wallet', 'user.f_name', 'user.l_name', 'nft_category.cat_name', 'nft_collection.title'); //set column field database for datatable searchable 
        $where = array(); // default order    
        if($this->request->getVar('type') != ''){
          $where['nft_listing.auction_type'] = $this->request->getVar('type');
        }
        //'nft_listing.auction_type' => 'Bid'
        $order = array('id' => 'DESC'); // default order    
        $list = $this->nfts_model->get_datatables($table,$column_order,$column_search,$order,$where); 
      
        $data = array();
        $no = $this->request->getvar('start');
        foreach ($list as $value) {

            /** status valuse */
            $val =''; 
            if($value->status == 0){

              $val = '<div class="nftHtmlData_'.$value->id.'"><span class="btn btn-warning btn-md update-class_'.$value->id.' nftstatus_'.$value->id.'" id="channge_status_list" nftid="'.$value->id.'" nftstatus="'.$value->status.'" onclick="mfun('.$value->id.', '.$value->status.')">Pending <i class="fas fa-angle-down" ></i></span></div>';

            }else if($value->status == 1){

              $val = '<div class="nftHtmlData_'.$value->id.'"><span class="btn btn-success btn-md update-class_'.$value->id.' nftstatus_'.$value->id.'" id="channge_status_list" nftid="'.$value->id.'" nftstatus="'.$value->status.'" onclick="mfun('.$value->id.', '.$value->status.')">Verified <i class="fas fa-angle-down" ></span></div>';

            }else if($value->status == 2){

              $val = '<div class="nftHtmlData_'.$value->id.'"><span class="btn btn-danger btn-md update-class_'.$value->id.' nftstatus_'.$value->id.'" id="channge_status_list" nftid="'.$value->id.'" nftstatus="'.$value->status.'" onclick="mfun('.$value->id.', '.$value->status.')">Suspend <i class="fas fa-angle-down"></span>';}else{$val = '<span class="btn btn-info">'.display("On_Sale").' </span></div>';
            }
            /** status valuse end */

            $no++;
            $row = array();
            $row[] = $no;
            $row[] = $value->name; 
            $row[] = $value->token_id;
            $row[] = $value->cat_name;
            $row[] = $value->collection_title; 
            $row[] = $value->network_name;  
            $row[] = (isset($value->f_name)) ? $value->f_name.' '.$value->l_name : substr(esc($value->owner_wallet), 0, 5) . '...' . substr(esc($value->owner_wallet), -5);  
            if($this->request->getVar('type') != ''){
              $row[] = ($value->auction_type == 'Bid') ? 'Auction' : 'Fixed';
              $row[] = date("M j, Y, g:i a", strtotime($value->end_date));
            }
            $row[] = $val;
            $row[] = '
            <a href="'.base_url("backend/nft/details/{$value->id}").'"'.' class="btn btn-info btn-sm" data-toggle="tooltip" data-placement="left" title="Details"><i class="fas fa-book"></i></a>
            <a href="'.base_url("backend/nft/delete-nft/{$value->id}").'"'.' onclick="return confirm(\'Are you sure you want to delete this item?\');" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="left" title="Delete"><i class="fas fa-trash-alt"></i></a>
            '; 
            $data[] = $row;
        }

        $output = array(
                "draw" => intval($this->request->getvar('draw')),
                "recordsTotal" => $this->nfts_model->count_all_nft($table, $where),
                "recordsFiltered" => $this->nfts_model->count_filtered_nft($table,$column_order,$column_search,$order, $where),
                "data" => $data,
            );
        //output to json format
        echo json_encode($output);
    }

  public function nftDetails($id=null)
  {

    if (empty($id)) {
      redirect()->to(base_url('nft/list'));
    }

    $builder = $this->db->table('nfts_store');
    $builder->select('nfts_store.*, user.f_name, user.l_name, nft_category.cat_name, nft_collection.title as collection_title');
    $builder->where('nfts_store.id', $id);
    $builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
    $builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
    $builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
    $query = $builder->get(); 
    $data['info'] = $query->getRow(); 

    $data['network'] = $this->common_model->where_row('blockchain_network', array('status' => 1));
    $data['title']  = display("NFT Details");
    $data['content'] = $this->BASE_VIEW . '\nfts\details';
    return $this->template->admin_layout($data);
  } 

  public function ajax_collection($id=null)
  {
    if($id){
        $collections = $this->db->table('nft_collection')->select('id, title')->where(['user_id'=>$id])->get()->getResult(); 
        
        $cl[''] = 'Select Collection';
        foreach ($collections as $key => $value) {
            $cl[$value->id] = $value->title;
        }
        
        $att = [
          "id"=>"category",  
          "class"=>"form-control",   
          "required"=>"required"   
        ];
              
        $rt = form_dropdown('collection', $cl, '', $att); 
        echo ($rt);
    }else{
          $att = [
          "id"=>"category",  
          "class"=>"form-control",   
          "required"=>"required"   
        ];
        $cl[''] = 'Select Collection';   
        $rt = form_dropdown('collection', $cl, '', $att); 
        echo ($rt);
    } 
    
  }

  public function change_status($nftId=null, $status=null)
  {
      if (!empty($nftId)) {

        $nftInfo = $this->common_model->where_row('nfts_store', ['id'=>$nftId]);

        if($status == 2){

          $this->validation->setRule('suspend_msg', 'Message','required'); 
          if ($this->validation->withRequest($this->request)->run()){

            $suspend_msg = $this->request->getVar('suspend_msg', FILTER_SANITIZE_STRING);
            $data = ['status'=>$status, 'suspend_msg'=>$suspend_msg];

            $update = $this->common_model->update('nfts_store', ['id'=>$nftId], $data);

            if ($update) {
              $this->session->setFlashdata('message',display('save_successfully'));  
              return redirect()->to(base_url('backend/nft/details/'.$nftId)); 
            }else{
              $this->session->setFlashdata('exception', display('please_try_again')); 
              return redirect()->to(base_url('backend/nft/details/'.$nftId));
            }
          }
          else{ 
            $error=$this->validation->listErrors();
            $this->session->setFlashdata('exception', $error);
            return redirect()->to(base_url('backend/nft/details/'.$nftId));
          }

        }else{
        if($status == 1){ $v = 1; }else { $v = 0; }

        $arr =  ['status'=>$status, 'is_verified'=>$v, 'suspend_msg'=>null];
        $update = $this->common_model->update('nfts_store', ['id'=>$nftId], $arr);
        if ($update) {
          echo json_encode(['status'=>'success', 'msg'=>'updated']);
        }else{
          echo json_encode(['status'=>'err', 'msg'=>'unknown error']);
        }

      }
      }else{
        echo json_encode(['status'=>'err', 'msg'=>'your nft not found']);
      }
  }
 
  public function isFeatured(int $nftId=null, $method=null)
  {
    if($nftId==null || $method==null){
      redirect()->to(base_url());
    }

    if($nftId && $method == 'check'){

      $this->common_model->update('nfts_store', array(), ['is_featured'=>0]);
      $this->common_model->update('nfts_store', array('id'=>$nftId), ['is_featured'=>1]);

      echo json_encode(['status'=>true, 'msg'=>'Set is featured']);

    }else if($nftId){

      $this->common_model->update('nfts_store', array(), ['is_featured'=>0]);  

      echo json_encode(['status'=>true, 'msg'=>'Unset featured']);
    }
  }

  public function getAuctionCompleted()
  { 

    $data['title']  = display("auction_completed_nfts");
    $data['content'] = $this->BASE_VIEW . '\nfts\auction_completed_nfts_list';
    return $this->template->admin_layout($data);
  }

  public function ajaxAuctionCompleted()
  {
        $today = date('Y-m-d').' 23:59:00';
        $table = 'nfts_store';
        $column_order = array(null, 'nfts_store.name','nfts_store.token_id', 'nfts_store.user_id', 'nfts_store.owner_wallet','nfts_store.status'); //set column field database for datatable orderable

        $column_search = array('nfts_store.name','nfts_store.token_id', 'nfts_store.user_id', 'nfts_store.owner_wallet'); //set column field database for datatable searchable 

        $order = array('id' => 'DESC'); // default order   
        $where = array('nft_listing.end_date'=>$today, 'nft_listing.status'=> 0); // default order   
        $list = $this->nfts_model->get_datatables_compeleted_nfts($table,$column_order,$column_search,$order,$where); 
        $data = array();
        $no = $this->request->getvar('start');
        foreach ($list as $value) {

            /** status valuse */
            $val =''; 
            if($value->status == 0){
 
              $val = '<div class=""><span class="btn btn-warning btn-md">Pending </span>';

            }else if($value->status == 1){
 
               $val = '<div class=""><span class="btn btn-success btn-md">Suspend></span>';

            }else if($value->status == 2){

              $val = '<div class=""><span class="btn btn-danger btn-md">Suspend></span>';

            }else{

              $val = '<span class="btn btn-info">On sell</span></div>';
            }
            /** status valuse end */

            $no++;
            $row = array();
            $row[] = $no;
            $row[] = $value->name; 
            $row[] = $value->token_id; 
            $row[] = $value->user_id;  
            $row[] = $value->owner_wallet;  
            $row[] = $value->end_date;
            $row[] = $val; 
            $data[] = $row;
        }

        $output = array(
                "draw" => intval($this->request->getvar('draw')),
                "recordsTotal" => $this->nfts_model->count_all_nft($table, $where),
                "recordsFiltered" => $this->nfts_model->count_filtered_nft($table,$column_order,$column_search,$order, $where),
                "data" => $data,
            );
        //output to json format
        echo json_encode($output);
  }

  public function todayCompletedAuctionNfts() 
  {
 
    $endListing = $this->nfts_model->getListingWithNftstoreInfo();
    $returnArr = [];
    $mainInfo  = [];
    if(!empty($endListing)){

        $contractAdd      = $this->common_model->where_row('contract_setup', ['status'=>1]); 
        $networkdata      = $this->common_model->where_row('blockchain_network', array('status' => 1)); 
        $adminInfo        = $this->common_model->where_row('admin_wallet');
        $mainInfo         = [ 
          "rpc_url"         => $networkdata->rpc_url, 
          "contractAddress" => $contractAdd->contract_address  
        ];

        foreach ($endListing as $key => $listingVal) {

            $bidInfo    = $this->nfts_model->getAcceptableBidInfo($listingVal->id, $listingVal->nft_store_id); 
            

            if(!empty($bidInfo)){ 

                $buyerInfo  = $this->common_model->where_row('user', ['user_id' => $bidInfo->bid_from_id]);
                $fees = $this->db->table('fees_tbl')->where('level', 'sale')->get()->getRow()->fees;
                 
                $returnArr[] = [
                    "option"          => 'sell', 
                    "listing_id"      => $listingVal->id, 
                    "tokenID"         => (int) $listingVal->nft_token_id,
                    "sellPrice"       => (string) $bidInfo->bid_amount,
                    "fees"            => (int) $fees,
                    "winner"          => $buyerInfo->wallet_address, 
                    "winner_id"       => $buyerInfo->user_id, 
                    "bid_id"          => $bidInfo->id, 
                ];
 
            } else { 

                $returnArr[] = [
                    "listing_id"      => $listingVal->id, 
                    "option"          => 'unlist',
                    "tokenID"         => (int) $listingVal->nft_token_id
                ];

            }
                
        }

    }

    die(json_encode(['status' =>'success', 'data'=>$returnArr, 'maindata' =>$mainInfo])); 
    
  }

  /* 11-09-2022 - SAHIN */
  public function confirmAuctions()
  {
    
    $listId   = $this->request->getVar('listId');
    $type     = $this->request->getVar('type');
    $bid_id   = $this->request->getVar('bid_id');
    $result   = $this->request->getVar('blockchain_info');
    $winner_wallet    = $this->request->getVar('winner_wallet');
    $winner_user_id   = $this->request->getVar('winner_id');
    $fees     = $this->request->getVar('fees');
    $amount   = $this->request->getVar('amount');

    $listingInfo = $this->common_model->where_row('nft_listing', ['id' => $listId]);

    if(!empty($listId) && $type == 'sell'){
 
      $nftUpdateArr = [
          'user_id'       => $winner_user_id,
          'owner_wallet'  => $winner_wallet,
          'status'        => 1,
      ];
       
      $admin_wallet = $this->common_model->where_row('admin_wallet'); 
      $gotFee = (($amount * $fees) / 100);
      $marketPlaceFee = ($gotFee + ($admin_wallet->earned_fees));
      
      $this->common_model->update('admin_wallet', ['awid'=>$admin_wallet->awid], ['earned_fees'=>$marketPlaceFee]);
      
      $this->common_model->update('nfts_store', ['id'=>$listingInfo->nft_store_id, 'token_id'=>$listingInfo->nft_token_id], $nftUpdateArr);  
      $this->common_model->update('nft_listing', ['id'=>$listId], ['status'=>1]); 
      $this->common_model->update('nft_biding', ['nft_listing_id'=>$listId], ['cancel_status'=>1]);
      $this->common_model->update('nft_biding', ['id'=>$bid_id], ['cancel_status'=>0,'accept_status'=>1]);

      $info = [
        'fee' => $gotFee,
        'type' => 'sell',
        'nft_id' => $listingInfo->nft_store_id,
        'user_id' => $listingInfo->list_from,
      ];
      $this->nfts_model->saveEarnings($info, $result);

      /* Log save */
      $this->nfts_model->nftStoreLogSave($listingInfo->nft_store_id, 'buy', $result);
      $this->nfts_model->saveListingLog2($listingInfo->id, 1, $winner_user_id, $winner_wallet, $result);
      die(json_encode(['status' => 'success', 'msg', 'nft sale success']));
    } 
    elseif(!empty($listId) && $type == 'unlist'){

      //$data = json_decode($data);

      /* Expired listing */
      $this->common_model->update('nft_listing', ['id'=>$listId], ['status'=>2]);
      $this->common_model->update('nfts_store', ['id'=>$listingInfo->nft_store_id], ['status'=>1]); 

      /* Log save */
      $this->nfts_model->nftStoreLogSave($listingInfo->nft_store_id, 'buy', $result);
      $this->nfts_model->saveListingLog2($listId, 2); 
    }

    die(json_encode(['status' => 'success', 'msg', 'unlist success']));

  }

   
  public function deleteNft($id=null)
  {
    if (demo() === true) {
        $this->session->setFlashdata('exception', display('This_is_demo!'));
        return redirect()->to(base_url("backend/nft/list"));
    }
    if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
          return redirect()->to('admin');
    } 
    if(empty($id)) {
        return redirect()->to(base_url('backend/nft/list'));
    }
    $info = $this->common_model->where_row('nfts_store', ['id'=>$id]); 
    $file = base_url().$info->file; 
    @unlink($file);
  
    $builder = $this->db->table('nfts_store');
    $result = $builder->where(['id'=>$id])->delete();

    if($result){
        $this->session->setFlashdata('message',display('delete_successfully')); 
        return  redirect()->to(base_url('backend/nft/list')); 
    }else{ 
        $this->session->setFlashdata('exception', display('please_try_again')); 
        return  redirect()->to(base_url('backend/nft/list'));
    } 
  } 


}