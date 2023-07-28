<?php 
namespace App\Modules\Finance\Controllers\Admin;

class Finance extends BaseController {
    
     
    public function index()
	{   

	    $uri = service('uri','<?php echo base_url(); ?>');
	    #-------------------------------#
	    #pagination starts
	    #-------------------------------#

	    $page           = ($uri->getSegment(3)) ? $uri->getSegment(3) : 0;
	    $page_number    = (!empty($this->request->getVar('page'))?$this->request->getVar('page'):1);

	    $data['info']  = $this->common_model->get_all('user_transaction',array(),20,($page_number-1)*20,'tr_id','desc');

	    $total           = $this->common_model->countRow('user_transaction');
	    $data['pager']   = $this->pager->makeLinks($page_number, 20, $total);  

	    #------------------------
	    #pagination ends
	    #------------------------

	    $data['contractInfo'] = $this->common_model->where_row('contract_setup', ['status' => 1]); 
	    $data['networkInfo'] = $this->common_model->where_row('blockchain_network', ['status' => 1]); 
	    $data['title']      = display('customers_withdraw_request_list'); 
	    $data['content'] 	= $this->BASE_VIEW . '\customers\index';

	    return $this->template->admin_layout($data);
	}

	public function transcation_complete()
	{
		$trId = $this->request->getVar("transaction_id");
		$trx = $this->request->getVar("trx");
	    $info = $this->common_model->where_row('user_transaction', ['tr_id' => $trId, 'status'=> 0]); 
	    if(empty($info)){
	    	die(json_encode(['status' => 'error']));
	    }
		if($trId){
			$arr = [ 
				'trx' 			=> $trx,
				'status' 		=> 1, 
				'updated_at' 	=> date('Y-m-d H:i:s'),
			];

			$this->common_model->update('user_transaction', ['tr_id' => $trId], $arr);
			die(json_encode(['status' => 'success']));
		}
		die(json_encode(['status' => 'error']));
	}

}