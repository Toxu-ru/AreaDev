<?php include TEMPLATE_DIR . '/header.php'; ?>
<div class="wrap">
    <main>
        <div class="white-box">
            <div class="inner-padding">
                 <?= breadcrumb('/', lang('Home'), '/u/' .$uid['login'], lang('Profile'), $data['h1']); ?>
                 
                 <?php if($uid['trust_level'] > 1) { ?>
                 
                    <form method="post" action="/invitation/create">
                    <?php csrf_field(); ?>

                        <div class="boxline">
                            <input id="link" class="add-email" type="email" name="email">
                            <input id="graburl" type="submit" name="submit" value="Создать">
                            <br>
                        </div>
                         Осталось приглашений <?= 5 - $uid['invitation_available']; ?> 

                    </form>
                     
                    <h3>Приглашенные</h3>
                     
                    <?php if (!empty($result)) { ?> 

                        <?php foreach ($result as $inv) { ?>
                            <?php if($inv['active_status'] == 1) { ?>
                                <div class="comm-header">
                                    <?= user_avatar_img($inv['avatar'], 'small', $inv['login'], 'ava'); ?>
                                    <a href="<?= $inv['login']; ?>"><?= $inv['login']; ?></a>
                                    - зарегистрировался
                                </div>
                                
                                    <?php if($uid['trust_level'] == 5) { ?>
                                        Была использована ссылка для: <?= $inv['invitation_email']; ?> <br>
                                        <code> 
                                            <?= Lori\Config::get(Lori\Config::PARAM_URL); ?>/register/invite/ <?= $inv['invitation_code']; ?> 
                                        </code>
                                    <?php } ?>
                                    
                                <small>Ссылка была использована</small>
                            <?php } else { ?>
                            
                                Для   (<?= $inv['invitation_email']; ?>) можно отправить эту ссылку: <br>
                            
                                <code> 
                                    <?= Lori\Config::get(Lori\Config::PARAM_URL); ?>/register/invite/ <?= $inv['invitation_code']; ?>
                                </code> 
                            
                            <?php } ?>

                            <br><br>
                        <?php } ?> 
                        
                    <?php } else { ?>
                        Пока нет приглашений
                    <?php } ?>
                
                <?php } else { ?>
                    Ваш уровень доверия пока не позволяет использовать инвайты.
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