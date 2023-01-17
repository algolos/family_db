CREATE TABLE IF NOT EXISTS `persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) DEFAULT NULL,
  `firstname` TINYTEXT,
  `patronymic` TINYTEXT,
  `secondname` TINYTEXT,
  `birth_date` datetime(6) DEFAULT NULL,
  `death_date` datetime(6) DEFAULT NULL,
  `foto` LONGBLOB,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `spouses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_1` int(10) unsigned,
  `person_2` int(10) unsigned,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `children` (
  `spouses_id` int(10) unsigned,
  `person` int(10) unsigned,
  `create_time` datetime(6) DEFAULT NULL 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
