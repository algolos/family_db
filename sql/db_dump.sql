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
) ;


CREATE TABLE IF NOT EXISTS `spouses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_id_1` int(10) unsigned,
  `person_id_2` int(10) unsigned,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) 
  ) ;


CREATE TABLE IF NOT EXISTS `children` (
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `spouses_id` int(10) unsigned,
  `person_id` int(10) unsigned
  ) ;


CREATE TABLE IF NOT EXISTS `families` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `family_name` varchar(50),
  `info` MEDIUMTEXT, 
  PRIMARY KEY (`id`) 
  ) ;

CREATE TABLE IF NOT EXISTS `families_heads` (
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `family_id` int(10) unsigned,
  `person_id` int(10) unsigned
  ) ;

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
  INSERT INTO families(family_name, 
                      info)
  values(in_family_name,
    in_info);
 END;
//

CREATE OR REPLACE PROCEDURE add_head (
  IN in_family_name varchar(50), 
  IN in_firstname varchar(50),
  IN in_patronymic varchar(50),
  IN in_secondname varchar(50)
)
 BEGIN
  
  CALL get_person_id(in_firstname, in_patronymic, in_secondname, @person_id);

  CALL get_family_id(in_family_name, @family_id);

  INSERT INTO families_heads(family_id, 
                             person_id)
                    values(@family_id,
                           @person_id);
 END;
//

CREATE OR REPLACE PROCEDURE add_spouses (
   IN in_firstname_1 varchar(50),
   IN in_patronymic_1 varchar(50),
   IN in_secondname_1 varchar(50),
   IN in_firstname_2 varchar(50),
   IN in_patronymic_2 varchar(50),
   IN in_secondname_2 varchar(50)
)
 BEGIN
  -- DECLARE person_id_1 int(10) unsigned;
  -- DECLARE person_id_2 int(10) unsigned;

  CALL get_person_id(in_firstname_1, in_patronymic_1, in_secondname_1, @person_id_1);
  CALL get_person_id(in_firstname_2, in_patronymic_2, in_secondname_2, @person_id_2);

  INSERT INTO spouses(person_id_1, 
                     person_id_2)
  values(@person_id_1,
         @person_id_2); 
 END;
//

CREATE OR REPLACE PROCEDURE add_chaild (
  in_spouses_id int(10) unsigned,
  in_person_id int(10) unsigned
)
 BEGIN
  INSERT INTO children(spouses_id, 
                     person_id)
  values(in_spouses_id,
         in_person_id);
 END;
//
CREATE OR REPLACE PROCEDURE get_person_id (
   IN in_firstname varchar(50),
   IN in_patronymic varchar(50),
   IN in_secondname varchar(50),
   OUT person_id int(10) unsigned 
)
 BEGIN
  
  DECLARE validator int(3) unsigned;

  SET validator = (SELECT COUNT(id) FROM persons WHERE firstname=in_firstname
    and patronymic=in_patronymic
    and secondname=in_secondname);

  IF validator = 0 THEN 
    SET person_id = 0;
  ELSEIF validator = 1 THEN 
    SET person_id = (SELECT id FROM persons WHERE firstname=in_firstname
                                                  and patronymic=in_patronymic
                                                  and secondname=in_secondname);
  ELSE SIGNAL SQLSTATE '45000' SET 
      MESSAGE_TEXT = 'Returns more than 1 record';
  END IF;
  #SET person_id = in_firstname;

 END;

//

CREATE OR REPLACE PROCEDURE get_family_id (
   IN in_family_name varchar(50),
   OUT family_id int(10) unsigned 
)
 BEGIN
  
  DECLARE validator int(3) unsigned;

  SET validator = (SELECT COUNT(id) FROM families WHERE family_name=in_family_name);

  IF validator = 0 THEN 
    SET family_id = 0;
  ELSEIF validator = 1 THEN 
    SET family_id = (SELECT id FROM families WHERE family_name=in_family_name);
  ELSE SIGNAL SQLSTATE '45000' SET 
      MESSAGE_TEXT = 'Returns more than 1 record';
  END IF;

 END;

//

DELIMITER ;