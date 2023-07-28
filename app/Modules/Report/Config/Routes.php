<?php

if (!isset($routes)) {
    $routes = \Config\Services::routes(true);
}

$routes->group('backend', ['filter' => 'admin_filter', 'namespace' => 'App\Modules\Report\Controllers\Admin'], function ($subroutes) {
    /*** Route for admin finance***/
    $subroutes->add('report/', 'Report::index');  
    $subroutes->add('report/report_ajax_list/', 'Report::ajax_list');  
    $subroutes->add('report/getusers/', 'Report::getUsers');  
});

