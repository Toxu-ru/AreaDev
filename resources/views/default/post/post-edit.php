<?php include TEMPLATE_DIR . '/header.php'; ?>
<main>

    <h1><?= $data['h1']; ?></h1>

     <div class="box create">
        <form action="/post/editpost/<?= $post['post_id']; ?>" method="post">
            <?= csrf_field() ?>
            <div class="boxline">
                <label for="post_title">Заголовок</label>
                <input class="add" type="text" value="<?= htmlspecialchars($post['post_title']); ?>" name="post_title" />
                <br />
            </div>   
            <?php if($uid['trust_level'] == 5) { ?>
                <div class="boxline">
                    <label for="post_title">URL</label>
                    <input class="add-url" type="text" value="<?= $post['post_url']; ?>" name="post_url" />
                    <input id="graburl" type="submit_url" name="submit_url" value="Извлечь" />
                    <br />
                </div> 
            <?php } ?>
             
            <div class="boxline">
                <?php include TEMPLATE_DIR . '/post/editor.php'; ?> 
            </div>
            
            <?php if($uid['trust_level'] > 0) { ?>
                <div class="boxline"> 
                    <label for="post_content">Формат</label>
                    <input type="radio" name="post_type" <?php if($post['post_type'] == 0) { ?>checked<?php } ?> value="0"> Обсуждение
                    <input type="radio" name="post_type" <?php if($post['post_type'] == 1) { ?>checked<?php } ?> value="1" > Q&A
                </div> 
                <div class="boxline"> 
                    <label for="post_content">Закрыть</label>
                    <input type="radio" name="closed" <?php if($post['post_closed'] == 0) { ?>checked<?php } ?> value="0"> <?= lang('No'); ?>
                    <input type="radio" name="closed" <?php if($post['post_closed'] == 1) { ?>checked<?php } ?> value="1" > <?= lang('Yes'); ?>
                </div>  
            <?php } ?>
            <?php if($uid['trust_level'] > 2) { ?>            
                <div class="boxline">
                    <label for="post_content">Поднять</label>
                    <input type="radio" name="top" <?php if($post['post_top'] == 0) { ?>checked<?php } ?> value="0"> <?= lang('No'); ?>
                    <input type="radio" name="top" <?php if($post['post_top']== 1) { ?>checked<?php } ?> value="1"> <?= lang('Yes'); ?>
                </div>                      
            <?php } ?>
            <div class="boxline">  
                <label for="post_content">Пространство</label>
                <select name="space_id">
                    <?php foreach ($space as $sp) { ?>
                        <option <?php if($post['space_id'] == $sp['space_id']) { ?> selected<?php } ?>   value="<?= $sp['space_id']; ?>"> <?= $sp['space_name']; ?>
                        </option>
                    <?php } ?>
                </select>
                <br> 
            </div>
            
            <?php if($tags) { ?>
                <div class="boxline">  
                    <label for="post_content">Метки</label>
                    <?php foreach ($tags as $tag) { ?>
                        <input type="radio" name="tag_id" value="<?= $tag['st_id']; ?>"<?php if($post['post_tag_id'] == $tag['st_id']) { ?> checked<?php } ?>><?= $tag['st_title']; ?>
                    <?php } ?>
                    <br> 
                </div>
            <?php } ?>
            
            <input type="hidden" name="post_id" id="post_id" value="<?= $post['post_id']; ?>">
            <input type="submit" name="submit" value="<?= lang('Edit'); ?>" />
        </form>
        <br>
    </div>
</main>
<script src="/assets/js/editor/js/medium-editor.js"></script>
<script src="/assets/js/editor.js"></script> 
<?php include TEMPLATE_DIR . '/footer.php'; ?> 