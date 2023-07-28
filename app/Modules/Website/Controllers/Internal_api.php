<?php 
namespace App\Modules\Website\Controllers;
class Internal_api extends BaseController
{

    /*********************
    |Websites Internal API|
    **********************/

    
    public function Settings()
    { 
        $builder       = $this->db->table('setting') ;
        $settings      = $builder->select("*")
                            ->get()
                            ->getRow();
          
        echo json_encode(array('nsetting'=> $settings));
    }

}