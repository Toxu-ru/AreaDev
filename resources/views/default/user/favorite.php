<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                <?= breadcrumb('/', lang('Home'), '/u/' .$uid['login'], lang('Profile'), $data['h1']); ?>

                <div class="favorite max-width">
                    <?php if (!empty($favorite)) { ?>
                  
                        <?php $counter = 0; foreach ($favorite as $fav) { $counter++; ?> 
                        
                            <?php if ($fav['favorite_type'] == 1) { ?> 
                                <div class="voters-fav">
                                   <div class="score"><?= $counter; ?>.</div> 
                                </div>
                                <div class="v-ots">
                                    <a href="/post/<?= $fav['post_id']; ?>/<?= $fav['post_slug']; ?>">
                                        <h3 class="title"><?= $fav['post_title']; ?></h3>
                                    </a>

                                    <div class="lowercase small">
                                        <?= user_avatar_img($fav['avatar'], 'small', $fav['login'], 'ava'); ?>
                                        <a class="indent"  href="/u/<?= $fav['login']; ?>"><?= $fav['login']; ?></a> 

                                        <span class="indent"><?= $fav['date']; ?></span>
                                        
                                        <span class="indent"> </span> 
                                        <a class="indent" href="/s/<?= $fav['space_slug']; ?>" title="<?= $fav['space_name']; ?>">
                                            <?= $fav['space_name']; ?>
                                        </a> 
                                        <?php if($fav['post_answers_count'] !=0) { ?> 
                                            <span class="indent"></span>
                                            <a class="indent" href="/post/<?= $fav['post_id']; ?>/<?= $fav['post_slug']; ?>">    
                                                <i class="icon bubbles"></i>  <?= $fav['post_answers_count'] ?> 
                                            </a>     
                                        <?php } ?>
                                        <?php if($uid['id'] > 0) { ?>
                                            <?php if($uid['id'] == $fav['favorite_user_id']) { ?>
                                                <span class="indent"> </span> 
                                                <span class="add-favorite right" data-id="<?= $fav['post_id']; ?>" data-type="post">
                                                     <span class="date"><?= lang('Remove'); ?></span>
                                                </span>  
                                            <?php } ?>                                
                                        <?php } ?>
                                    </div>  
                                </div>
                            <?php } ?>
                            <?php if ($fav['favorite_type'] == 2) { ?> 
                                <div class="voters-fav">
                                   <div class="score"><?= $counter; ?>.</div> 
                                </div>
                                <div class="post-telo fav-answ">
                                    <a href="/post/<?= $fav['post']['post_id']; ?>/<?= $fav['post']['post_slug']; ?>#answer_<?= $fav['answer_id']; ?>">
                                       <h3 class="title"><?= $fav['post']['post_title']; ?></h3>
                                    </a>
                                    <div class="space-color space_<?= $fav['post']['space_color'] ?>"></div>
                                    <a class="indent small" href="/s/<?= $fav['post']['space_slug']; ?>" title="<?= $fav['post']['space_name']; ?>">
                                        <?= $fav['post']['space_name']; ?>
                                    </a>
                                    <?php if($uid['id'] > 0) { ?>
                                        <?php if($uid['id'] == $fav['favorite_user_id']) { ?>
                                            <span class="add-favorite right" data-id="<?= $fav['answer_id']; ?>" data-type="answer">
                                                 <span class="small date"><?= lang('Remove'); ?></span>
                                            </span>  
                                        <?php } ?>                                
                                    <?php } ?>
                                    <div class="telo-fav-answ">
                                        <?= $fav['answer_content']; ?>
                                    </div>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    <?php } else { ?>
                        <p class="no-content"><i class="icon info"></i> <?= lang('There are no favorites'); ?>...</p>
                    <?php } ?>
                    <br>
                </div>
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