<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                <?= breadcrumb('/', lang('Home'), '/u/' . Request::get('login'), lang('Profile'), $data['h1']); ?>

                <?php if (!empty($answers)) { ?>

                    <?php foreach ($answers as $answer) { ?> 
                        <?php if($answer['answer_is_deleted'] == 0) { ?>
                            <div class="answ-telo_bottom">
                                <div class="small">
                                    <?= user_avatar_img($answer['avatar'], 'small', $answer['login'], 'ava'); ?>
                                    
                                    <a class="date" href="/u/<?= $answer['login']; ?>"><?= $answer['login']; ?></a>
                                    
                                    <span class="date"><?= $answer['date']; ?></span>
                                   
                                    <span class="indent"> &#183; </span>
                                    <a href="/post/<?= $answer['post_id']; ?>/<?= $answer['post_slug']; ?>"><?= $answer['post_title']; ?></a>
                                </div>
                                <div class="telo-body">
                                    <?= $answer['content']; ?> 
                                </div>
                                <div class="post-full-footer date">
                                    <div class="up-id"></div> + <?= $answer['answer_votes']; ?>
                                </div>
                            </div>  
                        <?php } else { ?>    
                            <div class="dell answ-telo_bottom"> 
                                <div class="voters"></div>
                                ~ <?= lang('Answer deleted'); ?>
                            </div>
                        <?php } ?>     
                                
                    <?php } ?>

                <?php } else { ?>
                    <div class="no-content"><i class="icon info"></i> <?= lang('No answers'); ?>...</div>
                <?php } ?>
            </div>
        </div>
    </main>
    <aside>
        <?php include TEMPLATE_DIR . '/_block/user-menu.php'; ?>
    </aside>
</div>    
<?php include TEMPLATE_DIR . '/footer.php'; ?>