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