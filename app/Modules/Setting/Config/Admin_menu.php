<?php

$ADMINMENU['setting'] = [
    'order'        => 15,
    'parent'       => display('Setting'),
    'status'       => 1,
    'link'         => 'setting',
    'icon'         => '<i class="fas fa-cog"></i>',
    'submenu'      => [
        '1' => [
            'name'         => display('App Setting'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'setting/app_setting',
            'segment'      => 3,
            'segment_text' => 'app_setting',
        ],

        '2' => [
            'name'         => display('Fees Setting'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'setting/fees_setting',
            'segment'      => 3,
            'segment_text' => 'fees_setting',
        ],
        '3' => [
            'name'         => display('Selling Type'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'nft/sale_type_control',
            'segment'      => 3,
            'segment_text' => 'sale_type_control',
        ],

        '6' => [
            'name'         => display('Email Gateway'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'setting/email_gateway',
            'segment'      => 3,
            'segment_text' => 'email_gateway',
        ],

        '7' => [
            'name'         => display('External API'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'externalapi/api_list',
            'segment'      => 3,
            'segment_text' => 'api_list',
        ],

        '8' => [
            'name'         => display('Email Template'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'setting/smsemail_template',
            'segment'      => 3,
            'segment_text' => 'smsemail_template',
        ],

        '9' => [
            'name'         => display('language_setting'),
            'icon'         => '<i class="fa fa-arrow-right"></i>',
            'link'         => 'language/language_list',
            'segment'      => 3,
            'segment_text' => 'language_list',
        ],

    ],
    'segment'      => 2,
    'segment_text' => 'setting',
];