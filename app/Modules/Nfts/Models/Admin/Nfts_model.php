<?php 

namespace App\Modules\Nfts\Models\Admin;

class Nfts_model  {
    
    public function __construct(){
        $this->db = db_connect();
        $this->request = \Config\Services::request();

    }

    public function create($data = array())
	{
            return $this->db->insert('user', $data);
	}

	function get_datatables($table,$column_order=array(),$column_search=array(),$order,$where=array())
	{ 
  		
    $builder = $this->db->table($table); 
		$i = 0; 
		foreach ($column_search as $item)
		{
             
      if(!empty($_POST)){   
				if($_POST['search']['value']) 
				{
	                            
	                                
					if($i===0) 
					{
						$builder->groupStart(); 
						$builder->like($item, $_POST['search']['value']);
					}
					else
					{
						$builder->orLike($item, $_POST['search']['value']);
					}

					if(count($column_search) - 1 == $i) 
						$builder->groupEnd(); 
				}
			}
			$i++;
		}
		
		$builder->select($table.'.*, user.f_name, user.l_name, nft_category.cat_name, nft_collection.title as collection_title, blockchain_network.network_name, nft_listing.auction_type, nft_listing.end_date');
		 
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('blockchain_network', 'blockchain_network.id=nfts_store.blockchain_id', 'left'); 
		$builder->join('nft_listing', 'nft_listing.nft_store_id=nfts_store.id AND nft_listing.status = 0', 'left'); 
		 
		if($where != null) // here order processing
		{
			$builder->where($where);
		}

		if(isset($_POST['order'])) // here order processing
		{
			$builder->orderBy($column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
		} 
		else if(isset($order))
		{
			$order = $order;
			$builder->orderBy(key($order), $order[key($order)]);
		}
		if($this->request->getvar('length') != -1)
		$builder->limit($this->request->getvar('length'), $this->request->getvar('start'));
		$query = $builder->get();

		return $query->getResult();
	}

	function get_datatables_compeleted_nfts($table,$column_order=array(),$column_search=array(),$order,$where=array())
	{ 
  		
        $builder = $this->db->table($table);
		$i = 0;

		foreach ($column_search as $item)
		{
             
            if(!empty($_POST)){   
				if($_POST['search']['value']) 
				{
	                            
	                                
					if($i===0) 
					{
						$builder->groupStart(); 
						$builder->like($item, $_POST['search']['value']);
					}
					else
					{
						$builder->orLike($item, $_POST['search']['value']);
					}

					if(count($column_search) - 1 == $i) 
						$builder->groupEnd(); 
				}
			}
			$i++;
		}
		
		$builder->select($table.'.*, nft_listing.end_date');
		$builder->join('nft_listing', 'nft_listing.nft_store_id=nfts_store.id', 'left'); 
		 
		if($where != null) // here order processing
		{
			$builder->where($where);
		}

		if(isset($_POST['order'])) // here order processing
		{
			$builder->orderBy($column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
		} 
		else if(isset($order))
		{
			$order = $order;
			$builder->orderBy(key($order), $order[key($order)]);
		}
		$builder->groupBy($table.'.id');
		if($this->request->getvar('length') != -1)
		$builder->limit($this->request->getvar('length'), $this->request->getvar('start'));
		$query = $builder->get();

		return $query->getResult();
	}

	public function count_all_nft($table,$where=array())
	{
		$builder = $this->db->table($table);
		$builder->select($table.'.*, user.f_name, user.l_name, nft_category.cat_name, nft_collection.title as collection_title, blockchain_network.network_name, nft_listing.auction_type, nft_listing.end_date');
		 
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('blockchain_network', 'blockchain_network.id=nfts_store.blockchain_id', 'left'); 
		$builder->join('nft_listing', 'nft_listing.nft_store_id=nfts_store.id AND nft_listing.status = 0', 'left'); 
		 
		if($where != null) // here order processing
		{
			$builder->where($where);
		}
		return $builder->countAllResults();
			
	}

	function count_filtered_nft($table,$column_order=array(),$column_search=array(),$order,$where=array())
	{
		$this->get_datatables($table,$column_order,$column_search,$order);

		$builder = $this->db->table($table);
		$builder->select($table.'.*, user.f_name, user.l_name, nft_category.cat_name, nft_collection.title as collection_title, blockchain_network.network_name, nft_listing.auction_type, nft_listing.end_date');
		 
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('blockchain_network', 'blockchain_network.id=nfts_store.blockchain_id', 'left'); 
		$builder->join('nft_listing', 'nft_listing.nft_store_id=nfts_store.id AND nft_listing.status = 0', 'left'); 
		 
		if($where != null) // here order processing
		{
			$builder->where($where);
		}
		return $builder->countAllResults(); 
	}


	public function count_all($table,$where=array())
	{

		$db      = db_connect();
		$builder = $db->table($table);
		$builder->where($where);
		return $builder->countAllResults();
			
	}

	function count_filtered($table,$column_order=array(),$column_search=array(),$order,$where=array())
	{
		$this->get_datatables($table,$column_order,$column_search,$order);
		$db      = db_connect();
		$builder = $db->table($table);
		$builder->where($where);
		return $builder->countAllResults();
	}

	public function getListingWithNftstoreInfo()
	{

			$result = $this->db->query("SELECT `dbt_nft_listing`.*, `dbt_nfts_store`.`id` as `nftId`, `dbt_nfts_store`.`contract_address`, `dbt_nfts_store`.`status` as `nftStatus` FROM `dbt_nft_listing` JOIN `dbt_nfts_store` ON `dbt_nfts_store`.`id`=`dbt_nft_listing`.`nft_store_id` WHERE DATE_FORMAT(end_date,'%d') = DATE_FORMAT(CURRENT_DATE, '%d') AND `dbt_nft_listing`.`status` = 0;")->getResult();
				
			if(!empty($result)){
					return $result;
			}else{
					return array();
			} 
	}

    public function getAcceptableBidInfo($listingId, $nft_id)
    {
        $bidInfo = $this->db->table('nft_biding')
        ->select('*')
        ->where(['nft_listing_id'=>$listingId, 'nft_id'=> $nft_id, 'cancel_status'=> 0, 'accept_status'=> 0])
        ->orderBy('bid_amount', 'DESC')->get()->getRow();

        if(!empty($bidInfo)){
            return $bidInfo;
        }else{
            return array();
        }
    }


    public function nftStoreLogSave($id = null, $status = null, $tnx = null)
    { 
        if(empty($id)){
            return false;
        }
        $nftInfo = $this->db->table('nfts_store')->where(['id'=>$id])->get()->getrow(); 

        $nftInfo->store_id  = $nftInfo->id;
        $nftInfo->ownership = $status; 
        $nftInfo->trx       = json_encode($tnx);  
         
        unset($nftInfo->id); 
        $this->db->table('nfts_store_log')->insert((array) $nftInfo);
        return $this->db->insertID();  
    }

    public function saveListingLog2(int $id, int $status, $buyer_id=null, $buyer_wallet=null, $tnx = null)
    {
        $data = $this->db->table('nft_listing')->where(['id'=>$id])->get()->getrow(); 

        $data->listing_id   = $data->id;
        $data->status       = $status; 
        $data->buyer_id     = $buyer_id; 
        $data->buyer_wallet = $buyer_wallet; 
        $data->trx_info     = json_encode($tnx); 
        $data->created_at   = date('Y-m-d H:i:s'); 
        unset($data->id);  

        $this->db->table('nft_listing_log')->insert((array) $data);
        return $this->db->insertID(); 
    }

		public function saveEarnings($info = [], $tnxInfo=NULL)
    { 
        $data = [
            'user_id'       => $info['user_id'],
            'txn_type'      => $info['type'],
            'amount'        => $info['fee'],
            'nft_id'        => $info['nft_id'],
            'tnx_info'      => $tnxInfo,    
            'created_at'    => date('Y-m-d H:i:s'),
        ];

        $this->db->table('earnings')->insert($data);  
    }



}