<?php 
namespace App\Modules\Report\Controllers\Admin;

class Report extends BaseController {

	protected $totalAmount = 0;
    
	public function index()
	{  

		$where = array();
		if($this->request->getVar('earning_type') != ''){
			$where['earnings.txn_type'] = $this->request->getVar('earning_type');
		}
		if($this->request->getVar('category') != ''){
			$where['nfts_store.category_id'] = $this->request->getVar('category');
		}
		if($this->request->getVar('collection') != ''){
			$where['nfts_store.collection_id'] = $this->request->getVar('collection');
		}
		if($this->request->getVar('user') != ''){
			$where['earnings.user_id'] = $this->request->getVar('user');
		}
		$where['earnings.amount >'] = 0;
		$amount = $this->report_model->getEarnings($where);
		 
		 
		$data['title']  = display('NFTs_Report');
		$uri = service('uri','<?php echo base_url(); ?>'); 
		 
		$data['totalAmount']	= $this->report_model->getEarnings($where);
		$data['categories']	 	= $this->common_model->where_rows('nft_category', [], 'id', 'desc');
		$data['collections'] 	= $this->common_model->where_rows('nft_collection', [], 'id', 'desc');
		$data['users'] 				= $this->common_model->where_rows('user', [], 'uid', 'desc');
		$data['content'] 			= $this->BASE_VIEW . '\index';
		return $this->template->admin_layout($data);
	}

	/*
	|----------------------------------------------
	|   Datatable Ajax data Pagination+Search
	|----------------------------------------------     
	*/
	public function ajax_list()
	{
			$table = 'nfts_store';

			$column_order = array(null, 'nfts_store.name','nfts_store.token_id','nft_category.cat_name', 'nft_collection.title', 'nfts_store.user_id', 'user.f_name', 'nfts_store.owner_wallet','nfts_store.status'); //set column field database for datatable orderable
			$column_search = array('nfts_store.name','nfts_store.token_id', 'nfts_store.user_id', 'nfts_store.owner_wallet', 'user.f_name', 'user.l_name', 'nft_category.cat_name', 'nft_collection.title'); //set column field database for datatable searchable 
			
			$where = array();
			if($this->request->getVar('earning_type') != ''){
				$where['earnings.txn_type'] = $this->request->getVar('earning_type');
			}
			if($this->request->getVar('category') != ''){
				$where['nfts_store.category_id'] = $this->request->getVar('category');
			}
			if($this->request->getVar('collection') != ''){
				$where['nfts_store.collection_id'] = $this->request->getVar('collection');
			}
			if($this->request->getVar('user') != ''){
				$where['earnings.user_id'] = $this->request->getVar('user');
			}
			$where['earnings.amount >'] = 0;

			$order = array('id' => 'DESC'); // default order   
			 // default order   
			$list = $this->report_model->get_datatables($table,$column_order,$column_search,$order,$where); 
		 
			$data = array();
			$no = $this->request->getvar('start');
			
			foreach ($list as $value) {  
				$no++;
				$row = array();
				$row[] = $no;
				$row[] = $value->name; 
				$row[] = $value->token_id;
				$row[] = $value->cat_name;
				$row[] = $value->collection_title; 
				$row[] = (isset($value->f_name)) ? esc($value->f_name).' '.esc($value->l_name) : substr(esc($value->wallet_address), 0, 5) . '...' . substr(esc($value->wallet_address), -5);  
				$row[] = ($value->amount > 0) ? $value->amount.' '.SYMBOL() : '0.00 '.SYMBOL(); 
					

				$data[] = $row;

				/** Total Summation */
				$this->totalAmount += $value->amount;

			}

			$output = array(
					"totalAmount" => $this->totalAmount,
					"draw" => intval($this->request->getvar('draw')),
					"recordsTotal" => $this->report_model->count_all($table, $where),
					"recordsFiltered" => $this->report_model->count_filtered($table,$column_order,$column_search,$order, $where),
					"data" => $data,
			);
			//output to json format
			echo json_encode($output);
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

	public function getUsers()
	{
		$q = $this->request->getVar('q');
	 
		$builder = $this->db->table('user');
		$builder->select('*');  
		$res = $builder->get()->getResult();

		echo json_encode(['total_count' => count($res), 'items' => $res]);
		exit;
	}

}