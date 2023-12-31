<body class="fixed">
    <div class="wrapper">
        <nav class="sidebar sidebar-bunker">
            <div class="sidebar-header">
                <a href="<?php echo base_url() ?>" class="logo"><img src="<?php echo base_url() . $settings->logo ?>"
                        alt="" style="height:40px;"></a>
            </div>
            <!--/.sidebar header-->
            <div class="profile-element d-flex align-items-center flex-shrink-0">
                <div class="avatar online">
                    <?php   
                        $userImg = session('image');
                        if(isset($userImg)){
                            $userImg = base_url() . session('image');
                        }else{
                            $userImg = base_url() . '/public/assets/images/icons/user.png';
                        }
                    
                    ?>
                    <img src="<?php echo esc($userImg); ?>" class="img-fluid rounded-circle" alt="">
                </div>
                <div class="profile-text">
                    <h6 class="m-0"><?php echo session('fullname') ?></h6>
                    <span><?php echo session('email') ?></span>
                </div>
            </div>
            <!--/.profile element-->

            <div class="sidebar-body">
                <nav class="sidebar-nav">
                    <ul class="metismenu">
                        

                        <?php
                        helper('filesystem');
                        $path = 'app/Modules/';
                        $map  = directory_map($path);
                        $ADMINMENU   = array();
                        if (is_array($map) && sizeof($map) > 0) {
                            foreach ($map as $key => $value) {
                                $menu = str_replace("\\", '/', $path . $key . 'Config/Admin_menu.php');
                                
                                
                                if (file_exists($menu)) {
   
                                     if (file_exists(APPPATH . 'Modules/' . $key . '/Assets/data/env')|| file_exists(APPPATH . 'Modules/' . $key . '/assets/data/env')) {
                                         @include($menu);
                                    }
                                }
                            }
                        }
                        $shortkeys = array_column($ADMINMENU, 'order');
                        array_multisort($shortkeys, SORT_ASC, $ADMINMENU);
                        
                        foreach ($ADMINMENU as $module => $parent) {

                            if ($parent['status'] == 0) {
                        ?>
                        <li
                            class="<?php echo (($uri->setSilent()->getSegment($parent['segment']) == $parent['segment_text']) ? "mm-active" : null) ?>">
                            <a class="<?php echo (($uri->setSilent()->getSegment($parent['segment']) == $parent['segment_text']) ? "mm-active" : null) ?> material-ripple"
                                href="<?php echo base_url("backend/" . $parent['link']) ?>">
                                <?php if ($parent['icon']) {
                                            echo htmlspecialchars_decode($parent['icon']);
                                        } ?>
                                <?php echo trim($parent['parent']); ?>
                            </a>
                        </li>
                        <?php
                            } else if ($parent['status'] == 1) {
                            ?>
                        <li>
                            <a class="has-arrow material-ripple <?php echo (($uri->setSilent()->getSegment($parent['segment']) == $parent['segment_text']) ? "mm-active" : null) ?>"
                                href="#">
                                <?php if ($parent['icon']) {
                                            echo htmlspecialchars_decode($parent['icon']);
                                        } ?>
                                <?php echo trim($parent['parent']); ?>
                            </a>
                            <ul class="nav-second-level">
                                <?php
                                        foreach ($parent['submenu'] as $key => $child) {
                                        ?>
                                <li
                                    class="<?php echo (($uri->setSilent()->getSegment($child['segment']) == $child['segment_text']) ? "mm-active" : null) ?>">
                                    <a href="<?php echo base_url("backend/" . $child['link']) ?>">
                                        <?php if ($child['icon']) {
                                                        echo htmlspecialchars_decode($child['icon']);
                                                    } ?>
                                        <?php echo trim($child['name']); ?> </a>
                                </li>
                                <?php } ?>
                            </ul>
                        </li>
                        <?php
                            }
                        }
                        ?>
                        <!-- <li>
                            <a target="_blank" href="https://www.bdtask.com/blog"><i class="fa fa-question-circle"></i><?php echo display('Support'); ?></a>
                        </li> -->
                    </ul>
                </nav>
            </div>
            <!-- sidebar-body -->
        </nav>