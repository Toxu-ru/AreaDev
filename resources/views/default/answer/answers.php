<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                <h1><?= $data['h1']; ?></h1>

                <div class="telo">
                    <?php if (!empty($answers)) { ?>
                  
                        <?php foreach ($answers as $answer) { ?>  
                            <?php if($answer['answer_is_deleted'] == 0) { ?>
                                <div class="answ-telo_bottom">
                                    <div class="answ-header small">
                                        <?= user_avatar_img($answer['avatar'], 'small', $answer['login'], 'ava'); ?>
                                        <a class="date" href="/u/<?= $answer['login']; ?>">
                                            <?= $answer['login']; ?>
                                        </a> 
                                        <span class="date"><?= $answer['date']; ?></span>
                                        <span class="indent"> &#183; </span>
                                        <a href="/post/<?= $answer['post_id']; ?>/<?= $answer['post_slug']; ?>#answer_<?= $answer['answer_id']; ?>">
                                            <?= $answer['post_title']; ?>
                                        </a>
                                    </div>
                                   
                                    <div class="answ-telo-body">
                                        <?= $answer['answer_content']; ?> 
                                    </div>
                               
                                    <div class="post-full-footer date">
                                     + <?= $answer['answer_votes']; ?>                            
                                    </div>
                                </div>
                            <?php } else { ?>    
                                <div class="dell answ-telo_bottom"> 
                                    <div class="voters"></div>
                                    ~ <?= lang('Answer deleted'); ?>
                                </div>
                            <?php } ?> 
                        <?php } ?>
                        
                    <?= pagination($data['pNum'], $data['pagesCount'], $data['sheet'], '/answers'); ?>
                        
                    <?php } else { ?>
                        <div class="no-content"><?= lang('no-comment'); ?>...</div>
                    <?php } ?>
                </div>
            </div>    
        </div>        
    </main>
    <aside>
        <div class="white-box">
            <div class="inner-padding big">
                <?= lang('answers-desc'); ?>
            </div>
        </div>
        <?php if ($uid['id'] == 0) { ?>
            <?php include TEMPLATE_DIR . '/_block/login.php'; ?>
        <?php } ?>
    </aside>
</div>
<?php include TEMPLATE_DIR . '/footer.php'; ?>   