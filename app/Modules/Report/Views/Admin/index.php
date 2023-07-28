<?php 
$security = \Config\Services::security();
helper('form');
?>

<div class="row">
    <div class="col-md-12 col-lg-12">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fs-17 font-weight-600 mb-0"><?php echo (!empty($title)?esc($title):null) ?></h6>
                    </div>
                     
                    <div class="text-right">
                        <div class="actions">
                            <a href="#" class="action-item"><i class="ti-reload"></i></a>
                        </div>
                    </div>
                </div>
            </div> 
            <form class=""> 
            <div class="card-body row col-md-12 col-lg-12">
               
                <div class="form-group col-md-2">
                <label for="category" class="">Type</label>
                    <?php 
                    $earning_type   = isset($_GET['earning_type']) ? $_GET['earning_type'] : '';
                    $category_id       = isset($_GET['category']) ? $_GET['category'] : '';
                    $collection_id     = isset($_GET['collection']) ? $_GET['collection'] : '';
                    $user_id           = isset($_GET['user']) ? $_GET['user'] : '';
                     
                    $att = ['class' => 'form-select dont-select-me form-control', 'id' => 'earning_type'];
                    $op = ['' => 'Select Type', 'transfer' => 'Transfer', 'sell' => 'Sale'];
                    echo form_dropdown('earning_type', $op, $earning_type, $att); 
                    ?>
                </div>
                <div class="form-group col-md-2">
                    <label for="category" class="">Category </label>
                    <?php 
                    $att = ['class' => 'form-select dont-select-me form-control', 'id' => 'category'];
                    $ca[''] = 'Select Category'; 
                    foreach ($categories as $key => $category) {
                        $ca[$category->id] = $category->cat_name;
                    } 
                    echo form_dropdown('category', $ca, $category_id, $att); 
                    ?>
                </div>
                <div class="form-group col-md-2">
                    <label for="collection" class="">Collection</label>
                    <?php 
                    $att = ['class' => 'select2 form-control', 'id' => 'collection'];
                    $co[''] = 'Select collection'; 
                    foreach ($collections as $key => $collection) {
                        $co[$collection->id] = $collection->title;
                    }
                    echo form_dropdown('collection', $co, $collection_id, $att); 
                    ?>
                </div>
                <div class="form-group col-md-2">
                    <label for="User" class="">Customer</label>
                    <?php 
                    $att = ['class' => 'form-control select2', 'id' => 'user_val', 'data-placeholder' => 'Select Customer'];
                    $us[''] = 'Select Customer';  
                    foreach ($users as $key => $user) {
                        $us[$user->user_id] = (isset($user->f_name)) ? esc($user->f_name).' '.esc($user->l_name) : substr(esc($user->wallet_address), 0, 5) . '...' . substr(esc($user->wallet_address), -5);
                    }
                    echo form_dropdown('user', $us, $user_id, $att); 
                    ?>
                </div>
 
 
                <div class="col-md-2 form-group mt-4 pt-2">
                    <button type="submit" value='submit' class="btn btn-info">Search</button>
                </div>
                
            </div> 
            </form>
            <div class="card-body col-md-6 col-lg-6">
                <table class="table table-bordered table-striped table-hover">
                     
                    <tr class="">
                        <th class="">Total </th> 
                        <td><?php echo (isset($totalAmount)) ? number_format(esc($totalAmount->amount), 3, '.', ',').' '.SYMBOL() : ' 0.00'.' '.SYMBOL(); ?></td>
                        
                    </tr>
                </table>
            </div> 
                     
            <div class="card-body">
                <?php echo form_open('#',array('id'=>'ajaxusertableform_nft','name'=>'ajaxusertableform_nft')); ?>
                
                <div class="table-responsive">
                    <table id="ajaxtable_nft" class="table table-bordered table-striped table-hover">
                       <thead>
                            <tr> 
                                <th><?php echo display('sl_no') ?></th> 
                                <th><?php echo display('NFT_Title'); ?></th> 
                                <th><?php echo display('Token_Id'); ?></th>
                                <th><?php echo display('Category'); ?></th>
                                <th><?php echo display('Collection'); ?></th>
                                <th><?php echo display('Customer'); ?></th> 
                                <th><?php echo display('Earned_Fee'); ?></th>  
                            </tr>
                        </thead>
                        <tbody>  
                        </tbody>  
                    </table>
                   
                </div>
                <?php echo form_close(); ?>
            </div> 

        </div>
    </div>

</div>
 

<script src="<?php echo base_url("public/assets/plugins/datatables/dataTables.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/dataTables.bootstrap4.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/dataTables.responsive.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/responsive.bootstrap4.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/dataTables.buttons.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/buttons.bootstrap4.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/jszip.min.js") ?>"></script>

<script src="<?php echo base_url("public/assets/plugins/datatables/pdfmake.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/vfs_fonts.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/buttons.html5.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/buttons.print.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/buttons.colVis.min.js") ?>"></script>
<script src="<?php echo base_url("public/assets/plugins/datatables/data-bootstrap4.active.js") ?>"></script>
<script src="<?php echo base_url("app/Modules/Report/Assets/Admin/js/custom.js") ?>"></script>