<?php
 
$CUSTOMERMENU['nfts'] = array(
    'order'         => 3,
    'parent'        => display('NFT\'s'),
    'status'        => 1,
    'link'          => 'nfts',
    'icon'          => '<i class="fas fa-cog"></i>',
    'submenu'       => array(
            '0' => array(
                    'name'          => display('My Collection\'s'),
                    'icon'          => null,
                    'link'          => 'my_collection',
                    'segment'       => 2,
                    'segment_text'  => 'my_collection',
                ),
            '1' => array(
                    'name'          => display('My NFT\'s'),
                    'icon'          => null,
                    'link'          => 'mynft',
                    'segment'       => 2,
                    'segment_text'  => 'mynft',
                ), 
            '3' => array(
                    'name'          => display('Favorites'),
                    'icon'          => null,
                    'link'          => 'favourite_items',
                    'segment'       => 2,
                    'segment_text'  => 'favourite_items',
                ),
            ),
    'segment'       => 2,
    'segment_text'  => 'setting'
);
