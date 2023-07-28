<div class="profile-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-6"> 
                <div class="border rounded-5 p-3 p-sm-5">
                <?php if(isset($message)){ ?>
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong><?php echo display('Success'); ?>!</strong> <?php echo $message; ?>
                </div>
                <?php } ?>
                <?php if(isset($exception)){ ?>
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong><?php echo display('Exception'); ?>!</strong> <?php echo $exception; ?>
                </div>
                <?php } ?>
                <ul class="nav nav-tabs mb-5" id="myTab" role="tablist">

                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="home-tab" data-bs-toggle="tab"
                            data-bs-target="#home" type="button" role="tab" aria-controls="home"
                            aria-selected="true"><?php echo display('Edit_Profile'); ?></button>
                    </li>

                    

                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="withdraw-tab" data-bs-toggle="tab" data-bs-target="#withdraw"
                            type="button" role="tab" aria-controls="withdraw"
                            aria-selected="false"><?php echo display('Withdraw'); ?></button>
                    </li>

                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="transaction-tab" data-bs-toggle="tab" data-bs-target="#transaction"
                            type="button" role="tab" aria-controls="withdraw"
                            aria-selected="false"><?php echo display('Transactions'); ?></button>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        
                        <?php echo form_open_multipart("", ""); ?>
                            <div class="row">
                                <div class="col-md-4">
                                    
                                </div>
                               
                                    <div class="mb-4">
                                         
                                        <div class="profile-pic-wrapper">
                                            <div class="pic-holder">
                                                <!-- uploaded pic shown here -->
                                                <?php if($profile->image){ ?>
                                                    <img id="profilePic" class="pic" src="<?php echo base_url().'/public/uploads/dashboard/new/'.$profile->image; ?>">  
                                                <?php }else{ ?>
                                                    <img id="profilePic" class="pic" src="<?php echo esc($frontendAssets); ?>/img/profile-placeholder.png"> 
                                                <?php } ?>
                                                <input class="uploadProfileInput1" type="file" name="profile_image" id="newProfilePhoto" />
                                                <input type="hidden" name="old_profile_image" value="<?php echo esc($profile->image); ?>">

                                                <label for="newProfilePhoto" class="upload-file-block">
                                                    <div class="text-center">
                                                        <div class="mb-2">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                height="24" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round"
                                                                class="feather feather-camera">
                                                                <path
                                                                    d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z">
                                                                </path>
                                                                <circle cx="12" cy="13" r="4"></circle>
                                                            </svg>
                                                        </div> 
                                                    </div>
                                                </label>
                                            </div>
                                            </hr>
                                            <p class="fw-medium text-center small m-0"><?php echo display('Profile_picture_ecommended'); ?> </p>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label for="first_name" class="form-label fw-semi-bold text-black mb-1"> <?php echo display('firstname');?> <span class="text-danger">*</span></label>
                                        <input type="text" name="first_name" class="form-control" id="" value="<?php echo esc($profile->f_name); ?>" placeholder="First name" required>
                                    </div> 
                                    <div class="mb-4">
                                        <label for="last_name" class="form-label fw-semi-bold text-black mb-1"><?php echo display('lastname');?><span class="text-danger"> *</span></label>
                                        <input type="text" name="last_name" class="form-control" id="" value="<?php echo esc($profile->l_name); ?>" placeholder="Last name" required>
                                    </div> 

                                    
                                    <div class="mb-4">
                                        <label for="bio" class="form-label fw-semi-bold text-black mb-1"><?php echo display('Biography');?></label>
                                        <textarea class="form-control" name="bio" id="exampleFormControlTextarea1" rows="3" placeholder="Write your biography"><?php echo esc($profile->bio); ?></textarea>
                                    </div>
                                    <div class="mb-4">
                                        <label for="site" class="form-label fw-semi-bold text-black mb-1"><?php echo display('Personal_website_link');?> </label>
                                        <input type="text" name="portfolio_url" class="form-control" id="" value="<?php echo esc($profile->portfolio_url); ?>" placeholder="https://">
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label for="email" class="form-label fw-semi-bold text-black mb-1"><?php echo display('email'); ?></label><span class="text-danger"> *</span>
                                        <input type="email" class="form-control" name="email" id="email" value="<?php echo esc($profile->email) ?>" placeholder="name@example.com">
                                    </div>
                                    <div class="mb-4">
                                        <label for="wallet-address" class="form-label fw-semi-bold text-black mb-1"><?php echo display('Wallet_Address'); ?></label>
                                        <div class="wallet-address"> 

                                            <input type="text" value="<?php echo $profile->wallet_address; ?>" class="form-control" id="mywallet" readonly="readonly">


                                            <div class="tooltips">
                                                <button id="copy-wallet" type="button">
                                                    <span class="tooltiptext" id="myTooltip"><?php echo display('Copy_to_clipboard'); ?></span>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round"
                                                        stroke-linejoin="round" class="feather feather-copy">
                                                        <rect x="9" y="9" width="13" height="13" rx="2" ry="2">
                                                        </rect>
                                                        <path
                                                            d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1">
                                                        </path>
                                                    </svg>
                                                </button>
                                            </div>
 
                                        </div> 
                                    </div>
                                    <div class="mb-4">
                                         
                                        <div class="profile-pic-wrapper">
                                            <div class="pic-holder pic-holder-banner">
                                                <!-- uploaded pic shown here -->
                                                <?php if($profile->banner_image){ ?> 
                                                    <img id="profilePic" class="pic" src="<?php echo base_url().'/'.$profile->banner_image; ?>">
                                                <?php }else{ ?>
                                                    <img id="profilePic" class="pic" src="<?php echo esc($frontendAssets); ?>/img/profile-placeholder.png">
                                                <?php } ?>
                                                

                                                <input class="uploadProfileInput" type="file" name="banner_image" id="profileBanner" accept="image/*" />
                                                <input type="hidden" name="old_banner_img" value="<?php echo esc($profile->banner_image); ?>">

                                                <label for="profileBanner" class="upload-file-block">
                                                    <div class="text-center">
                                                        <div class="mb-2">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                height="24" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round"
                                                                class="feather feather-camera">
                                                                <path
                                                                    d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z">
                                                                </path>
                                                                <circle cx="12" cy="13" r="4"></circle>
                                                            </svg>
                                                        </div>
                                                         
                                                    </div>
                                                </label>
                                            </div>
                                            </hr>
                                            <p class="fw-medium text-center small m-0"><?php echo display('Banner_picture_recommended'); ?> </p>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-dark w-100 btn-profile mt-4"><?php echo display('Update_Profile'); ?></button>
                               
                            </div>
                        <?php echo form_close(); ?>
                    </div>
                 
                    <div class="tab-pane fade" id="withdraw" role="tabpanel" aria-labelledby="withdraw-tab">  
                        <div class="card p-3 p-sm-5 border-0">
                            <h4 class="fw-semi-bold"><?php echo display('Withdraw'); ?></h4>
                            <h6><?php echo display('Important'); ?></h6>
                            <p><?php echo display('Please_reload_your_balance_then_send_amount_less_than_balance'); ?></p>
                            <div class="mt-5">

                                <div class="row">   
                                    <div class="text-center">
                                        <span class="biding_balance"> 0</span><?php echo ' '.SYMBOL(); ?>
                                       <a href="javascript:;" mywallet="<?php echo $profile->wallet_address; ?>" contrctAddress ="<?php echo (isset($contractInfo->contract_address)) ? esc($contractInfo->contract_address) : ''; ?>" id="reload_my_biding_balance">Reload balance</a>
                                    </div> 
                                </div> 
                                
                                <?php echo form_open('user/withdraw', 'class="withdraw-form", id="withdraw_form"'); ?> 
                                    
                                    <div class="mb-4">
                                        <label for="wallet-address" class="form-label fw-semi-bold text-black mb-1"><?php echo display('Wallet_Address'); ?> <span class="text-danger">*</span></label>
                                        <input type="text" name="wallet_address" class="form-control form-control-bg" id="wallet_address" value="" placeholder="Wallet Address Ex: 0x" autocomplete="off" required="required">
                                    </div>

                                    <div class="mb-4">
                                        <label for="wallet-address" class="form-label fw-semi-bold text-black mb-1"><?php echo display('Amount'); ?> <span class="text-danger">*</span></label>
                                        <input type="text" name="amount" class="form-control form-control-bg" id="send_amount" value="" placeholder="Enter send amount" autocomplete="off" required="required">
                                    </div>

                                    <div>
                                        <button type="submit" class="btn btn-primary sendButton"><?php echo display('Send'); ?></button>
                                    </div>
 
                                <?php echo form_close(); ?>
                                
                                 
                               
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="transaction" role="tabpanel" aria-labelledby="transaction-tab">  
                        <div class="card p-3 p-sm-5 border-0">
                            <h4 class="fw-semi-bold"><?php echo display('Transactions'); ?></h4>
                            
                            <div class="mt-5">

                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col"><?php echo display('Type'); ?></th>
                                            <th scope="col"><?php echo display('Amount'); ?></th>
                                            <th scope="col"><?php echo display('Status'); ?></th>
                                             
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <?php 
                                        foreach ($trxInfo as $key => $trxValue) { ?>
                                            <tr>
                                              <th scope="row"><?php echo esc($key+1); ?></th>
                                              <td> <?php echo esc($trxValue->transaction_type); ?> </td>
                                              <td><?php echo number_format(esc($trxValue->amount), 5).' '.SYMBOL(); ?></td>
                                              <td><?php echo ($trxValue->status == 1) ? "Success" : "Pending"; ?></td> 
                                            </tr>
                                        <?php } ?>
                                    </tbody>
                                </table> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>


        