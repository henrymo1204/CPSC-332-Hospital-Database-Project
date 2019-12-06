-- MySQL Script generated by MySQL Workbench
-- Tue Nov 19 06:33:25 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cpsc332_db_project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cpsc332_db_project` ;

-- -----------------------------------------------------
-- Schema cpsc332_db_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cpsc332_db_project` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
SHOW WARNINGS;
USE `cpsc332_db_project` ;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`person` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`person` (
  `person_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `street_address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  `ssn` VARCHAR(45) NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `person_id_UNIQUE` ON `cpsc332_db_project`.`person` (`person_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`doctor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`doctor` (
  `doctor_id` VARCHAR(10) NOT NULL,
  `fk_person_id` INT NOT NULL,
  `medial_degree` VARCHAR(45) NULL,
  PRIMARY KEY (`doctor_id`),
  CONSTRAINT `fk_doctor_person1`
    FOREIGN KEY (`fk_person_id`)
    REFERENCES `cpsc332_db_project`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_doctor_person1_idx` ON `cpsc332_db_project`.`doctor` (`fk_person_id` ASC) ;

SHOW WARNINGS;
CREATE UNIQUE INDEX `doctor_id_UNIQUE` ON `cpsc332_db_project`.`doctor` (`doctor_id` ASC) ;

SHOW WARNINGS;
CREATE UNIQUE INDEX `fk_person_id_UNIQUE` ON `cpsc332_db_project`.`doctor` (`fk_person_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`prescription` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`prescription` (
  `prescription_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`prescription_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`patient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `fk_person_id` INT NOT NULL,
  `DOB` DATE NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `fk_patient_person`
    FOREIGN KEY (`fk_person_id`)
    REFERENCES `cpsc332_db_project`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_patient_person1_idx` ON `cpsc332_db_project`.`patient` (`fk_person_id` ASC) ;

SHOW WARNINGS;
CREATE UNIQUE INDEX `fk_person_id_UNIQUE` ON `cpsc332_db_project`.`patient` (`fk_person_id` ASC) ;

SHOW WARNINGS;
CREATE UNIQUE INDEX `patient_id_UNIQUE` ON `cpsc332_db_project`.`patient` (`patient_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`visit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`visit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`visit` (
  `visit_id` INT NOT NULL,
  `fk_patient_id` INT NOT NULL,
  `fk_doctor_id` VARCHAR(10) NOT NULL,
  `date` DATETIME NOT NULL,
  `room` VARCHAR(45) NOT NULL,
  `doc_note` TEXT(256) NULL,
  PRIMARY KEY (`visit_id`),
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`fk_patient_id`)
    REFERENCES `cpsc332_db_project`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_doctor1`
    FOREIGN KEY (`fk_doctor_id`)
    REFERENCES `cpsc332_db_project`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_appointment_doctor1_idx` ON `cpsc332_db_project`.`visit` (`fk_doctor_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`test` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`test` (
  `test_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`test_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`specialty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`specialty` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`specialty` (
  `spec_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`spec_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `spec_id_UNIQUE` ON `cpsc332_db_project`.`specialty` (`spec_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`doctor_specialty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`doctor_specialty` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`doctor_specialty` (
  `fk_doctor_id` VARCHAR(10) NOT NULL,
  `fk_spec_id` INT NOT NULL,
  PRIMARY KEY (`fk_doctor_id`, `fk_spec_id`),
  CONSTRAINT `fk_doctor_has_specialty_doctor1`
    FOREIGN KEY (`fk_doctor_id`)
    REFERENCES `cpsc332_db_project`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctor_has_specialty_specialty1`
    FOREIGN KEY (`fk_spec_id`)
    REFERENCES `cpsc332_db_project`.`specialty` (`spec_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_doctor_has_specialty_specialty1_idx` ON `cpsc332_db_project`.`doctor_specialty` (`fk_spec_id` ASC) ;

SHOW WARNINGS;
CREATE INDEX `fk_doctor_has_specialty_doctor1_idx` ON `cpsc332_db_project`.`doctor_specialty` (`fk_doctor_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`specialty_audit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`specialty_audit` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`specialty_audit` (
  `audit_id` INT NOT NULL AUTO_INCREMENT,
  `doctor_name` VARCHAR(45) NULL,
  `action` ENUM("updated", "added") NULL,
  `specialty` VARCHAR(45) NULL,
  `date_of_modificaiton` DATETIME NULL,
  PRIMARY KEY (`audit_id`))
ENGINE = InnoDB;
ALTER TABLE `cpsc332_db_project`.`specialty_audit` AUTO_INCREMENT=1000; 
SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`appointment_test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`appointment_test` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`appointment_test` (
  `fk_test_id` INT NOT NULL,
  `fk_appointment_id` INT NOT NULL,
  PRIMARY KEY (`fk_test_id`, `fk_appointment_id`),
  CONSTRAINT `fk_appointment_has_test_test1`
    FOREIGN KEY (`fk_test_id`)
    REFERENCES `cpsc332_db_project`.`test` (`test_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_test_appointment1`
    FOREIGN KEY (`fk_appointment_id`)
    REFERENCES `cpsc332_db_project`.`visit` (`visit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_appointment_has_test_test1_idx` ON `cpsc332_db_project`.`appointment_test` (`fk_test_id` ASC) ;

SHOW WARNINGS;
CREATE INDEX `fk_appointment_test_appointment1_idx` ON `cpsc332_db_project`.`appointment_test` (`fk_appointment_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cpsc332_db_project`.`visit_prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cpsc332_db_project`.`visit_prescription` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `cpsc332_db_project`.`visit_prescription` (
  `fk_visit_id` INT NOT NULL,
  `fk_prescription_id` INT NOT NULL,
  PRIMARY KEY (`fk_visit_id`, `fk_prescription_id`),
  CONSTRAINT `fk_medicine_has_appointment_medicine1`
    FOREIGN KEY (`fk_prescription_id`)
    REFERENCES `cpsc332_db_project`.`prescription` (`prescription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicine_has_appointment_appointment1`
    FOREIGN KEY (`fk_visit_id`)
    REFERENCES `cpsc332_db_project`.`visit` (`visit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medicine_has_appointment_appointment1_idx` ON `cpsc332_db_project`.`visit_prescription` (`fk_visit_id` ASC) ;

SHOW WARNINGS;
CREATE INDEX `fk_medicine_has_appointment_medicine1_idx` ON `cpsc332_db_project`.`visit_prescription` (`fk_prescription_id` ASC) ;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- insert records
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (1, 'Rob', 'Belkin', '310-229-1351', '12 Bowman Lane', 'Inglewood', 'California', 58944, '166-21-0167');
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (2, 'Irvine', 'Abadam', '215-154-7171', '65 Commercial Terrace', 'Philadelphia', 'Pennsylvania', 77869, '559-08-1691');
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (3, 'Ebony', 'Geater', '718-392-3551', '932 Birchwood Court', 'Brooklyn', 'New York', 99654, '600-75-7774');
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (4, 'Minta', 'Cloy', '208-509-1004', '64299 Westport Lane', 'Boise', 'Idaho', 35656, '411-41-0304');
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (5, 'Leonhard', 'Hodge', '432-626-6088', '0 Crowley Park', 'Odessa', 'Texas', 38962, '502-64-8693');
insert into person (person_id, first_name, last_name, phone, street_address, city, state, zip, ssn) values (6, 'Tabb', 'Chipchase', '612-929-9531', '6346 Holmberg Terrace', 'Minneapolis', 'Minnesota', 21020, '255-78-9062');

insert into doctor (doctor_id, fk_person_id, medial_degree) values ('RB1111',1,'UCLA');
insert into doctor (doctor_id, fk_person_id, medial_degree) values ('IA2222',2,'USC');
insert into doctor (doctor_id, fk_person_id, medial_degree) values ('EG3333',3,'UCLA');

insert into patient(patient_id, fk_person_id, DOB) values (11,4,'1986-12-17');
insert into patient(patient_id, fk_person_id, DOB) values (12,5,'1969-07-02');
insert into patient(patient_id, fk_person_id, DOB) values (13,6,'1989-11-13');
insert into patient(patient_id, fk_person_id, DOB) values (14,2,'1970-04-20');

insert into prescription(prescription_id, name) values (21,'Panadol');
insert into prescription(prescription_id, name) values (22,'Xadril');
insert into prescription(prescription_id, name) values (23,'Dapins');

insert into visit(visit_id,fk_patient_id,fk_doctor_id,date,room,doc_note) values (31,11,'RB1111','2019-12-02','101','Coughing');
insert into visit(visit_id,fk_patient_id,fk_doctor_id,date,room,doc_note) values (32,12,'IA2222','2019-12-02','102','Sneezing');
insert into visit(visit_id,fk_patient_id,fk_doctor_id,date,room,doc_note) values (33,13,'EG3333','2019-12-01','103','Bleeding');
insert into visit(visit_id,fk_patient_id,fk_doctor_id,date,room,doc_note) values (34,14,'RB1111','2019-12-02','101','Ear infection');

insert into test(test_id,name) values (41,'Blood');
insert into test(test_id,name) values (42,'Physical');
insert into test(test_id,name) values (43,'X-Ray');

insert into specialty(spec_id,name) values (51,'Anesthesiology');
insert into specialty(spec_id,name) values (52,'Dermatology');
insert into specialty(spec_id,name) values (53,'Otolaryngology');

insert into doctor_specialty(fk_doctor_id, fk_spec_id) values ('RB1111',51);
insert into doctor_specialty(fk_doctor_id, fk_spec_id) values ('RB1111',52);
insert into doctor_specialty(fk_doctor_id, fk_spec_id) values ('IA2222',53);

insert into appointment_test(fk_test_id,fk_appointment_id) values (41,31);
insert into appointment_test(fk_test_id,fk_appointment_id) values (42,31);
insert into appointment_test(fk_test_id,fk_appointment_id) values (41,32);
insert into appointment_test(fk_test_id,fk_appointment_id) values (43,32);
insert into appointment_test(fk_test_id,fk_appointment_id) values (41,33);
insert into appointment_test(fk_test_id,fk_appointment_id) values (41,34);

insert into visit_prescription(fk_visit_id,fk_prescription_id) values (31,21);
insert into visit_prescription(fk_visit_id,fk_prescription_id) values (32,22);
insert into visit_prescription(fk_visit_id,fk_prescription_id) values (33,23);
insert into visit_prescription(fk_visit_id,fk_prescription_id) values (34,21);
insert into visit_prescription(fk_visit_id,fk_prescription_id) values (34,22);
insert into visit_prescription(fk_visit_id,fk_prescription_id) values (34,23);
