<?php
namespace App\Models;
use XdORM\XD;
use DB;
use PDO;

class AnswerModel extends \MainModel
{
    // Все ответы
    public static function getAnswersAll($page, $limit, $uid)
    {
        $tl = 'AND post_tl = 0';
        if ($uid['trust_level']) { 
                $tl = 'AND post_tl <= '.$uid['trust_level'].'';
        } 
        
        $start  = ($page-1) * $limit;
        $sql = "SELECT 
                    post_id,
                    post_title,
                    post_slug,
                    answer_id,
                    answer_content,
                    answer_date,
                    answer_user_id,
                    answer_post_id,
                    answer_votes,
                    answer_is_deleted,
                    id, 
                    login, 
                    avatar
                        FROM answers
                        INNER JOIN users ON id = answer_user_id
                        INNER JOIN posts ON answer_post_id = post_id AND answer_is_deleted = 0 ".$tl."
                        ORDER BY answer_id DESC LIMIT $start, $limit ";
                        
        return DB::run($sql)->fetchAll(PDO::FETCH_ASSOC); 
    }
    
    // Количество ответов
    public static function getAnswersAllCount()
    {
        $sql = "SELECT answer_id, answer_is_deleted FROM answers WHERE answer_is_deleted = 0";

        return DB::run($sql)->rowCount(); 
    }
    
    // Получаем лучший комментарий (LO)
    public static function getAnswerLo($post_id)
    {
        return XD::select('*')->from(['answers'])
                ->where(['answer_post_id'], '=', $post_id)
                ->and(['answer_lo'], '>', 0)->getSelectOne();
    }
    
    // Получаем ответы в посте
    public static function getAnswersPost($post_id, $user_id, $type)
    { 
        $sort = "";
        if ($type == 1) {
            $sort = 'ORDER BY a.answer_votes DESC ';
        }    
        
        $sql = "SELECT 
                a.answer_id,
                a.answer_user_id,
                a.answer_post_id,
                a.answer_date,
                a.answer_content,
                a.answer_modified,
                a.answer_ip,
                a.answer_votes,
                a.answer_after,
                a.answer_is_deleted,
        
                v.votes_answer_item_id, 
                v.votes_answer_user_id,
                
                f.favorite_tid,
                f.favorite_user_id,
                f.favorite_type,
                
                u.id, 
                u.login, 
                u.avatar
                
                FROM answers AS a
                LEFT JOIN users AS u ON u.id = a.answer_user_id
                LEFT JOIN votes_answer AS v ON v.votes_answer_item_id = a.answer_id
                    AND v.votes_answer_user_id = $user_id
                LEFT JOIN favorite AS f ON f.favorite_tid = a.answer_id
                    AND f.favorite_user_id  = $user_id
                    AND f.favorite_type = 2
                    WHERE a.answer_post_id = $post_id
                    $sort ";

        return DB::run($sql)->fetchAll(PDO::FETCH_ASSOC); 
    }

    // Страница ответов участника
    public static function userAnswers($slug)
    {
        $q = XD::select('*')->from(['answers']);
        $query = $q->leftJoin(['users'])->on(['id'], '=', ['answer_user_id'])
                ->leftJoin(['posts'])->on(['answer_post_id'], '=', ['post_id'])
                ->where(['login'], '=', $slug)
                ->and(['answer_is_deleted'], '=', 0)
                ->and(['post_tl'], '=', 0)
                ->orderBy(['answer_id'])->desc();
        
        return $query->getSelect();
    } 
   
    // Информацию по id ответа
    public static function getAnswerId($answer_id)
    {
       return XD::select('*')->from(['answers'])->where(['answer_id'], '=', $answer_id)->getSelectOne();
    }
    
    // Редактируем ответ
    public static function AnswerEdit($comment_id, $answer)
    {
        $data = date("Y-m-d H:i:s"); 
        
        return  XD::update(['answers'])->set(['answer_content'], '=', $answer, ',', ['answer_modified'], '=', $data)
        ->where(['answer_id'], '=', $comment_id)->run();
    }
    
    // Частота размещения ответа участника 
    public static function getAnswerSpeed($uid)
    {
        $sql = "SELECT answer_id, answer_user_id, answer_date
                fROM answers 
                WHERE answer_user_id = ".$uid."
                AND answer_date >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
                
        return  DB::run($sql)->fetchAll(PDO::FETCH_ASSOC); 
    }
  
    // Удаленные ответы
    public static function getAnswersDeleted($page, $limit) 
    {
        $start  = ($page-1) * $limit;
        $sql = "SELECT 
                    a.answer_id, 
                    a.answer_user_id, 
                    a.answer_date,
                    a.answer_content,
                    a.answer_votes,
                    a.answer_is_deleted,
                    u.id,
                    u.login,
                    u.avatar,
                    p.post_id,
                    p.post_title,
                    p.post_slug
                    
                        FROM answers AS a
                        LEFT JOIN users AS u ON u.id = a.answer_user_id
                        LEFT JOIN posts AS p ON p.post_id = a.answer_post_id
                        WHERE a.answer_is_deleted = 1
                        ORDER BY a.answer_id DESC LIMIT $start, $limit";
                
        return  DB::run($sql)->fetchAll(PDO::FETCH_ASSOC);
    }
    
    // Количество
    public static function getAnswersDeletedCount()
    {
        $sql = "SELECT answer_id, answer_is_deleted FROM answers WHERE answer_is_deleted = 1";

        return DB::run($sql)->rowCount(); 
    }

}