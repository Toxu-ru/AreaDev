<?php

namespace App\Models;
use Hleb\Constructor\Handlers\Request;
use XdORM\XD;
use DB;
use PDO;

class AdminModel extends \MainModel
{
    // Страница участников
    public static function getUsersListForAdmin($page, $limit, $sheet)
    {
        $string = "WHERE ban_list > 0";
        if ($sheet == 'all') {
            $string = "";
        } 
        
        $start  = ($page-1) * $limit;
        $sql = "SELECT * FROM users $string ORDER BY id DESC LIMIT $start, $limit";

        return DB::run($sql)->fetchAll(PDO::FETCH_ASSOC); 
    }
    
    // Количество участинков
    public static function getUsersListForAdminCount($sheet)
    {
        $string = "WHERE ban_list > 0";
        if ($sheet == 'all') {
            $string = "";
        } 
        $sql = "SELECT id FROM users $string";

        return DB::run($sql)->rowCount(); 
    }
    
    // По логам
    public static function userLogId($user_id)
    {
        return XD::select('*')->from(['users_logs'])->where(['logs_user_id'], '=', $user_id)->orderBy(['logs_user_id'])->desc()->getSelectOne();
    }
    
    // Получение информации по ip для сопоставления
    public static function getUserLogsId($ip)
    {
        return XD::select('*')
                ->from(['users_logs'])
                ->leftJoin(['users'])->on(['id'], '=', ['logs_user_id'])
                ->where(['logs_ip_address'], '=', $ip)->getSelect();
    }

    // Проверка IP на дубликаты
    public static function replayIp($ip)
    {
        if (!$ip) { return 0; }

        $query = XD::select('*')
                ->from(['users'])
                ->where(['reg_ip'], '=', $ip);

        return count($query->getSelect());
    }
    
    // Находит ли пользователь в бан- листе и рабанен ли был он
    public static function isBan($uid)
    {
        $result = XD::select('*')->from(['users_banlist'])
                ->where(['banlist_user_id'], '=', $uid)
                ->and(['banlist_status'], '=', 1)->getSelectOne();

        if (!$result) {
            return false;    
        }

        return true;   
    }
    
    public static function setBanUser($uid)
    {
        $res = XD::select('*')->from(['users_banlist'])
                ->where(['banlist_user_id'], '=', $uid)->getSelect();
                
        $num = count($res);
     
        if ($num != 0) { 
        
            $result = Array();
            foreach ($res as $row) {
                $status = $row['banlist_status'];
            }  

            if ($status == 0) {   
            	// Забанить повторно
                // Проставляем в banlist_int_num 2, что пока означет: возможно > 2
                XD::update(['users_banlist'])->set(['banlist_int_num'], '=', 2, ',', ['banlist_status'], '=', 1)->where(['banlist_user_id'], '=', $uid)->run(); 
                XD::update(['users'])->set(['ban_list'], '=', 1)->where(['id'], '=', $uid)->run();                 
            } else {  
                // Разбанить
                XD::update(['users_banlist'])->set(['banlist_status'], '=', 0)->where(['banlist_user_id'], '=', $uid)->run(); 
                XD::update(['users'])->set(['ban_list'], '=', 0)->where(['id'], '=', $uid)->run();                 
            }
            
        } else {  
          
            // Занесем ip регистрации    
            $user = XD::select('*')->from(['users'])->where(['id'], '=', $uid)->getSelectOne();
            $ip   = $user['reg_ip'];
            
            // Забанить в первый раз
            $date = date("Y-m-d H:i:s");

            XD::insertInto(['users_banlist'], '(', ['banlist_user_id'], ',', ['banlist_ip'], ',', ['banlist_bandate'], ',', ['banlist_int_num'], ',', ['banlist_int_period'], ',', ['banlist_status'], ',', ['banlist_autodelete'], ',', ['banlist_cause'], ')')->values( '(', XD::setList([$uid, $ip, $date, 1, '', 1, 0, '']), ')' )->run();
            
            XD::update(['users'])->set(['ban_list'], '=', 1)->where(['id'], '=', $uid)->run();  
            
        }
        
        return true;   
    }
    
