<?php 
 
$ADMINMENU['finance'] = array(
    'order'         => 7,
    'parent'        => display('Finance'),
    'status'        => 1,
    'link'          => 'customers',
    'icon'          => '<i class="fa fa-coins"></i>',
    'submenu'       => array(
                
                '0' => array(
                    'name'          => display('Finance'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'customers/biding_deposit',
                    'segment'       => 3,
                    'segment_text'  => 'biding_deposit',
                ),
                
    ),
    'segment'       => 2,
    'segment_text'  => 'user'
);