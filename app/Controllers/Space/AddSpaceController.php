<?php

namespace App\Controllers\Space;

use Hleb\Constructor\Handlers\Request;
use App\Models\SpaceModel;
use Lori\Config;
use Lori\Base;

class AddSpaceController extends \MainController
{
    // Добавления пространства
    public function index() 
    {
        $uid            = Base::getUid();
        $space          = SpaceModel::getUserCreatedSpaces($uid['id']);
        $count_space    = count($space);
        
        $valid = validTl($uid['trust_level'], Config::get(Config::PARAM_TL_ADD_SPACE), $count_space, 3);
        if ($valid === false) {
           // redirect('/');
        }
        
        $space_slug     = \Request::getPost('space_slug');
        $space_name     = \Request::getPost('space_name');  
        $space_permit   = \Request::getPostInt('permit');
        $space_feed     = \Request::getPostInt('feed');
        $space_tl       = \Request::getPostInt('space_tl');
     
        $redirect   = '/space/add';
        if (!preg_match('/^[a-zA-Z0-9_]+$/u', $space_slug)) {
            Base::addMsg(lang('url-latin'), 'error');
            redirect($redirect);
        }
        
        Base::Limits($space_name, lang('titles'), '4', '18', $redirect);
        Base::Limits($space_slug, 'slug (URL)', '3', '12', $redirect);
        
        if (preg_match('/\s/', $space_slug) || strpos($space_slug,' ')) {
            Base::addMsg(lang('url-gaps'), 'error');
            redirect($redirect);
        }
        if (SpaceModel::getSpace($space_slug, 'slug')) {
            Base::addMsg(lang('url-already-exists'), 'error');
            redirect($redirect);
        }
        
        $space_permit   = $space_permit == 1 ? 1 : 0;
        $space_feed     = $space_feed == 1 ? 1 : 0;
        $space_tl       = $space_tl == 1 ? 1 : 0;

        $data = [
            'space_name'            => $space_name,
            'space_slug'            => $space_slug,
            'space_description'     => '',
            'space_color'           => '#fa6807',
            'space_img'             => 'space_no.png',
            'space_text'            => '',
            'space_short_text'      => '',
            'space_date'            => date("Y-m-d H:i:s"),
            'space_category_id'     => 1,
            'space_user_id'         => $uid['id'],
            'space_type'            => 0, 
            'space_permit_users'    => $space_permit,  
            'space_feed'            => $space_feed,
            'space_tl'              => $space_tl,
            'space_is_delete'       => 0,
        ];
 
        // Добавляем пространство
        SpaceModel::AddSpace($data);

        Base::addMsg(lang('space-add-success'), 'success');
        redirect('/s/' . $space_slug); 
    }
    
    // Форма добавления пространства
    public function add() 
    {
        $uid  = Base::getUid();
  
        // Если пользователь уже создал пространство, то ограничим их количество (кроме TL5)
        $space          = SpaceModel::getUserCreatedSpaces($uid['id']);
        $count_space    = count($space);
        $total_allowed  = $uid['trust_level'] == 5 ? 999 : 3;
        $valid = validTl($uid['trust_level'], Config::get(Config::PARAM_TL_ADD_SPACE), $count_space, $total_allowed);
        if ($valid === false) {
            redirect('/');
        }
 
        $num_add_space = $total_allowed - $count_space;
 
        $data = [
            'h1'            => lang('Add Space'),
            'sheet'         => 'add-space', 
            'meta_title'    => lang('Add Space'),
        ];

        return view(PR_VIEW_DIR . '/space/add', ['data' => $data, 'uid' => $uid, 'num_add_space' => $num_add_space]);
    }

}
