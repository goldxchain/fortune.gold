<?php $uri = service('uri','<?php echo base_url(); ?>');?>
  
<div class="row">
    <div class="col-md-6 col-lg-6">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fs-17 font-weight-600 mb-0"><?php echo display('Blockchain_Networks'); ?></h6> 
                    </div>
                    <div class="text-right">
                        <?php if (empty($network)){ ?> 
                        <div class="actions">
                            <a class="btn btn-success btn-sm" href="<?php echo base_url('backend/nft/add_network'); ?>"><i class="fa fa-plus-square" aria-hidden="true"></i> <?php echo display('Add_Network'); ?></a> 
                        </div>
                        <?php }else{ ?>
                        <div class="actions">
                            <a class="btn btn-success btn-sm" href="<?php echo base_url('backend/nft/update_network/'.$network->id); ?>"><i class="far fa-edit"></i> <?php echo display('update'); ?></a> 
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table display table-bordered table-striped table-hover">
                        <?php if (!empty($network)){ ?> 
                        
                        <tr>
                            <th><?php echo display('Network_Name'); ?></th>
                            <td><?php echo ($network->network_name == 'bsc') ? display('Binance_Smart_Chain') : esc($network->network_name); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Chain_ID'); ?></th>
                            <td><?php echo esc($network->chain_id); ?></td>
                        </tr>
                         <tr>
                            <th><?php echo display('Symbol'); ?></th>
                            <td><?php echo esc($network->currency_symbol); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('RPC'); ?></th>
                            <td><?php echo esc($network->rpc_url); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Block_Explorer_URL'); ?></th>
                            <td><?php echo esc($network->explore_url); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Server_IP'); ?> (<?php echo display('For_nodejs_server'); ?>)</small></th>
                            <td><?php echo esc($network->server_ip); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Port'); ?> (<?php echo display('For_nodejs_server'); ?>)</th>
                            <td><?php echo esc($network->port); ?></td>
                        </tr>
                         
                         
                        <tr>
                            <td colspan="2">
                                
                            </td> 
                        </tr>  
                        <?php  
                    }else{
                       echo "<span class='text-danger'>".display('Not found')." </span>"; 
                   }  
                    ?>
                    </table>  
                </div>
                 
            </div>
        </div>

    </div>
    <div class="col-md-6 col-lg-6">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fs-17 font-weight-600 mb-0"><?php echo display('Admin_Wallet'); ?></h6>
                    </div>
                    <div class="text-right">
                        <?php if (empty($wallet)){ ?>
                        <div class="actions">
                            <a class="btn btn-success btn-sm" href="<?php echo base_url('backend/nft/wallet_import'); ?>"><i class="fa fa-plus-square" aria-hidden="true"></i> <?php echo display('Import_Wallet'); ?></a> 
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>            
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table display table-bordered table-striped table-hover">
                        <?php if (!empty($wallet)){ ?> 
                       
                        <tr>
                            <th><?php echo display('Wallet_Address'); ?></th>
                            <td><?php echo esc($wallet->wallet_address); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Balance'); ?> </th>
                            <td><span id="admin_balance"><?php echo number_format(esc($wallet->balance), 3,'.',','); ?> </span><?php echo ' '.SYMBOL(); ?></td>
                        </tr>
                        <tr>
                            <th><?php echo display('Status'); ?></th>
                            <td><?php echo (($wallet->status==1)?display('active'):display('inactive')); ?></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="hidden" id="wallet_address_balace" value="<?php echo esc($wallet->wallet_address); ?>">

                                <a href="javascript:;" onclick="reloadFunction()" id="reloadbalance" class="btn btn-success btn-sm" data-toggle="tooltip" data-placement="left" title="Reload"><i class="fa fa-cog" aria-hidden="true"></i> <?php echo display('Reload_Balance'); ?></a> 

                                <a href="<?php echo base_url("backend/nft/wallet-delete/{$wallet->awid}") ?>" onclick="return confirm('<?php echo display("are_you_sure"); ?>')" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="right" title="Delete "><i class="far fa-trash-alt" aria-hidden="true"></i> Delete </a>
                            </td> 
                        </tr>  
                        <?php

                         }else{
                            echo "<span class='text-danger'>".display('Not_found')."</span>";
                         } ?>
                    </table>  
                </div>
            </div>
        </div> 
    </div> 
</div> 
<script src="<?php echo base_url("app/Modules/Nfts/Assets/Admin/js/custom.js") ?>"></script>


 
 