<?php 
 
$ADMINMENU['report'] = array(
    'order'         => 9,
    'parent'        => display('Report'),
    'status'        => 1,
    'link'          => 'report',
    'icon'          => '<i class="fa fa-coins"></i>',
    'submenu'       => array(
                
                '0' => array(
                    'name'          => display('Report'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'report',
                    'segment'       => 2,
                    'segment_text'  => 'report',
                ),
                
    ),
    'segment'       => 2,
    'segment_text'  => 'report'
);