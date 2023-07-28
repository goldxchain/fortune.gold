<?php  

function SYMBOL(){
	$db 	= db_connect();
	$where 	= ['status' => 1];
	$info 	= $db->table('blockchain_network')->where($where)->get()->getRow();

	if(isset($info))
		return $info->currency_symbol;
	else
		return '';
}


function demo(){

  return false;
}

function getNetworkId(){

	$db 		= db_connect();
	$where 	= ['status' => 1];
	$info 	= $db->table('blockchain_network')->where($where)->get()->getRow();
	
	if(isset($info))
		return $info->id;
	else
		return null;
} 

