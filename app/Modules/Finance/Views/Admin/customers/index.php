<div class="row">
    <div class="col-md-12 col-lg-12">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fs-17 font-weight-600 mb-0"><?php echo (!empty($title)?esc($title):null) ?></h6> 
                        <input type="hidden" id="market_contract" name="marketcontract" value="<?php echo (isset($contractInfo->contract_address)) ? esc($contractInfo->contract_address) : ''; ?>">
                        <input type="hidden" id="network_rpc" name="marketcontract" value="<?php echo (isset($networkInfo->rpc_url)) ? esc($networkInfo->rpc_url) : ''; ?>">
                    </div> 
                </div>
            </div>            
            <div class="card-body">
                <div class="table-responsive">
                    <table id="example" class="table  table-bordered table-striped table-hover">
                        <thead>
                            <tr>
                                <th ><?php echo display('sl_no'); ?></th>
                                <th ><?php echo display('to_wallet'); ?></th>
                                <th><?php echo display('amount'); ?></th> 
                                <th><?php echo display('status'); ?></th>
                                <th class="text-center"><?php echo display('action'); ?></th> 
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($info)) ?>
                            <?php $sl = 1; ?>
                            <?php foreach ($info as $value) { ?>
                            <tr>
                                <td><?php echo esc($sl++); ?></td> 
                                
                                <td><?php echo esc($value->to_wallet); ?></td>
                                <td><?php echo esc($value->amount); ?></td> 
                                <td><?php echo ((esc($value->status==1))?display('Approved'):display('Pending')); ?></td>

                                <td class="text-center">
                                    <?php if($value->status == 0){ ?>
                                    <div class="trnscation_btn_<?php echo $value->tr_id; ?>">
                                        <button type="button" class="approve_trnscation btn btn-warning btn-sm" to_wallet="<?php echo $value->to_wallet; ?>" send_amount="<?php echo $value->amount; ?>"  transaction_id="<?php echo $value->tr_id; ?>">Approve</button> 
                                    </div>  
                                    <?php } else{ ?>
                                        <button type="button" class="btn btn-success btn-sm"><i class="fa fa-check-double"></i>Approved</button>
                                    <?php } ?>


                                </td>
                            </tr>
                            <?php } ?> 
                        </tbody>
                    </table>
                </div>
                    <?php  
                    echo htmlspecialchars_decode($pager); 
                    ?>
                </div>
        </div>
    </div>
</div>
<script src="<?php echo base_url(); ?>/public/assets/website/js/ethers-5.2.umd.min.js"></script>  
<script src="<?php echo base_url("/public/assets/website/js/abi.js") ?>"></script> 
<script src="<?php echo base_url("app/Modules/Finance/Assets/Admin/js/custom.js?v=10") ?>"></script>

 