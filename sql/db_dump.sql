CREATE TABLE IF NOT EXISTS `persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `firstname` varchar(50),
  `patronymic` varchar(50),
  `secondname` varchar(50),
  `gender` varchar(1),
  `birth_date` varchar(20),
  `death_date` varchar(20),
  `foto` LONGBLOB,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `spouses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_1_id` int(10) unsigned,
  `person_2_id` int(10) unsigned,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `children` (
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `spouses_id` int(10) unsigned,
  `person_id` int(10) unsigned
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `families` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `family_name` varchar(50),
  `info` MEDIUMTEXT, 
  PRIMARY KEY (`id`) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `families_heads` (
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `family_id` int(10) unsigned,
  `person_id` int(10) unsigned
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER //

CREATE OR REPLACE PROCEDURE add_person (
  in_firstname varchar(50), 
  in_patronymic varchar(50), 
  in_secondname varchar(50),
  in_gender varchar(1), 
  in_birth_date varchar(20), 
  in_death_date varchar(20),
  in_foto LONGBLOB
)
 BEGIN
  INSERT INTO persons(firstname, 
                      patronymic, 
                      secondname, 
                      gender,
                      birth_date, 
                      death_date,
                      foto)
  values(in_firstname,
    in_patronymic, 
   in_secondname,
   in_gender, 
   in_birth_date, 
   in_death_date,
   in_foto);
 END;
//

CREATE OR REPLACE PROCEDURE add_family (
  in_family_name varchar(50), 
  in_info MEDIUMTEXT
)
 BEGIN
  INSERT INTO family(family_name, 
                      info)
  values(in_family_name,
    in_info);
 END;
//

CREATE OR REPLACE PROCEDURE add_spouses (
  in_person_1_id varchar(50), 
  in_person_2_id varchar(50)
)
 BEGIN
  INSERT INTO family(person_1_id, 
                     person_2_id)
  values(in_person_1_id,
         in_person_2_id);
 END;
 //

DELIMITER ;