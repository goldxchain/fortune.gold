<?php

if (!isset($routes)) {
    $routes = \Config\Services::routes(true);
}

$routes->group('backend', ['filter' => 'admin_filter', 'namespace' => 'App\Modules\Finance\Controllers\Admin'], function ($subroutes) {
    /*** Route for admin finance***/
    $subroutes->add('customers/biding_deposit/', 'Finance::index'); 
    $subroutes->add('customers/transcation-omplete/', 'Finance::transcation_complete'); 
});

