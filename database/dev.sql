CREATE TABLE `answers` (
  `answer_id` int(11) NOT NULL,
  `answer_post_id` int(11) NOT NULL DEFAULT 0,
  `answer_user_id` int(11) NOT NULL DEFAULT 0,
  `answer_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `answer_modified` timestamp NOT NULL DEFAULT '2020-12-31 03:00:00',
  `answer_published` tinyint(1) NOT NULL DEFAULT 1,
  `answer_ip` varbinary(42) DEFAULT NULL,
  `answer_order` smallint(6) NOT NULL DEFAULT 0,
  `answer_after` smallint(6) NOT NULL DEFAULT 0,
  `answer_votes` smallint(6) NOT NULL DEFAULT 0,
  `answer_content` text NOT NULL,
  `answer_lo` int(11) NOT NULL DEFAULT 0,
  `answer_is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`answer_id`, `answer_post_id`, `answer_user_id`, `answer_date`, `answer_modified`, `answer_published`, `answer_ip`, `answer_order`, `answer_after`, `answer_votes`, `answer_content`, `answer_lo`, `answer_is_deleted`) VALUES
(1, 3, 1, '2021-04-29 22:41:27', '2020-12-31 03:00:00', 1, 0x3132372e302e302e31, 0, 0, 0, 'Первый ответ в теме', 0, 0),
(2, 1, 2, '2021-07-02 01:34:52', '2020-12-31 03:00:00', 1, 0x3132372e302e302e31, 0, 0, 0, 'Муха села на варенье, Вот и всё стихотворение... ', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `audits`
--

CREATE TABLE `audits` (
  `audit_id` int(11) NOT NULL,
  `audit_type` varchar(16) DEFAULT NULL COMMENT 'Посты, ответы, комментарии',
  `audit_data` timestamp NOT NULL DEFAULT current_timestamp(),
  `audit_user_id` int(11) NOT NULL DEFAULT 0,
  `audit_content_id` int(11) NOT NULL DEFAULT 0,
  `audit_read_flag` tinyint(1) DEFAULT 0 COMMENT 'Состояние прочтения'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `badge`
--

CREATE TABLE `badge` (
  `badge_id` int(11) NOT NULL,
  `badge_icon` varchar(550) NOT NULL,
  `badge_tl` int(6) DEFAULT NULL,
  `badge_score` int(6) DEFAULT NULL,
  `badge_title` varchar(150) NOT NULL,
  `badge_description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `badge`
--

INSERT INTO `badge` (`badge_id`, `badge_icon`, `badge_tl`, `badge_score`, `badge_title`, `badge_description`) VALUES
(1, '<i title=\"Тестер\" class=\"icon energy\"></i>', 0, 0, 'Тестер', 'Сообщение об ошибке, которое понравилось команде сайта.');

-- --------------------------------------------------------

--
-- Структура таблицы `badge_user`
--

CREATE TABLE `badge_user` (
  `bu_id` int(11) NOT NULL,
  `bu_badge_id` int(6) NOT NULL,
  `bu_user_id` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment_post_id` int(11) NOT NULL DEFAULT 0,
  `comment_answer_id` int(11) NOT NULL DEFAULT 0,
  `comment_comment_id` int(11) NOT NULL DEFAULT 0,
  `comment_user_id` int(11) NOT NULL DEFAULT 0,
  `comment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment_modified` timestamp NOT NULL DEFAULT '2020-12-31 03:00:00',
  `comment_published` tinyint(1) NOT NULL DEFAULT 1,
  `comment_ip` varbinary(42) DEFAULT NULL,
  `comment_after` smallint(6) NOT NULL DEFAULT 0,
  `comment_votes` smallint(6) NOT NULL DEFAULT 0,
  `comment_content` text NOT NULL,
  `comment_is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `favorite`
--

CREATE TABLE `favorite` (
  `favorite_id` mediumint(8) NOT NULL,
  `favorite_user_id` mediumint(8) NOT NULL,
  `favorite_tid` int(11) NOT NULL,
  `favorite_type` tinyint(1) NOT NULL COMMENT '1 посты, 2 комментарии'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `invitation`
--

CREATE TABLE `invitation` (
  `invitation_id` int(10) UNSIGNED NOT NULL,
  `uid` int(11) DEFAULT 0,
  `invitation_code` varchar(32) DEFAULT NULL,
  `invitation_email` varchar(100) DEFAULT NULL,
  `add_time` datetime NOT NULL,
  `add_ip` varchar(45) DEFAULT NULL,
  `active_expire` tinyint(1) DEFAULT 0,
  `active_time` datetime DEFAULT NULL,
  `active_ip` varchar(45) DEFAULT NULL,
  `active_status` tinyint(4) DEFAULT 0,
  `active_uid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `links`
--

CREATE TABLE `links` (
  `link_id` int(11) NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `link_url_domain` varchar(255) DEFAULT NULL,
  `link_title` varchar(250) NOT NULL,
  `link_content` text NOT NULL,
  `link_add_uid` int(11) NOT NULL DEFAULT 0 COMMENT 'Кто добавил',
  `link_user_id` int(11) NOT NULL DEFAULT 0,
  `link_date` datetime NOT NULL DEFAULT current_timestamp(),
  `link_type` int(6) NOT NULL DEFAULT 0 COMMENT 'Тип сайта (0 - общий, 1 - блог, 2 - энциклопедия)',
  `link_status` int(6) NOT NULL DEFAULT 200 COMMENT 'Статус сайта (200, 403, 404)',
  `link_status_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Когда была проверка статуса',
  `link_cat_id` int(11) DEFAULT 0 COMMENT 'Категория сайта',
  `link_votes` int(6) DEFAULT 0,
  `link_count` int(6) DEFAULT 0,
  `link_is_deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL COMMENT 'Отправитель',
  `dialog_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `add_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `sender_remove` tinyint(1) DEFAULT 0,
  `recipient_remove` tinyint(1) DEFAULT 0,
  `receipt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages_dialog`
--

CREATE TABLE `messages_dialog` (
  `id` int(11) NOT NULL,
  `sender_uid` int(11) DEFAULT NULL COMMENT 'Отправитель',
  `sender_unread` int(11) DEFAULT NULL COMMENT 'Отправитель, 0 непрочитано',
  `recipient_uid` int(11) DEFAULT NULL COMMENT 'Получатель',
  `recipient_unread` int(11) DEFAULT NULL COMMENT 'Получатель, 0 непрочитано',
  `add_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `sender_count` int(11) DEFAULT NULL COMMENT 'Отправитель кол.',
  `recipient_count` int(11) DEFAULT NULL COMMENT 'Получатель кол.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `moderations`
--

CREATE TABLE `moderations` (
  `mod_id` int(11) NOT NULL,
  `mod_moderates_user_id` int(11) NOT NULL DEFAULT 0 COMMENT 'Кто меняет',
  `mod_moderates_user_tl` int(11) NOT NULL DEFAULT 0 COMMENT 'Модераторы от tl4',
  `mod_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_post_id` int(11) NOT NULL DEFAULT 0 COMMENT 'id поста',
  `mod_content_id` int(11) NOT NULL DEFAULT 0 COMMENT 'id контента',
  `mod_action` varchar(250) NOT NULL COMMENT 'deleted, restored и т.д.',
  `mod_reason` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `sender_uid` int(11) DEFAULT NULL COMMENT 'Отправитель',
  `recipient_uid` int(11) DEFAULT 0 COMMENT 'Получает ID',
  `action_type` int(4) DEFAULT NULL COMMENT 'Тип оповещения',
  `connection_type` int(11) DEFAULT NULL COMMENT 'Данные источника',
  `url` varchar(250) DEFAULT NULL COMMENT 'URL источника',
  `add_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_flag` tinyint(1) DEFAULT 0 COMMENT 'Состояние прочтения',
  `is_del` tinyint(1) UNSIGNED DEFAULT 0 COMMENT 'Стоит ли удалять'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `post_title` varchar(250) NOT NULL,
  `post_slug` varchar(128) NOT NULL,
  `post_type` smallint(1) NOT NULL DEFAULT 0,
  `post_translation` smallint(1) NOT NULL DEFAULT 0,
  `post_draft` smallint(1) NOT NULL DEFAULT 0,
  `post_space_id` int(11) NOT NULL DEFAULT 0,
  `post_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `post_modified` timestamp NOT NULL DEFAULT current_timestamp(),
  `post_published` tinyint(1) NOT NULL DEFAULT 1,
  `post_user_id` int(10) UNSIGNED NOT NULL,
  `post_ip_int` varchar(45) DEFAULT NULL,
  `post_after` smallint(6) NOT NULL DEFAULT 0 COMMENT 'id первого ответа',
  `post_votes` smallint(6) NOT NULL DEFAULT 0,
  `post_karma` smallint(6) NOT NULL DEFAULT 0,
  `post_answers_count` int(11) DEFAULT 0,
  `post_comments_count` int(11) DEFAULT 0,
  `post_hits_count` int(11) DEFAULT 0,
  `post_content` text NOT NULL,
  `post_content_img` varchar(250) DEFAULT NULL,
  `post_thumb_img` varchar(250) DEFAULT NULL,
  `post_related` varchar(250) DEFAULT NULL,
  `post_merged_id` int(11) NOT NULL DEFAULT 0 COMMENT 'id с чем объединен',
  `post_closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - пост закрыт',
  `post_tl` smallint(1) NOT NULL DEFAULT 0 COMMENT 'Видимость по уровню доверия',
  `post_lo` int(11) NOT NULL DEFAULT 0 COMMENT 'Id лучшего ответа',
  `post_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - пост поднят',
  `post_url` varchar(250) DEFAULT NULL,
  `post_url_domain` varchar(250) DEFAULT NULL,
  `post_is_deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`post_id`, `post_title`, `post_slug`, `post_type`, `post_translation`, `post_draft`, `post_space_id`, `post_date`, `post_modified`, `post_published`, `post_user_id`, `post_ip_int`, `post_after`, `post_votes`, `post_karma`, `post_answers_count`, `post_comments_count`, `post_hits_count`, `post_content`, `post_content_img`, `post_thumb_img`, `post_related`, `post_merged_id`, `post_closed`, `post_tl`, `post_lo`, `post_top`, `post_url`, `post_url_domain`, `post_is_deleted`) VALUES
(1, 'Муха села на варенье, Вот и всё стихотворение...', 'muha-stih', 0, 0, 0, 1, '2021-02-28 06:08:09', '2021-03-05 04:05:25', 1, 1, NULL, 0, 0, 0, 1, 0, 2, '> \"Нет не всё!\" - сказала Муха,\r\n\r\n> Почесала себе брюхо,\r\n\r\n> Свесив с блюдца две ноги,\r\n\r\n> Мне сказала:\"Погоди!\r\n\r\n> Прежде чем сесть на варенье,\r\n\r\n> Я прочла стихотворенье,\r\n\r\n> Неизвестного поэта,\r\n\r\n> Написавшего про это.\r\n\r\n\r\n## Заголовок\r\n\r\nЧто-то в модели много кода:\r\n\r\n```\r\n$db = \\Config\\Database::connect();\r\n$builder = $db->table(\'Posts AS a\');\r\n$builder->select(\'a.*, b.id, b.nickname, b.avatar\');\r\n$builder->join(\"users AS b\", \"b.id = a.post_user_id\");\r\n$builder->where(\'a.post_slug\', $slug);\r\n$builder->orderBy(\'a.post_id\', \'DESC\');\r\n```\r\n\r\nВот. Это первый пост.', NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, 0),
(2, 'Второй пост...', 'vtoroi-post', 0, 0, 0, 2, '2021-02-28 06:15:58', '2021-03-05 04:05:25', 1, 2, NULL, 0, 0, 0, 0, 0, 2, 'Не будет тут про муху. Просто второй пост.\r\n\r\n> в лесу родилась ёлка, зеленая была...', NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, 0),
(3, 'Medium — платформа для создания контента', 'medium-where-good-ideas-find-you', 0, 0, 0, 2, '2021-04-29 22:35:13', '2021-04-29 22:35:13', 1, 1, '127.0.0.1', 0, 0, 0, 1, 0, 1, 'Medium — это платформа для создания контента, основанная соучредителем Blogger и Twitter Эван Уильямсом. Многие компании используют Medium в качестве платформы для публикации...', '2021/c-1624954734.webp', NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `report_user_id` int(11) NOT NULL DEFAULT 0 COMMENT 'Индификатор участника id',
  `report_type` varchar(50) NOT NULL COMMENT 'Тип контента',
  `report_content_id` int(11) NOT NULL DEFAULT 0 COMMENT 'Id контента',
  `report_reason` varchar(255) NOT NULL COMMENT 'Причина флага',
  `report_url` varchar(255) NOT NULL,
  `report_date` datetime NOT NULL DEFAULT current_timestamp(),
  `report_status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `space`
--

CREATE TABLE `space` (
  `space_id` int(11) NOT NULL,
  `space_name` varchar(250) NOT NULL,
  `space_slug` varchar(128) NOT NULL,
  `space_description` varchar(250) NOT NULL,
  `space_img` varchar(250) NOT NULL DEFAULT 'space_no.png',
  `space_cover_art` varchar(250) NOT NULL DEFAULT 'space_cover_no.jpeg',
  `space_text` text NOT NULL,
  `space_short_text` varchar(250) NOT NULL,
  `space_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `space_color` varchar(12) NOT NULL DEFAULT '#f56400',
  `space_category_id` int(11) NOT NULL DEFAULT 1,
  `space_user_id` int(11) NOT NULL DEFAULT 1,
  `space_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - все пространства, 1 - официальные',
  `space_permit_users` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - могут писать все, 1 - только автор',
  `space_feed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - показывать в ленте, 1 - нет',
  `space_tl` int(11) NOT NULL DEFAULT 0 COMMENT 'Видимость по уровню доверия',
  `space_is_delete` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `space`
--

INSERT INTO `space` (`space_id`, `space_name`, `space_slug`, `space_description`, `space_img`, `space_cover_art`, `space_text`, `space_short_text`, `space_date`, `space_color`, `space_category_id`, `space_user_id`, `space_type`, `space_permit_users`, `space_feed`, `space_tl`, `space_is_delete`) VALUES
(1, 'meta', 'meta', 'Мета-обсуждение самого сайта, включая вопросы, предложения и отчеты об ошибках.', 'space_no.png', 'space_cover_no.jpeg', 'тест 1...', 'Короткое описание...', '2021-02-28 06:15:58', '#339900', 1, 1, 1, 0, 0, 0, 0),
(2, 'Вопросы', 'qa', 'Вопросы по скрипту и не только', 'space_no.png', 'space_cover_no.jpeg', 'Вопросы по скрипту и не только', 'Короткое описание...', '2021-02-28 06:15:58', '#333333', 1, 1, 1, 0, 0, 0, 0),
(3, 'флуд', 'flud', 'Просто обычные разговоры', 'space_no.png', 'space_cover_no.jpeg', 'тест 3...', 'Короткое описание...', '2021-02-28 06:15:58', '#f56400', 1, 1, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `space_signed`
--

CREATE TABLE `space_signed` (
  `signed_id` int(11) NOT NULL,
  `signed_space_id` int(11) NOT NULL,
  `signed_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `space_signed`
--

INSERT INTO `space_signed` (`signed_id`, `signed_space_id`, `signed_user_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `stop_words`
--

CREATE TABLE `stop_words` (
  `stop_id` int(11) NOT NULL,
  `stop_word` varchar(50) DEFAULT NULL,
  `stop_add_uid` int(11) NOT NULL DEFAULT 0 COMMENT 'Кто добавил',
  `stop_space_id` int(11) NOT NULL DEFAULT 0 COMMENT '0 - глобально',
  `stop_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `topic`
--

CREATE TABLE `topic` (
  `topic_id` int(11) NOT NULL,
  `topic_title` varchar(64) DEFAULT NULL,
  `topic_description` varchar(255) DEFAULT NULL,
  `topic_info` text DEFAULT NULL,
  `topic_slug` varchar(32) DEFAULT NULL,
  `topic_img` varchar(255) DEFAULT 'topic-default.png',
  `topic_add_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `topic_seo_title` varchar(255) DEFAULT NULL,
  `topic_merged_id` int(11) DEFAULT 0 COMMENT 'с кем слита',
  `topic_parent_id` int(11) DEFAULT 0 COMMENT 'id корневой темы',
  `topic_is_parent` tinyint(1) DEFAULT 0 COMMENT '1 - корневая',
  `topic_tl` tinyint(1) DEFAULT 0,
  `topic_related` varchar(255) DEFAULT NULL,
  `topic_post_related` varchar(255) DEFAULT NULL,
  `topic_space_related` varchar(255) DEFAULT NULL,
  `topic_focus_count` int(11) DEFAULT 0,
  `topic_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `topic`
--

INSERT INTO `topic` (`topic_id`, `topic_title`, `topic_description`, `topic_info`, `topic_slug`, `topic_img`, `topic_add_date`, `topic_seo_title`, `topic_merged_id`, `topic_parent_id`, `topic_is_parent`, `topic_tl`, `topic_related`, `topic_post_related`, `topic_space_related`, `topic_focus_count`, `topic_count`) VALUES
(1, 'SEO', 'Поисковая оптимизация — это комплекс мер по внутренней и внешней оптимизации для поднятия позиций сайта в результатах выдачи поисковых систем.\r\n', 'Комплекс мер по внутренней и внешней оптимизации для поднятия позиций сайта в результатах выдачи поисковых систем по определённым запросам пользователей.\r\n\r\n**Поисковая оптимизация** — это способ использования правил поиска поисковых систем для улучшения текущего естественного ранжирования веб-сайтов в соответствующих поисковых системах. \r\n\r\nЦелью SEO является предоставление экологического решения для саморекламы для веб-сайта, позволяющего веб-сайту занимать лидирующие позиции в отрасли, чтобы получить преимущества бренда. \r\n\r\nSEO включает как внешнее, так и внутреннее SEO. \r\n\r\nSEO средства получить от поисковых систем больше бесплатного трафика, разумное планирование с точки зрения структуры веб-сайта, плана построения контента, взаимодействия с пользователем и общения, страниц и т.д., чтобы сделать веб-сайт более подходящим для принципов индексации поисковых систем. \r\n\r\nПовышение пригодности веб-сайтов для поисковых систем также называется Оптимизацией для поисковых систем, может не только улучшить эффект SEO, но и сделать информацию, относящуюся к веб-сайту, отображаемую в поисковой системе, более привлекательной для пользователей.', 'seo', 't-1-1625149922.jpeg', '2021-06-29 03:29:20', 'Поисковая оптимизация (SEO)', 0, 0, 0, 0, '', NULL, NULL, 0, 1),
(2, 'Интересные сайты', 'Интересные сайты в Интернете. Обзоры, интересные материалы, переводы. Статьи.', 'Интересные сайты в Интернете. Обзоры, интересные материалы, переводы. Статьи.\r\n\r\nПросто вводная страница... В разработке...', 'sites', 't-2-1625149821.jpeg', '2021-06-29 03:29:20', 'Интересные сайты', 0, 0, 0, 0, '1', '3', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `topic_merge`
--

CREATE TABLE `topic_merge` (
  `merge_id` int(11) NOT NULL,
  `merge_add_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `merge_source_id` int(11) NOT NULL DEFAULT 0,
  `merge_target_id` int(11) NOT NULL DEFAULT 0,
  `merge_user_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `topic_post_relation`
--

CREATE TABLE `topic_post_relation` (
  `relation_topic_id` int(11) DEFAULT 0,
  `relation_post_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `topic_post_relation`
--

INSERT INTO `topic_post_relation` (`relation_topic_id`, `relation_post_id`) VALUES
(1, 1),
(2, 2),
(3, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `topic_signed`
--

CREATE TABLE `topic_signed` (
  `signed_id` int(11) NOT NULL,
  `signed_topic_id` int(11) NOT NULL,
  `signed_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `activated` tinyint(1) NOT NULL,
  `reg_ip` varchar(45) DEFAULT NULL,
  `trust_level` int(11) NOT NULL COMMENT 'Уровень доверия. По умолчанию 0 (5 - админ)',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `invitation_available` int(10) NOT NULL DEFAULT 0,
  `invitation_id` int(11) NOT NULL DEFAULT 0,
  `avatar` varchar(250) NOT NULL DEFAULT 'noavatar.png',
  `cover_art` varchar(250) NOT NULL DEFAULT 'cover_art.jpeg',
  `color` varchar(12) NOT NULL DEFAULT '#f56400',
  `about` varchar(250) DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `public_email` varchar(50) DEFAULT NULL,
  `skype` varchar(50) DEFAULT NULL,
  `twitter` varchar(50) DEFAULT NULL,
  `telegram` varchar(50) DEFAULT NULL,
  `vk` varchar(50) DEFAULT NULL,
  `rating` int(11) DEFAULT 0,
  `my_post` int(11) DEFAULT 0 COMMENT 'Пост выведенный в профиль',
  `ban_list` tinyint(1) DEFAULT 0,
  `hits_count` int(11) DEFAULT 0,
  `is_deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `name`, `email`, `password`, `activated`, `reg_ip`, `trust_level`, `created_at`, `updated_at`, `invitation_available`, `invitation_id`, `avatar`, `cover_art`, `color`, `about`, `website`, `location`, `public_email`, `skype`, `twitter`, `telegram`, `vk`, `rating`, `my_post`, `ban_list`, `hits_count`, `is_deleted`) VALUES
(1, 'AdreS', 'Олег', 'ss@sdf.ru', '$2y$10$oR5VZ.zk7IN/og70gQq/f.0Sb.GQJ33VZHIES4pyIpU3W2vF6aiaW', 1, NULL, 5, '2021-03-08 21:37:04', '2021-03-08 21:37:04', 0, 0, 'img_1.jpg', 'cover_art.jpeg', '#f56400', 'Тестовый аккаунт', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0),
(2, 'test', NULL, 'test@test.ru', '$2y$10$Iahcsh3ima0kGqgk6S/SSui5/ETU5bQueYROFhOsjUU/z1.xynR7W', 1, '127.0.0.1', 1, '2021-04-30 07:42:52', '2021-04-30 07:42:52', 0, 0, 'noavatar.png', 'cover_art.jpeg', '#339900', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users_activate`
--

CREATE TABLE `users_activate` (
  `activate_id` int(11) NOT NULL,
  `activate_date` datetime NOT NULL,
  `activate_user_id` int(11) NOT NULL,
  `activate_code` varchar(50) NOT NULL,
  `activate_flag` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users_auth_tokens`
--

CREATE TABLE `users_auth_tokens` (
  `auth_id` int(11) NOT NULL,
  `auth_user_id` int(11) NOT NULL,
  `auth_selector` varchar(255) NOT NULL,
  `auth_hashedvalidator` varchar(255) NOT NULL,
  `auth_expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users_banlist`
--

CREATE TABLE `users_banlist` (
  `banlist_id` int(11) NOT NULL,
  `banlist_user_id` int(11) NOT NULL,
  `banlist_ip` varchar(45) NOT NULL,
  `banlist_bandate` timestamp NOT NULL DEFAULT current_timestamp(),
  `banlist_int_num` int(11) NOT NULL,
  `banlist_int_period` varchar(20) NOT NULL,
  `banlist_status` tinyint(1) NOT NULL DEFAULT 1,
  `banlist_autodelete` tinyint(1) NOT NULL DEFAULT 0,
  `banlist_cause` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users_email_activate`
--

CREATE TABLE `users_email_activate` (
  `id` int(11) NOT NULL,
  `pubdate` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `email_code` varchar(50) NOT NULL,
  `email_activate_flag` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users_logs`
--

CREATE TABLE `users_logs` (
  `logs_id` int(11) NOT NULL,
  `logs_user_id` int(11) NOT NULL,
  `logs_login` varchar(255) NOT NULL,
  `logs_trust_level` int(11) NOT NULL,
  `logs_ip_address` varchar(45) NOT NULL,
  `logs_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users_logs`
--

INSERT INTO `users_logs` (`logs_id`, `logs_user_id`, `logs_login`, `logs_trust_level`, `logs_ip_address`, `logs_date`) VALUES
(1, 1, 'AdreS', 5, '127.0.0.1', '2021-04-30 07:19:27'),
(2, 2, 'test', 1, '127.0.0.1', '2021-04-30 07:43:04'),
(3, 1, 'AdreS', 5, '127.0.0.1', '2021-07-02 07:33:25'),
(4, 2, 'test', 1, '127.0.0.1', '2021-07-02 07:34:26'),
(5, 1, 'AdreS', 5, '127.0.0.1', '2021-07-02 07:35:28');

-- --------------------------------------------------------

--
-- Структура таблицы `users_notification_setting`
--

CREATE TABLE `users_notification_setting` (
  `notice_setting_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `data` text DEFAULT NULL COMMENT 'Информация'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users_trust_level`
--

CREATE TABLE `users_trust_level` (
  `trust_id` int(11) NOT NULL,
  `trust_name` varchar(85) NOT NULL,
  `trust_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users_trust_level`
--

INSERT INTO `users_trust_level` (`trust_id`, `trust_name`, `trust_count`) VALUES
(0, 'Посетитель', 0),
(1, 'Пользователь', 0),
(2, 'Участник', 0),
(3, 'Постоялец', 0),
(4, 'Лидер', 0),
(5, 'Персонал', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `votes_answer`
--

CREATE TABLE `votes_answer` (
  `votes_answer_id` int(11) NOT NULL,
  `votes_answer_item_id` int(11) NOT NULL,
  `votes_answer_points` int(11) NOT NULL,
  `votes_answer_ip` varchar(45) NOT NULL,
  `votes_answer_user_id` int(11) NOT NULL DEFAULT 1,
  `votes_answer_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `votes_comment`
--

CREATE TABLE `votes_comment` (
  `votes_comment_id` int(11) NOT NULL,
  `votes_comment_item_id` int(11) NOT NULL,
  `votes_comment_points` int(11) NOT NULL,
  `votes_comment_ip` varchar(45) NOT NULL,
  `votes_comment_user_id` int(11) NOT NULL DEFAULT 1,
  `votes_comment_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `votes_link`
--

CREATE TABLE `votes_link` (
  `votes_link_id` int(11) NOT NULL,
  `votes_link_item_id` int(11) NOT NULL,
  `votes_link_points` int(11) NOT NULL,
  `votes_link_ip` varchar(45) NOT NULL,
  `votes_link_user_id` int(11) NOT NULL DEFAULT 1,
  `votes_link_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `votes_post`
--

CREATE TABLE `votes_post` (
  `votes_post_id` int(11) NOT NULL,
  `votes_post_item_id` int(11) NOT NULL,
  `votes_post_points` int(11) NOT NULL,
  `votes_post_ip` varchar(45) NOT NULL,
  `votes_post_user_id` int(11) NOT NULL DEFAULT 1,
  `votes_post_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `answer_link_id_2` (`answer_post_id`,`answer_date`),
  ADD KEY `answer_date` (`answer_date`),
  ADD KEY `answer_user_id` (`answer_user_id`,`answer_date`),
  ADD KEY `answer_post_id` (`answer_post_id`,`answer_order`);

--
-- Индексы таблицы `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `audit_type` (`audit_type`),
  ADD KEY `audit_user_id` (`audit_user_id`),
  ADD KEY `audit_content_id` (`audit_content_id`);

--
-- Индексы таблицы `badge`
--
ALTER TABLE `badge`
  ADD PRIMARY KEY (`badge_id`);

--
-- Индексы таблицы `badge_user`
--
ALTER TABLE `badge_user`
  ADD PRIMARY KEY (`bu_id`),
  ADD KEY `bu_badge_id` (`bu_badge_id`),
  ADD KEY `bu_user_id` (`bu_user_id`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `comment_link_id_2` (`comment_post_id`,`comment_date`),
  ADD KEY `comment_date` (`comment_date`),
  ADD KEY `comment_user_id` (`comment_user_id`,`comment_date`);

--
-- Индексы таблицы `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `favorite_user_id` (`favorite_id`),
  ADD KEY `favorite_id` (`favorite_tid`);

--
-- Индексы таблицы `invitation`
--
ALTER TABLE `invitation`
  ADD PRIMARY KEY (`invitation_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `invitation_code` (`invitation_code`),
  ADD KEY `active_time` (`active_time`),
  ADD KEY `active_ip` (`active_ip`),
  ADD KEY `active_status` (`active_status`);

--
-- Индексы таблицы `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`link_id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dialog_id` (`dialog_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `add_time` (`add_time`),
  ADD KEY `sender_remove` (`sender_remove`),
  ADD KEY `recipient_remove` (`recipient_remove`),
  ADD KEY `sender_receipt` (`receipt`);

--
-- Индексы таблицы `messages_dialog`
--
ALTER TABLE `messages_dialog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipient_uid` (`recipient_uid`),
  ADD KEY `sender_uid` (`sender_uid`),
  ADD KEY `update_time` (`update_time`),
  ADD KEY `add_time` (`add_time`);

--
-- Индексы таблицы `moderations`
--
ALTER TABLE `moderations`
  ADD PRIMARY KEY (`mod_id`);

--
-- Индексы таблицы `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `recipient_read_flag` (`recipient_uid`,`read_flag`),
  ADD KEY `sender_uid` (`sender_uid`),
  ADD KEY `action_type` (`action_type`),
  ADD KEY `add_time` (`add_time`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `post_date` (`post_date`),
  ADD KEY `post_user_id` (`post_user_id`,`post_date`);

--
-- Индексы таблицы `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `status` (`report_status`);

--
-- Индексы таблицы `space`
--
ALTER TABLE `space`
  ADD PRIMARY KEY (`space_id`);

--
-- Индексы таблицы `space_signed`
--
ALTER TABLE `space_signed`
  ADD PRIMARY KEY (`signed_id`);

--
-- Индексы таблицы `stop_words`
--
ALTER TABLE `stop_words`
  ADD PRIMARY KEY (`stop_id`);

--
-- Индексы таблицы `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`topic_id`),
  ADD KEY `topic_slug` (`topic_slug`),
  ADD KEY `topic_merged_id` (`topic_merged_id`);

--
-- Индексы таблицы `topic_merge`
--
ALTER TABLE `topic_merge`
  ADD PRIMARY KEY (`merge_id`),
  ADD KEY `merge_source_id` (`merge_source_id`),
  ADD KEY `merge_target_id` (`merge_target_id`),
  ADD KEY `merge_user_id` (`merge_user_id`);

--
-- Индексы таблицы `topic_post_relation`
--
ALTER TABLE `topic_post_relation`
  ADD KEY `relation_topic_id` (`relation_topic_id`),
  ADD KEY `relation_content_id` (`relation_post_id`);

--
-- Индексы таблицы `topic_signed`
--
ALTER TABLE `topic_signed`
  ADD PRIMARY KEY (`signed_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_activate`
--
ALTER TABLE `users_activate`
  ADD PRIMARY KEY (`activate_id`);

--
-- Индексы таблицы `users_auth_tokens`
--
ALTER TABLE `users_auth_tokens`
  ADD PRIMARY KEY (`auth_id`);

--
-- Индексы таблицы `users_banlist`
--
ALTER TABLE `users_banlist`
  ADD PRIMARY KEY (`banlist_id`),
  ADD KEY `banlist_ip` (`banlist_ip`),
  ADD KEY `banlist_user_id` (`banlist_user_id`);

--
-- Индексы таблицы `users_email_activate`
--
ALTER TABLE `users_email_activate`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_logs`
--
ALTER TABLE `users_logs`
  ADD PRIMARY KEY (`logs_id`);

--
-- Индексы таблицы `users_notification_setting`
--
ALTER TABLE `users_notification_setting`
  ADD PRIMARY KEY (`notice_setting_id`),
  ADD KEY `uid` (`uid`);

--
-- Индексы таблицы `users_trust_level`
--
ALTER TABLE `users_trust_level`
  ADD PRIMARY KEY (`trust_id`);

--
-- Индексы таблицы `votes_answer`
--
ALTER TABLE `votes_answer`
  ADD PRIMARY KEY (`votes_answer_id`),
  ADD KEY `votes_answer_item_id` (`votes_answer_item_id`,`votes_answer_user_id`),
  ADD KEY `votes_answer_ip` (`votes_answer_item_id`,`votes_answer_ip`),
  ADD KEY `votes_answer_user_id` (`votes_answer_user_id`);

--
-- Индексы таблицы `votes_comment`
--
ALTER TABLE `votes_comment`
  ADD PRIMARY KEY (`votes_comment_id`),
  ADD KEY `votes_comment_item_id` (`votes_comment_item_id`,`votes_comment_user_id`),
  ADD KEY `votes_comment_ip` (`votes_comment_item_id`,`votes_comment_ip`),
  ADD KEY `votes_comment_user_id` (`votes_comment_user_id`);

--
-- Индексы таблицы `votes_link`
--
ALTER TABLE `votes_link`
  ADD PRIMARY KEY (`votes_link_id`),
  ADD KEY `votes_link_item_id` (`votes_link_item_id`,`votes_link_user_id`),
  ADD KEY `votes_link_ip` (`votes_link_item_id`,`votes_link_ip`),
  ADD KEY `votes_link_user_id` (`votes_link_user_id`);

--
-- Индексы таблицы `votes_post`
--
ALTER TABLE `votes_post`
  ADD PRIMARY KEY (`votes_post_id`),
  ADD KEY `votes_post_item_id` (`votes_post_item_id`,`votes_post_user_id`),
  ADD KEY `votes_post_ip` (`votes_post_item_id`,`votes_post_ip`),
  ADD KEY `votes_post_user_id` (`votes_post_user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `answers`
--
ALTER TABLE `answers`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `audits`
--
ALTER TABLE `audits`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `badge`
--
ALTER TABLE `badge`
  MODIFY `badge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `badge_user`
--
ALTER TABLE `badge_user`
  MODIFY `bu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `favorite`
--
ALTER TABLE `favorite`
  MODIFY `favorite_id` mediumint(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `invitation`
--
ALTER TABLE `invitation`
  MODIFY `invitation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `links`
--
ALTER TABLE `links`
  MODIFY `link_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages_dialog`
--
ALTER TABLE `messages_dialog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `moderations`
--
ALTER TABLE `moderations`
  MODIFY `mod_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `space`
--
ALTER TABLE `space`
  MODIFY `space_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `space_signed`
--
ALTER TABLE `space_signed`
  MODIFY `signed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `stop_words`
--
ALTER TABLE `stop_words`
  MODIFY `stop_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `topic`
--
ALTER TABLE `topic`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `topic_merge`
--
ALTER TABLE `topic_merge`
  MODIFY `merge_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `topic_signed`
--
ALTER TABLE `topic_signed`
  MODIFY `signed_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users_activate`
--
ALTER TABLE `users_activate`
  MODIFY `activate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users_auth_tokens`
--
ALTER TABLE `users_auth_tokens`
  MODIFY `auth_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users_banlist`
--
ALTER TABLE `users_banlist`
  MODIFY `banlist_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users_email_activate`
--
ALTER TABLE `users_email_activate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `logs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users_notification_setting`
--
ALTER TABLE `users_notification_setting`
  MODIFY `notice_setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `votes_answer`
--
ALTER TABLE `votes_answer`
  MODIFY `votes_answer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `votes_comment`
--
ALTER TABLE `votes_comment`
  MODIFY `votes_comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `votes_link`
--
ALTER TABLE `votes_link`
  MODIFY `votes_link_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `votes_post`
--
ALTER TABLE `votes_post`
  MODIFY `votes_post_id` int(11) NOT NULL AUTO_INCREMENT;