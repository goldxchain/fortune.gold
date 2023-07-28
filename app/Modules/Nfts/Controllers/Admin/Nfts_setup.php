<?php 
namespace App\Modules\Nfts\Controllers\Admin;
class Nfts_setup extends BaseController 
{ 
    
	public function index()
    {

     	if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
			 return redirect()->to('admin');
		  }

        $data['title']  = display("Admin Wallet");

        #-------------------------------#
         #pagination starts
        #-------------------------------#
        $page           = ($this->uri->getSegment(3)) ? $this->uri->getSegment(3) : 0;
        $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1);
        $data['wallet'] = $this->common_model->where_row('admin_wallet');
         
        #------------------------
        #pagination ends
        #------------------------

        $data['network'] = $this->common_model->where_row('blockchain_network', $pagewhere=array('status' => 1));
        $data['file_gateway'] = $this->common_model->where_row('file_gateway');
        $data['selling_types'] = $this->common_model->where_rows('nft_selling_type', [], 'type_id','asc');
        
        $data['symbol'] = SYMBOL();
        $data['content'] = $this->BASE_VIEW . '\nft-setup\index';
        return $this->template->admin_layout($data);
    }


    public function wallet_setup()
    { 
        $exist = $this->common_model->where_row('admin_wallet');

        if(isset($exist)){
            $this->session->setFlashdata('exception','Already Exist!'); 
            return  redirect()->to(base_url('backend/nft/nft_setup'));
        }   
 

     	$data['title']  = display("Admin Wallet Setup");
     	$data['content'] = $this->BASE_VIEW . '\nft-setup\wallet_setup';
        return $this->template->admin_layout($data);
    }

    

    public function network_setup()
    { 

        if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
            return redirect()->to('admin');
        } 

        $protocol = 'http://';

        $this->validation->setRule('network_name', 'Network name','required');
        $this->validation->setRule('chain_id', 'chain id','required');
        $this->validation->setRule('currency_symbol', 'currency symbol','required');
        $this->validation->setRule('rpc_url', 'RPC','required');
        $this->validation->setRule('explorer_url', 'Blockchain explorer url','required');
        $this->validation->setRule('port', 'Port','required|alpha_numeric');
        $this->validation->setRule('server_ip', 'Server IP','required');
         
        if ($this->validation->withRequest($this->request)->run()){

            $data = [
                'network_name'      => $this->request->getVar('network_name', FILTER_SANITIZE_STRING),
                'chain_id'          => $this->request->getVar('chain_id', FILTER_SANITIZE_STRING),
                'currency_symbol'   => $this->request->getVar('currency_symbol', FILTER_SANITIZE_STRING),
                'rpc_url'           => $this->request->getVar('rpc_url', FILTER_SANITIZE_STRING),
                'explore_url'       => $this->request->getVar('explorer_url', FILTER_SANITIZE_STRING),
                'port'              => $this->request->getVar('port', FILTER_SANITIZE_STRING),
                'server_ip'         => $this->request->getVar('server_ip', FILTER_SANITIZE_STRING)
            ];

         
            $path1       = 'app/Libraries/node/server.js';
            $write1      = file_get_contents($path1);
            $existLine = "81";

            $new1  = str_replace($existLine, $this->request->getVar('port', FILTER_SANITIZE_STRING), $write1);

            // Write the new database.php file
            $handle1 = fopen($path1,'w+');

            // Chmod the file, in case the user forgot
            @chmod($path1, 0777);
            // Verify file permissions
            if (is_writable($path1)) {
                // Write the file
                if (fwrite($handle1,$new1)) {
                    @chmod($path1,0755); 
                }
            } 



            $builder = $this->db->table('blockchain_network');
            $ins = $builder->insert($data);

            if($ins){
                $this->session->setFlashdata('message',display('save_successfully')); 
                return  redirect()->to(base_url('backend/nft/nft_setup')); 
            }else{ 
                $this->session->setFlashdata('exception', display('please_try_again')); 
                return  redirect()->to(base_url('backend/nft/add_network'));
            } 
 
        }
        $error=$this->validation->listErrors();
        if($this->request->getMethod() == "post"){
            $this->session->setFlashdata('exception', $error);
            return  redirect()->to(base_url('backend/nft/add_network'));
        }
        $data['title']  = display("Network Setup");
        $data['content'] = $this->BASE_VIEW . '\nft-setup\network_setup';
        return $this->template->admin_layout($data);
    }


    public function networkUpdate($id=null)
    { 

        if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
            return redirect()->to('admin');
        } 
        if (empty($id)) {
            return redirect()->to('admin');
        }

        $protocol = 'http://';

        $info = $this->common_model->where_row('blockchain_network', array('id'=>$id));

        $this->validation->setRule('network_id', 'Network name','required');
        $this->validation->setRule('chain_id', 'chain id','required');
        $this->validation->setRule('currency_symbol', 'currency symbol','required');
        $this->validation->setRule('rpc_url', 'RPC','required');
        $this->validation->setRule('explorer_url', 'Blockchain explorer url','required');
        $this->validation->setRule('port', 'Port','required|numeric');
        $this->validation->setRule('server_ip', 'Server IP','required');

        if ($this->validation->withRequest($this->request)->run()){

            $networkId = $this->request->getVar('network_id', FILTER_SANITIZE_STRING);


            $data = [ 
                'chain_id'          => $this->request->getVar('chain_id', FILTER_SANITIZE_STRING),
                'currency_symbol'   => $this->request->getVar('currency_symbol', FILTER_SANITIZE_STRING),
                'rpc_url'           => $this->request->getVar('rpc_url', FILTER_SANITIZE_STRING),
                'explore_url'       => $this->request->getVar('explorer_url', FILTER_SANITIZE_STRING),
                'port'              => $this->request->getVar('port', FILTER_SANITIZE_STRING),
                'server_ip'         => $this->request->getVar('server_ip', FILTER_SANITIZE_STRING),
                'status'            => 1
            ];

            
            $path1       = 'app/Libraries/node/server.js';
            $write1      = file_get_contents($path1);

            if($info->port){
                $existLine = $info->port;
            }else{
                $existLine = "81";
            }
            

            $new1  = str_replace($existLine, $this->request->getVar('port', FILTER_SANITIZE_STRING), $write1);

            // Write the new database.php file
            $handle1 = fopen($path1,'w+');

            // Chmod the file, in case the user forgot
            @chmod($path1, 0777);
            // Verify file permissions
            if (is_writable($path1)) {
                // Write the file
                if (fwrite($handle1,$new1)) {
                    @chmod($path1,0755); 
                }
            } 

  
            /* disable all network disable */ 
            $this->common_model->update('blockchain_network', [], ['status'=>0]);

            /* enable target network  */ 
            $this->common_model->update('blockchain_network', ['id'=>$networkId], $data);

            /* update network wise contract address */ 
            $this->common_model->update('contract_setup', [], ['status'=>0]);
            
            $update = $this->common_model->update('contract_setup', ['network_id'=>$networkId], ['status'=>1]);

            if($update){
                $this->session->setFlashdata('message',display('save_successfully')); 
                return  redirect()->to(base_url('backend/nft/nft_setup')); 
            }else{ 
                $this->session->setFlashdata('exception', display('please_try_again')); 
                return  redirect()->to(base_url('backend/nft/update_network/'.$id));
            } 
 
        }
        $error=$this->validation->listErrors();
        if($this->request->getMethod() == "post"){
            $this->session->setFlashdata('exception', $error);
            return  redirect()->to(base_url('backend/nft/update_network/'.$id));
        } 
        $data['networkList'] = $this->common_model->where_rows('blockchain_network', [], 'id', 'desc');
        $data['network'] = $info;
        $data['title']  = "Network Update";
        $data['content'] = $this->BASE_VIEW . '\nft-setup\network_update';
        return $this->template->admin_layout($data);
    }

    public function getNetInfoAjax()
    {
        $netId  = $this->request->getVar("id");
        $info   = $this->common_model->where_row('blockchain_network', ['id' => $netId]);
        if(!empty($info)){
            die(json_encode(['status' => 'success', 'data' => $info]));
            exit;
        }else{
           die(json_encode(['status' => 'success', 'data' => $info]));
            exit; 
        }
         
    }

    public function wallet_balance()
    { 
        $balance    = $this->request->getVar('balance');
        $wallet     = $this->request->getVar('wallet_address'); 
        echo json_encode(['status' =>'success', 'msg'=>'update successfully']);  
        $update = $this->common_model->update('admin_wallet', ['wallet_address'=>$wallet], ['balance'=> $balance]); 
        if($update){ 
        }else{
            echo json_encode(['status' =>'error', 'msg'=>'error']); 
        } 
    }
 
    public function contract_setup()
    {
        $data['network']    = $this->common_model->where_row('blockchain_network', array('status' => 1));
        $data['info']       = $this->common_model->where_row('contract_setup', ['status'=>1, 'network_id' => $data['network']->id]);
        $data['title']      = display("Contract Setup");
        $data['purchase_info']   = $this->common_model->where_row('envato_purchase_info', []);

        $data['content'] = $this->BASE_VIEW . '\nft-setup\contract_setup';
        return $this->template->admin_layout($data);
    }


    public function contract_delete($id = null)
    {   
        if (demo() === true) {
            $this->session->setFlashdata('exception', display('This_is_demo!'));
            return redirect()->to(base_url($_SERVER['HTTP_REFERER']));
        } 

        $where=array(
            'id'  =>   $id
        );

        if ($this->common_model->deleteRow('contract_setup',$where)) {
          $this->session->setFlashdata('message', display('delete_successfully'));
        } else {
          $this->session->setFlashdata('exception', display('please_try_again'));
        }
        return  redirect()->to(base_url('backend/nft/contract'));
        
    }

    public function adminwallet_delete($id = null)
    {  
        if (demo() === true) {
            $this->session->setFlashdata('exception', display('This_is_demo!'));
            return redirect()->to(base_url($_SERVER['HTTP_REFERER']));
        } 

        $where=array(
            'awid'  =>   $id
        );
        if ($this->common_model->deleteRow('admin_wallet',$where)) {
          $this->session->setFlashdata('message', display('delete_successfully'));
        } else {
          $this->session->setFlashdata('exception', display('please_try_again'));
        }
        return  redirect()->to(base_url('backend/nft/nft_setup'));
        
    }

    public function contract_setup_ajax()
    {
        /**  contract deploy */
        $networkdata        = $this->common_model->where_row('blockchain_network', array('status' => 1)); 
        $adminWalletInfo    = $this->common_model->where_row('admin_wallet');  
 
         
        if(!empty($this->request->getVar('contractName', FILTER_SANITIZE_STRING))){

            $this->common_model->update('contract_setup', [], ['status' => 0]);
              
            $data = [
                'contract_name'     => $this->request->getVar('contractName', FILTER_SANITIZE_STRING),
                'contract_symbol'   => $this->request->getVar('contractSymbol', FILTER_SANITIZE_STRING),
                'max_token_supply'  => $this->request->getVar('gotMaxTokenSupply', FILTER_SANITIZE_STRING),
                'contract_address'  => $this->request->getVar('contract_address', FILTER_SANITIZE_STRING),
                'tnx_hash'          => $this->request->getVar('tnx_hash', FILTER_SANITIZE_STRING),
                'status'            => '1',
                'network_id'        => $networkdata->id,
                'create_at'         => date('Y-m-d H:i:s')
            ];

            $insertId = $this->common_model->save_return_id('contract_setup', $data);  

              
            if($insertId){ 
               echo json_encode(['status' => 'success', 'msg' => 'Successfully deployed your contract']);
               exit;
            }else{
                echo json_encode(['status' => 'err', 'msg' => 'please try again']);
                exit;
            } 

        }else{ 

            echo json_encode(['status' => 'err', 'msg' => 'please try again', 'message' => '']);
            exit;

        }
 
    }

    public function getAdminWallet()
    {
        $info = $this->common_model->where_row('admin_wallet');
        
        if(!empty($info)){
            echo json_encode(['status'=>'success', 'data'=>$info]);
        }else {
            echo json_encode(['status'=>'err', 'msg'=>'Data not found!']);
        }
    }
  
    public function type_status_change($typeId=null, $status=null)
    {
        if (!empty($typeId)) {

          $typeInfo = $this->common_model->where_row('nft_selling_type', ['type_id'=>$typeId]);

          $update = $this->common_model->update('nft_selling_type', ['type_id'=>$typeId], ['status'=>$status]);
          if ($update) {
            echo json_encode(['status'=>'success', 'msg'=>'updated']);
          }else{
            echo json_encode(['status'=>'err', 'msg'=>'unknown error']);
          }

        
        }else{
          echo json_encode(['status'=>'err', 'msg'=>'your nft not found']);
        }
    }

    public function saleTypeControl()
    {
        if (!$this->session->get('isLogIn') && !$this->session->get('isAdmin')) {
             return redirect()->to('admin');
          } 

        $data['title']  = display("Admin Wallet");

        #-------------------------------#
         #pagination starts
        #-------------------------------#
        $page           = ($this->uri->getSegment(3)) ? $this->uri->getSegment(3) : 0;
        $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1);
        $data['wallets'] = $this->common_model->get_all('admin_wallet', $pagewhere=array(),20,($page_number-1)*20,'awid','desc');
       
        #------------------------
        #pagination ends
        #------------------------

        $data['networks'] = $this->common_model->get_all('blockchain_network', $pagewhere=array(['status' => 1]),20,($page_number-1)*20,'id','desc');
        $data['file_gateway'] = $this->common_model->where_row('file_gateway');
        $data['selling_types'] = $this->common_model->where_rows('nft_selling_type', [], 'type_id','asc');
         
        $data['content'] = $this->BASE_VIEW . '\nft-setup\sale_type_control';
        return $this->template->admin_layout($data);
    }

    public function encriptAdminWalletPrivateKey()
    {

        $encryptinfo = $this->request->getPost();
        
        unset($encryptinfo['csrf_test_name']);

        $exist = $this->common_model->where_row('admin_wallet');

        if(!isset($exist)){

            $builder    = $this->db->table('admin_wallet');
            $result     = $builder->insert($encryptinfo); 
            $id         = $this->db->insertID();
            if(!empty($id)){
                echo json_encode(['status'=>'success','msg'=>'Successfully saved!']);
            }else{
                 echo json_encode(['status'=>'error','msg'=>"Try again!"]);
            }
        }else{
            echo json_encode(['status'=>'error','msg'=>"Exist!"]);
        }
    }

    public function get_purchase_info(){ 
 
        $this->validation->setRule('purchase_key', 'Purchase Key','required'); 
 
        if ($this->validation->withRequest($this->request)->run()){  
 
            $product_key    = '38375099'; //nftbox
            $purchase_key   = $this->request->getVar('purchase_key', FILTER_SANITIZE_STRING); 
     
            $personalToken  = "vbAD8aVRIUE3tOqT7RXAGnWScodpM2Ty"; 
            $userAgent      = "Purchase code verification";  
     
            
            // Make sure the code is valid before sending it to Envato: 
            if (!preg_match("/^(\w{8})-((\w{4})-){3}(\w{12})$/", $purchase_key)) 
                return false; 
                 
     
            $ch = curl_init(); 
            curl_setopt_array($ch, array( 
                CURLOPT_URL => "https://api.envato.com/v3/market/author/sale?code=$purchase_key", 
                CURLOPT_RETURNTRANSFER => true, 
                CURLOPT_TIMEOUT => 20, 
                 
                CURLOPT_HTTPHEADER => array( 
                    "Authorization: Bearer {$personalToken}", 
                    "User-Agent: {$userAgent}" 
                ) 
            )); 
             
            // Execute CURL with warnings suppressed: 
            $response = @curl_exec($ch); 
     
          
            if (curl_errno($ch) > 0)  
                return false; 
             
            // Validate response: 
            $responseCode = curl_getinfo($ch, CURLINFO_HTTP_CODE); 
             
            if ($responseCode !== 200) { 
                echo json_encode([ 
                    'status' => 404, 
                    'errors' => "Connection Error" 
                ]); 
            } 
 
            $body = json_decode($response); 
             
            if($body->purchase_count > 0) { 
                
                $envato_purchase_data = [   
                    'product_key'       => $product_key, 
                    'purchase_key'      => $purchase_key, 
                    'sold_at'           => $body->sold_at, 
                    'supported_until'   => $body->supported_until, 
                    'item_name'         => $body->item->name, 
                    'item_id'           => $body->item->id, 
                ];  
                $builder    = $this->db->table('envato_purchase_info'); 
                $builder->insert($envato_purchase_data); 
 
                $data = []; 
                $data['network']    = $this->common_model->where_row('blockchain_network', array('status' => 1)); 
                $data['info']       = $this->common_model->where_row('contract_setup', ['status'=>1]); 
 
                echo json_encode([ 
                    'status'    => 200, 
                    'message'   => "Purchase Validation successfully", 
                    'view'      => view($this->BASE_VIEW . '\nft-setup\contract_setup_network', $data) 
                ]); 
                exit;
 
            }  
            else { 
                echo json_encode([ 
                    'status' => 402, 
                    'message' => "Invalid Credential" 
                ]); 
            } 
     
        } 
        else{ 
            $errors = $this->validation->getErrors(); 
            echo json_encode([ 
                'status' => 422, 
                'errors' => $errors 
            ]); 
        } 
    }
 
}
