  
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
            <div class="card-body">
                <div class="main-content">
       
                <?php echo form_open('#',array('id'=>'ajaxusercompletedform_nft','name'=>'ajaxusercompletedform_nft')); ?>

                <div class="complete-auction-btn text-right">
                    <button type="button" class="btn btn-lg btn-warning mb-2" id="complete_today_auction"><?php echo display('click_to_todays_sale_list'); ?></button> 
                </div>

                <div class="table-responsive">
                    <table id="ajaxtable_completed" class="table  table-bordered table-striped table-hover">
                       <thead>
                            <tr> 
                                <th><?php echo display('sl_no') ?></th> 
                                <th><?php echo display('NFT_Name'); ?></th> 
                                <th><?php echo display('Token_Id'); ?></th> 
                                <th><?php echo display('User_Id'); ?></th>  
                                <th><?php echo display('User_Wallet'); ?></th>   
                                <th><?php echo display('Auction_Ends'); ?></th>   
                                <th width="100px"><?php echo display('Status'); ?></th> 
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
<script src="<?php echo base_url(); ?>/public/assets/website/js/ethers-5.2.umd.min.js"></script> 
<script src="<?php echo base_url("/public/assets/website/js/bytecode.js") ?>"></script>
<script src="<?php echo base_url("/public/assets/website/js/abi.js") ?>"></script>
<script src="<?php echo base_url("app/Modules/Nfts/Assets/Admin/js/custom.js") ?>"></script>