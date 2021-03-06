<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                <?= breadcrumb('/', lang('Home'), '/u/' .$uid['login']. '/messages', lang('All messages'), $data['h1']); ?>

                <form action="/messages/send" method="post">
                <?= csrf_field() ?>
                    <input type="hidden" name="recipient" value="<?= $data['recipient_user']['id']; ?>" />
                    <textarea rows="3" id="message" class="mess" placeholder="<?= lang('Write'); ?>..." type="text" name="message" /></textarea>
                    <p>
                    <input type="submit" name="submit" value="<?= lang('Reply'); ?>" class="button">    
                    </p>
                </form>

                <?php if ($data['list']) { ?>
                    <?php foreach ($data['list'] AS $key => $val) { ?>
                  
                        <div class="msg-telo">

                            <?php if ($val['uid'] == $uid['id']) { ?>
                            
                                <?= user_avatar_img($uid['avatar'], 'max', $uid['login'], 'avatar left'); ?>
                               
                            <div class="message left">
                                
                            <?php } else { ?>

                                <a class="right" href="/u/<?= $val['login']; ?>">
                                    <?= user_avatar_img($val['avatar'], 'max', $val['login'], 'avatar left'); ?>
                                </a> 

                            <div class="message right">

                                <a class="left" href="/u/<?= $val['login']; ?>"> 
                                    <?= $val['login']; ?>: &nbsp;
                                </a> 
                            
                            <?php } ?>  
         
                                <?= $val['message']; ?>

                                <div class="date">
                                    <?= $val['add_time']; ?> 
                                    
                                    <?php if ($val['receipt'] AND $val['uid'] == $uid['id']) { ?> 
                                        <?= lang('It was read'); ?> (<?= $val['receipt']; ?>)
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        
                    <?php } ?>
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