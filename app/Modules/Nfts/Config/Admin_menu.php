<?php


$ADMINMENU['nft_setup'] = array(
    'order'         => 4,
    'parent'        => display('NFT Setup'),
    'status'        => 1,
    'link'          => 'NFT Setup',
    'icon'          => '<i class="fa fa-cogs"></i>',
    'submenu'       => array(
                
                '0' => array(
                    'name'          => display('NFT Setup'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/nft_setup',
                    'segment'       => 3,
                    'segment_text'  => 'nft_setup','add_network'
                ),
                '1' => array(
                    'name'          => display('Contract Deploy'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/contract',
                    'segment'       => 3,
                    'segment_text'  => 'contract'
                ),
                      
    ),
    'segment'       => 2,
    'segment_text'  => 'nft_setup'
);

$ADMINMENU['nfts'] = array(
    'order'         => 3,
    'parent'        => display('NFT\'s'),
    'status'        => 1,
    'link'          => 'nft-list',
    'icon'          => '<i class="fa fa-braille"></i>',
    'submenu'       => array( 
                 
                '0' => array(
                    'name'          => display('NFT List'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/list',
                    'segment'       => 3,
                    'segment_text'  => 'list'
                ),
                '1' => array(
                    'name'          => display('Auctioned_NFTs'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/auctioned-nfts?type=Bid',
                    'segment'       => 3,
                    'segment_text'  => 'auctioned-nfts'
                ),
                '2' => array(
                    'name'          => display('Fixed_Sale_NFTs'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/fixed-sale-nfts?type=Fix',
                    'segment'       => 3,
                    'segment_text'  => 'fixed-sale-nfts'
                ),
                '3' => array(
                    'name'          => display('todays_sale_end'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/auction-completed-nfts',
                    'segment'       => 3,
                    'segment_text'  => 'auction-completed-nfts'
                ),
                '4' => array(
                    'name'          => display('Categories'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/categories',
                    'segment'       => 3,
                    'segment_text'  => 'categories'
                ),
                '5' => array(
                    'name'          => display('Add Category'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/add_category',
                    'segment'       => 3,
                    'segment_text'  => 'add_category'
                ),
                '6' => array(
                    'name'          => display('Collections'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/collections',
                    'segment'       => 3,
                    'segment_text'  => 'collections', 'update_collection'
                ),
                '7' => array(
                    'name'          => display('Add Collection'),
                    'icon'          => '<i class="fa fa-arrow-right"></i>',
                    'link'          => 'nft/add_collection',
                    'segment'       => 3,
                    'segment_text'  => 'add_collection'
                ),  
               
                
    ),
    'segment'       => 2,
    'segment_text'  => 'nft_setup'
);