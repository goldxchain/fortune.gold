<?php 
 if(!function_exists('lan')) {
     

    function display($text = null)
    {
      
        $session = \Config\Services::session();
        $CI = db_connect();
        $table          = 'language';
        $phrase         = 'phrase';
        $language       = 'english'; 

        if($session->userdata('lang') != ''){
            $language  = $session->userdata('lang');
        }
        elseif($session->userdata('isUser')) {
            $where = array('user_id' => $session->userdata('user_id'));
            $user = $CI->table('dbt_user')->where($where)->get()->getRow();
            if($user){
                $language       = $user->lang;
            }
        }
        elseif($session->userdata('isAdmin')) {
            $where = array('id' => $session->userdata('id'));
            $admin = $CI->table('dbt_admin')->where($where)->get()->getRow();
            if($admin){
                $language       = $admin->lang;
            }
        }
        else{
            $setting        = $CI->table('setting')->get()->getRow();
            if($setting){
                $language  = $setting->language;
            }
        }

        
        if (!empty($text)) {
            $previous_text = $text;
            
            $text = trim(preg_replace("/\s*(?:[^\w\s])+/", "", $text));
            $text = str_replace(' ', '_', $text);
            $text = strtolower($text);

            if ($CI->tableExists($table)) { 
                if ($CI->fieldExists($phrase, $table)) { 
                    if ($CI->fieldExists($language, $table)) {
                        $row = $CI->table($table)
                              ->select($language)
                              ->where($phrase, $text)
                             ->get()
                             ->getRow();

                        if (!empty($row->$language)) {
                            return $row->$language;
                        } 
                    } 
                } 
            } 
            return str_replace('_', ' ', $previous_text); 
        } 

    }

    
 
}

