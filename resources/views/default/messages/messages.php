<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                <?= breadcrumb('/', lang('Home'), '/u/' . $uid['login'], lang('Profile'), $data['h1']); ?>
                
                <?php if (!empty($data['messages'])) { ?>

                    <?php foreach ($data['messages'] as  $msg) { ?>

                        <div class="msg-telo<?php if (!$msg['unread'] > 0) { ?> active<?php } ?>">
                            <?php if($msg['sender_uid'] == $uid['id']) {  ?>
                                <div class="small">
                                    <?= lang('You'); ?>  |  <?= $msg['update_time']; ?>
                                </div>    
                            <?php } else { ?>
                                <div class="small">
                                    <?= lang('From'); ?>
                                    <span class="indent"></span>
                                    <?= user_avatar_img($msg['msg_user']['avatar'], 'small', $msg['msg_user']['login'], 'ava'); ?>
                                    <span class="indent"></span>
                                    <a href="/u/<?= $msg['msg_user']['login']; ?>">
                                       <?= $msg['msg_user']['login']; ?> 
                                    </a>
                                    <span class="date"><?= $msg['update_time']; ?></span>
                                 </div>
                            <?php } ?>
                            
                            <div class="message one">
                                <?= $msg['message']['message']; ?>
                            </div>
                            
                            <a class="lowercase" href="/messages/read/<?= $msg['id']; ?>">
                                <?php if ($msg['unread']) { ?>
                                    <?= lang('There are'); ?> <?= $msg['count']; ?> <?= $msg['unread_num']; ?>
                                <?php } else { ?>
                                    <?= lang('View'); ?>  
                                    <?php if($msg['count'] != 0) { ?> 
                                        <?= $msg['count']; ?>  <?= $msg['count_num']; ?>
                                    <?php } ?>    
                                <?php } ?>
                            </a>
                            
                       </div>
                    <?php } ?>
               
                <?php } else { ?>
                    <div class="no-content"><?= lang('No dialogs'); ?>...</div>
                <?php } ?>
            </div>
        </div>            
    </main>
    <aside>
        <div class="white-box">
            <div class="inner-padding big">
                <?= lang('Under development'); ?>...
            </div>
        </div>   
    </aside>
</div>    
<?php include TEMPLATE_DIR . '/footer.php'; ?>