<?php

namespace App\Controllers\Web;

use Hleb\Constructor\Handlers\Request;
use App\Models\WebModel;
use Lori\Content;
use Lori\Config;
use Lori\Base;

class WebController extends \MainController
{
    public function index() 
    {
        $uid    = Base::getUid();
        $page   = \Request::getInt('page'); 
        $page   = $page == 0 ? 1 : $page;
        
        $limit  = 25;
        $pagesCount = WebModel::getLinksAllCount();  
        $links      = WebModel::getLinksAll($page, $limit, $uid['id']);
        
        $num = ' | ';
        if ($page > 1) { 
            $num = sprintf(lang('page-number'), $page) . ' | ';
        } 
        
        $data = [
            'h1'            => lang('domains-title'),  
            'canonical'     => '/domains',
            'sheet'         => 'domains',
            'pagesCount'    => ceil($pagesCount / $limit),
            'pNum'          => $page,
            'meta_title'    => lang('domains-title') . $num . Config::get(Config::PARAM_NAME),
            'meta_desc'     => lang('domains-desc') . $num . Config::get(Config::PARAM_HOME_TITLE),  
        ];
        
        return view(PR_VIEW_DIR . '/web/links', ['data' => $data, 'uid' => $uid, 'links' => $links]);
    }
    
    // Выборка по домену
    public function domainPostList() 
    {
        $domain     = \Request::get('domain');
        $uid        = Base::getUid();
 
        $link      = WebModel::getLinkOne($domain, $uid['id']);
        Base::PageError404($link);
        
        $post       = WebModel::listPostsByDomain($domain, $uid['id']);        
            
        $result = Array();
        foreach ($post as $ind => $row) {
            $text = explode("\n", $row['post_content']);
            $row['post_content_preview']    = Content::text($text[0], 'line');
            $row['post_date']               = lang_date($row['post_date']);
            $row['lang_num_answers']        = word_form($row['post_answers_count'], lang('Answer'), lang('Answers-m'), lang('Answers'));
            $result[$ind]                   = $row;
         
        }

        $domains    = WebModel::getLinksTop($domain); 
        
        $meta_title = lang('Domain') . ': ' . $domain .' | '. Config::get(Config::PARAM_NAME);
        $meta_desc = lang('domain-desc') . ': ' . $domain .' '. Config::get(Config::PARAM_HOME_TITLE);
        
        $data = [
            'h1'            => lang('Domain') . ': ' . $domain,  
            'canonical'     => Config::get(Config::PARAM_URL) . '/domain/' . $domain,
            'sheet'         => 'domain',
            'meta_title'    => $meta_title,
            'meta_desc'     => $meta_desc, 
        ];
        
        return view(PR_VIEW_DIR . '/web/link', ['data' => $data, 'uid' => $uid, 'posts' => $result, 'domains' => $domains, 'link' => $link]);
    }

    // Получим Favicon
    public static function getFavicon($url)
    {
        $url = str_replace("https://", '', $url);
        return "https://www.google.com/s2/favicons?domain=".$url;
    }
    
    // Запишем Favicon
    public function favicon()
    {
        $link_id    = \Request::getPostInt('id');
        $uid        = Base::getUid();

        if ($uid['trust_level'] != 5) {
            return false;
        }
        
        $link = WebModel::getLinkId($link_id);
        
        if (!$link) {
            return false;
        }
        
        $puth = HLEB_PUBLIC_DIR. '/uploads/favicons/' . $link["link_id"] . '.png';
        $dirF = HLEB_PUBLIC_DIR. '/uploads/favicons/';

        if (!file_exists($puth)) {  
            $urls = self::getFavicon($link['link_url_domain']);       
            copy($urls, $puth); 
        } 
        
        return true;
    }

}
