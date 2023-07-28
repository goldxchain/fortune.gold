<?php namespace App\Modules\Report\Models\Admin;

class Report_model {
    
    public function __construct(){
        $this->db = db_connect();
        $this->request = \Config\Services::request();

    }
    
 
	public function create($data = array())
	{
            return $this->db->insert('user', $data);
	}

	public function read($limit, $offset)
	{
             $db      = db_connect();
             return $db->query("select (CONCAT(' ', f_name, l_name) AS fullname) from user")->getResult();
	}

	public function single($uid = null)
	{

		
            $db=  db_connect();
            $builder=$db->table('user');
            return $builder->select('*')
                    ->where('uid', $uid)
                    ->get()
                    ->getRow();
	}

	public function update($data = array())
	{
		return $this->db->where('user_id', $data["user_id"])
			->update("user", $data);
	}

	public function delete($user_id = null)
	{

		return $this->db->table("user")->where('uid', $user_id)->delete();
	}

	public function dropdown()
	{
		$data = $this->db->select("user_id, CONCAT_WS(' ', f_name, l_name) AS fullname")
			->from("user")
			->where('status', 1)
			->get()
			->result();
		$list[''] = lan('select_option');
		if (!empty($data)) {
			foreach($data as $value)
				$list[$value->id] = $value->fullname;
			return $list;
		} else {
			return false; 
		}
	}


		/*
    |----------------------------------------------
    |   Datatable Ajax data Pagination+Search
    |----------------------------------------------     
    */
    
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
	 
			$builder->select($table.'.*, user.f_name, user.l_name, user.wallet_address, nft_category.cat_name, nft_collection.title as collection_title');
			$builder->selectSum('earnings.amount');
			$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
			$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
			$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
			$builder->join('earnings', 'earnings.nft_id=nfts_store.id', 'left'); 
			 
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
	
			$builder->groupBy('earnings.nft_id');
			$query = $builder->get();
	
			return $query->getResult();
		}

	function count_filtered($table,$column_order=array(),$column_search=array(),$order,$where=array())
	{
		$this->get_datatables($table,$column_order,$column_search,$order);
		
		$builder = $this->db->table($table);  
		$builder->selectSum('earnings.amount');
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('earnings', 'earnings.nft_id=nfts_store.id', 'left');
		$builder->where($where);
		$builder->groupBy('earnings.nft_id');
		return $builder->countAllResults();
	}

	public function count_all($table,$where=array())
	{
  
		$builder = $this->db->table($table);  
		$builder->selectSum('earnings.amount');
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('earnings', 'earnings.nft_id=nfts_store.id', 'left');
		$builder->where($where);
		$builder->groupBy('earnings.nft_id');
		return $builder->countAllResults();
			
	}
 	
  
	public function getFees($table,$id)
	{
    $builder = $this->db->table($table);
		return $builder->select('*')
										->where($table.'_id',$id)
										->get()
										->getRow();
	}


	public function getEarnings( $where = array() )
	{
		$table = "nfts_store";
		$builder = $this->db->table($table);    
		$builder->selectSum('earnings.amount');
		$builder->join('user', 'user.user_id=nfts_store.user_id', 'left');
		$builder->join('nft_category', 'nft_category.id=nfts_store.category_id', 'left');
		$builder->join('nft_collection', 'nft_collection.id=nfts_store.collection_id', 'left'); 
		$builder->join('earnings', 'earnings.nft_id=nfts_store.id', 'left');
		$builder->where($where);
		//$builder->groupBy('earnings.nft_id');
		$q = $builder->get();
		return $q->getRow();
	}

	
}