    // Дерева инвайтов
    public static function getInvitations() 
    {
        $q = XD::select(['id', 'login', 'avatar', 'uid', 'active_uid', 'active_time'])->from(['invitation']);
        $query = $q->leftJoin(['users'])->on(['active_uid'], '=', ['id'])->orderBy(['id'])->desc();
        
        return $query->getSelect();
    }
    
    // Все награды
    public static function getBadgesAll()
    {
        return XD::select('*')->from(['badge'])->getSelect();
    }
    
    // Получим информацию по награде
    public static function getBadgeId($badge_id)
    {
       return XD::select('*')->from(['badge'])->where(['badge_id'], '=', $badge_id)->getSelectOne(); 
    }
    
    // Редактирование награды
    public static function setEditBadge($data)
    {
        XD::update(['badge'])->set(['badge_title'], '=', $data['badge_title'], ',', 
            ['badge_description'], '=', $data['badge_description'], ',', 
            ['badge_icon'], '=', $data['badge_icon'])
            ->where(['badge_id'], '=', $data['badge_id'])->run(); 

        return true;
    }
    
    // Добавить награды
    public static function setAddBadge($data)
    {
        XD::insertInto(['badge'], '(',
            ['badge_tl'], ',',
            ['badge_score'], ',',        
            ['badge_title'], ',', 
            ['badge_description'], ',',
            ['badge_icon'], ')')->values( '(', 
        
        XD::setList([
            $data['badge_tl'],
            $data['badge_score'],
            $data['badge_title'], 
            $data['badge_description'],
            $data['badge_icon']]), ')' )->run();

        return true;
    }
    
    // Наградить участника
    public static function badgeUserAdd($user_id, $badge_id)
    {
        XD::insertInto(['badge_user'], '(',
            ['bu_user_id'], ',',
            ['bu_badge_id'], ')')->values( '(', 
        
        XD::setList([
            $user_id,
            $badge_id]), ')' )->run();

        return true;
    }
    
    // Редактирование участника
    public static function setUserEdit($data)
    {
        XD::update(['users'])->set(['email'], '=', $data['email'], ',', 
            ['login'], '=', $data['login'], ',',
            ['name'], '=', $data['name'], ',', 
            ['activated'], '=', $data['activated'], ',',
            ['about'], '=', $data['about'], ',', 
            ['trust_level'], '=', $data['trust_level'], ',',
            ['website'], '=', $data['website'], ',',
            ['location'], '=', $data['location'], ',',
            ['public_email'], '=', $data['public_email'], ',',
            ['skype'], '=', $data['skype'], ',',
            ['twitter'], '=', $data['twitter'], ',',
            ['telegram'], '=', $data['telegram'], ',',
            ['vk'], '=', $data['vk'])->where(['id'], '=', $data['id'])->run(); 
         return true;
    }
    
    // Страница аудита
    public static function getAuditsAll($page, $limit, $sheet)
    {
        $sort = "audit_read_flag = 0";
        if ($sheet == 'approved') {
            $sort = "audit_read_flag = 1";
        }
        
        $start  = ($page-1) * $limit;
        $sql = "SELECT * FROM audits WHERE $sort ORDER BY audit_id DESC LIMIT $start, $limit";

        return DB::run($sql)->fetchAll(PDO::FETCH_ASSOC); 
    }
    
    public static function getAuditsAllCount($sheet)
    {
        $sort = "audit_read_flag = 0";
        if ($sheet == 'approved') {
            $sort = "audit_read_flag = 1";
        }
        
        $sql = "SELECT id FROM users WHERE $sort";

        return DB::run($sql)->rowCount(); 
    }
    
    //Восстановление
    public static function recoveryAudit($id, $type)
    {
        if ($type == 'post') {
            XD::update(['posts'])->set(['post_published'], '=', 1)->where(['post_id'], '=', $id)->run(); 
        } elseif ($type == 'answer') {
            XD::update(['answers'])->set(['answer_published'], '=', 1)->where(['answer_id'], '=', $id)->run(); 
        } else {
            XD::update(['comments'])->set(['comment_published'], '=', 1)->where(['comment_id'], '=', $id)->run(); 
        }
        
        XD::update(['audits'])->set(['audit_read_flag'], '=', 1)->where(['audit_content_id'], '=', $id)->run();
        
        return true;
    }
    
}