
<?php $uri = service('uri','<?php echo base_url(); ?>');?>
    <div class="card">
      <div class="card-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h6 class="fs-17 font-weight-600 mb-0"><?php echo (!empty($title)?esc($title):null) ?></h6>
            </div> 
            <div class="text-right " id="purchase_key_check_show"> 
                <div class="actions">
                  <a href="" class="action-item"><i class="ti-reload"></i></a> 
                </div> 
                <?php if(!empty($purchase_info)){ ?>
                <span class="fs-17 font-weight-600 mb-0 alert alert-success"> Purchase Key Verified &nbsp; <i class="fa fa-check-circle  fa-lg text-success" aria-hidden="true"></i></span>
                <?php } ?>
            </div> 
        </div>
      </div> 
   
      <?php if(empty($purchase_info)){ ?>
      <div class="mb-3 purchase-key-check" id="purchase_key_check">      
        <div class="row"> 
          <div class="col-sm-11">
            <label class="font-weight-600 mb-1" for="purchase_key">PURCHASE KEY <span class="text-danger"> *</span></label> 
            <input id="purchase_key" type="text" class="form-control form-control-lg" placeholder="Enter Purchase Key" name=""> 
          </div>
          <div class="col-sm-1 text-left mt-4">
            <button type="submit" class="btn btn-success btn-lg"  id="submit_purchase">Verify</button>
          </div>
        </div>
      </div> 
      <?php } ?>


      <div class="card-body" id="contact_setup_network">
      <?php if(!empty($purchase_info)){ ?>
        <h6 class="fs-17 font-weight-600"><?php echo esc($network->network_name); ?></h6>
        <div class="msg"></div> 

        <?php 
        if(empty($info)){
        ?>
          <form action="#" id="contract_form">
            <div> 
              <div class="form-group row"> 
                <div class="col-sm-6">
                  <label><?php echo display('Contract_Name'); ?> <i class="text-danger">*</i></label>
                    <input name="contract_name" value="" class="form-control" type="text" id="contract_name" autocomplete="off" placeholder="<?php echo display('Contract_name'); ?>" required>
                </div> 
                <div class="col-sm-6">
                  <label><?php echo display('Token_Symbol'); ?> <i class="text-danger">*</i></label>
                    <input name="contract_symbol" value="" class="form-control" type="text" id="contract_symbol" autocomplete="off" placeholder="<?php echo display('Token_symbol'); ?>" required>
                </div> 
              </div> 

              <div class="form-group row"> 
                <div class="col-sm-6">
                  <label><?php echo display('Max_Supply'); ?> <i class="text-danger">*</i></label>
                    <input name="max_supply" value="" class="form-control" type="text" id="max_supply" autocomplete="off" placeholder="Ex=1000000" required>
                </div>  
                <input type="hidden" name="rpc_url" value="<?php echo ($network)?  $network->rpc_url : ''; ?>">
              </div> 
              <span class="deployedmsg text-danger"></span>
              <div class="form-group row"> 
                <div class="col-sm-6 aftersubmit">  
                    <button type="submit" class="btn btn-success"><?php echo display('Deploy'); ?></button>
                  </div> 
              </div>  
            </div>
          </form>
        <?php 
        }else{ 
        ?>
          <div class="table-responsive">
            <table class="table display table-bordered table-striped table-hover">
              <thead>
                <tr>
                  <td><?php echo display('Contract_Name'); ?></td>
                  <td><?php echo display('Token_Symbol'); ?></td>
                  <td><?php echo display('Max_Supply'); ?></td>
                  <td><?php echo display('Contract_Address'); ?></td>
                  <td><?php echo display('Transaction_Hash'); ?></td>
                  <td><?php echo display('delete'); ?></td>
                </tr>
              </thead>
              <tbody>
                <td><?php echo esc($info->contract_name); ?></td>
                <td><?php echo esc($info->contract_symbol); ?></td>
                <td><?php echo esc($info->max_token_supply); ?></td>
                <td><?php echo esc($info->contract_address); ?> <a title="" target="_blank" href="<?php echo ($network && isset($network)) ? esc($network->explore_url).'/address/'.esc($info->contract_address) : ''; ?>"> <i class="fa fa-location-arrow"></i></a></td>
                <td><?php echo esc($info->tnx_hash); ?> <a title="" target="_blank" href="<?php echo ($network &&  isset($network)) ? esc($network->explore_url).'/tx/'.esc($info->tnx_hash) : ''; ?>"> <i class="fa fa-location-arrow"></i></a></td>
                <td>
                  <a href="<?php echo base_url("backend/nft/contract-delete/{$info->id}") ?>" onclick="return confirm('<?php echo display("are_you_sure"); ?>')" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="right" title="Delete "><i class="far fa-trash-alt" aria-hidden="true"></i></a>
                </td>
              </tbody>
            </table>
          </div>
        <?php } ?>
        <div class="text-danger"><?php echo display('contract_deploy_msg'); ?></div>


      <?php } ?>
      </div> 
    </div>   
    <script src="<?php echo base_url(); ?>/public/assets/website/js/ethers-5.2.umd.min.js"></script> 
    <script src="<?php echo base_url("/public/assets/website/js/bytecode.js") ?>"></script>
    <script src="<?php echo base_url("/public/assets/website/js/abi.js") ?>"></script>
    <script src="<?php echo base_url("app/Modules/Nfts/Assets/Admin/js/custom.js") ?>"></script>

 

 