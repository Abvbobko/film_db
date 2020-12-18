-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema film_service_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema film_service_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `film_service_db` DEFAULT CHARACTER SET utf8 ;
USE `film_service_db` ;

-- -----------------------------------------------------
-- Table `film_service_db`.`User_Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Role` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Role` (
  `idUser_Role` INT NOT NULL,
  `name` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idUser_Role`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `film_service_db`.`User_Role` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User` (
  `idUser` INT NOT NULL,
  `User_Role_id` INT NOT NULL,
  `login` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `mail` VARCHAR(255) NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_User_User_Role1`
    FOREIGN KEY (`User_Role_id`)
    REFERENCES `film_service_db`.`User_Role` (`idUser_Role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_User_Role1_idx` ON `film_service_db`.`User` (`User_Role_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `mail_UNIQUE` ON `film_service_db`.`User` (`mail` ASC) VISIBLE;

CREATE UNIQUE INDEX `login_UNIQUE` ON `film_service_db`.`User` (`login` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film` (
  `idFilm` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `release_date` DATE NULL,
  `duration` INT NULL,
  `age_restriction` INT NULL,
  PRIMARY KEY (`idFilm`))
ENGINE = InnoDB;

CREATE INDEX `find_by_name` ON `film_service_db`.`Film` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Folder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Folder` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Folder` (
  `idUser_Folder` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`idUser_Folder`),
  CONSTRAINT `fk_User_Folder_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Folder_User1_idx` ON `film_service_db`.`User_Folder` (`User_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Film` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Film` (
  `User_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `User_Folder_id` INT NOT NULL,
  `score` INT NULL,
  PRIMARY KEY (`User_Folder_id`, `Film_id`, `User_id`),
  CONSTRAINT `fk_User_Film_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Film_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Film_User_Folder1`
    FOREIGN KEY (`User_Folder_id`)
    REFERENCES `film_service_db`.`User_Folder` (`idUser_Folder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Film_Film1_idx` ON `film_service_db`.`User_Film` (`Film_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Film_User_Folder1_idx` ON `film_service_db`.`User_Film` (`User_Folder_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio` (
  `idStudio` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `foundation_date` DATE NULL,
  PRIMARY KEY (`idStudio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio_Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio_Film` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio_Film` (
  `Studio_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Studio_id`, `Film_id`),
  CONSTRAINT `fk_Studio_Film_Studio1`
    FOREIGN KEY (`Studio_id`)
    REFERENCES `film_service_db`.`Studio` (`idStudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studio_Film_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Studio_Film_Film1_idx` ON `film_service_db`.`Studio_Film` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Country` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Country` (
  `idCountry` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `film_service_db`.`Country` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio_Country_office`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio_Country_office` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio_Country_office` (
  `idStudio_Country_office` INT NOT NULL,
  `Studio_id` INT NOT NULL,
  `Country_id` INT NOT NULL,
  `website` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `foundation_date` DATE NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idStudio_Country_office`),
  CONSTRAINT `fk_Studio_Country_office_Studio1`
    FOREIGN KEY (`Studio_id`)
    REFERENCES `film_service_db`.`Studio` (`idStudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studio_Country_office_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `film_service_db`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Studio_Country_office_Studio1_idx` ON `film_service_db`.`Studio_Country_office` (`Studio_id` ASC) VISIBLE;

CREATE INDEX `fk_Studio_Country_office_Country1_idx` ON `film_service_db`.`Studio_Country_office` (`Country_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Country` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Country` (
  `Country_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  PRIMARY KEY (`Country_id`, `Film_id`),
  CONSTRAINT `fk_Film_Country_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `film_service_db`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Country_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Country_Film1_idx` ON `film_service_db`.`Film_Country` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Genre` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Genre` (
  `idGenre` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenre`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `film_service_db`.`Genre` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Genre` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Genre` (
  `Film_id` INT NOT NULL,
  `Genre_id` INT NOT NULL,
  PRIMARY KEY (`Film_id`, `Genre_id`),
  CONSTRAINT `fk_Film_Genre_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Genre_Genre1`
    FOREIGN KEY (`Genre_id`)
    REFERENCES `film_service_db`.`Genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Genre_Genre1_idx` ON `film_service_db`.`Film_Genre` (`Genre_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person` (
  `idPerson` INT NOT NULL,
  `birth_date` DATE NULL,
  `death_date` DATE NULL,
  `first_name` VARCHAR(255) NULL,
  `second_name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB;

CREATE INDEX `name_family` ON `film_service_db`.`Person` (`first_name` ASC, `second_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person_in_Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person_in_Film` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person_in_Film` (
  `idPerson_in_Film` INT NOT NULL,
  `Person_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `role` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idPerson_in_Film`),
  CONSTRAINT `fk_Person_in_Film_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `film_service_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_in_Film_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Person_in_Film_Person1_idx` ON `film_service_db`.`Person_in_Film` (`Person_id` ASC) VISIBLE;

CREATE INDEX `fk_Person_in_Film_Film1_idx` ON `film_service_db`.`Person_in_Film` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Award` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Award` (
  `idAward` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `location` VARCHAR(255) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`idAward`))
ENGINE = InnoDB;

CREATE INDEX `name` ON `film_service_db`.`Award` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Award` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Award` (
  `idFilm_Award` INT NOT NULL,
  `Award_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_winner` BIT NULL,
  PRIMARY KEY (`idFilm_Award`),
  CONSTRAINT `fk_Film_Award_Award1`
    FOREIGN KEY (`Award_id`)
    REFERENCES `film_service_db`.`Award` (`idAward`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Award_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Award_Award1_idx` ON `film_service_db`.`Film_Award` (`Award_id` ASC) VISIBLE;

CREATE INDEX `fk_Film_Award_Film1_idx` ON `film_service_db`.`Film_Award` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio_Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio_Award` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio_Award` (
  `idStudio_Award` INT NOT NULL,
  `Award_id` INT NOT NULL,
  `Studio_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_winner` BIT NULL,
  PRIMARY KEY (`idStudio_Award`),
  CONSTRAINT `fk_Studio_Award_Award1`
    FOREIGN KEY (`Award_id`)
    REFERENCES `film_service_db`.`Award` (`idAward`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studio_Award_Studio1`
    FOREIGN KEY (`Studio_id`)
    REFERENCES `film_service_db`.`Studio` (`idStudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Studio_Award_Award1_idx` ON `film_service_db`.`Studio_Award` (`Award_id` ASC) VISIBLE;

CREATE INDEX `fk_Studio_Award_Studio1_idx` ON `film_service_db`.`Studio_Award` (`Studio_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person_Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person_Award` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person_Award` (
  `idPerson_Award` INT NOT NULL,
  `Person_id` INT NOT NULL,
  `Award_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `is_winner` BIT NULL,
  PRIMARY KEY (`idPerson_Award`),
  CONSTRAINT `fk_Person_Award_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `film_service_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_Award_Award1`
    FOREIGN KEY (`Award_id`)
    REFERENCES `film_service_db`.`Award` (`idAward`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Person_Award_Person1_idx` ON `film_service_db`.`Person_Award` (`Person_id` ASC) VISIBLE;

CREATE INDEX `fk_Person_Award_Award1_idx` ON `film_service_db`.`Person_Award` (`Award_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Festival`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Festival` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Festival` (
  `idFestival` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `date` DATE NULL,
  `description` VARCHAR(255) NULL,
  `location` VARCHAR(255) NULL,
  PRIMARY KEY (`idFestival`))
ENGINE = InnoDB;

CREATE INDEX `find_by_name` ON `film_service_db`.`Festival` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Festival_Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Festival_Award` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Festival_Award` (
  `idFestival_Award` INT NOT NULL,
  `Festival_id` INT NOT NULL,
  `Award_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idFestival_Award`),
  CONSTRAINT `fk_Festival_Award_Festival1`
    FOREIGN KEY (`Festival_id`)
    REFERENCES `film_service_db`.`Festival` (`idFestival`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Festival_Award_Award1`
    FOREIGN KEY (`Award_id`)
    REFERENCES `film_service_db`.`Award` (`idAward`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Festival_Award_Festival1_idx` ON `film_service_db`.`Festival_Award` (`Festival_id` ASC) VISIBLE;

CREATE INDEX `fk_Festival_Award_Award1_idx` ON `film_service_db`.`Festival_Award` (`Award_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Article` (
  `idArticle` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `title` VARCHAR(255) NOT NULL,
  `text_location` VARCHAR(255) NOT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`idArticle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_in_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_in_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_in_Article` (
  `Article_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Article_id`, `Film_id`),
  CONSTRAINT `fk_Film_in_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_in_Article_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_in_Article_Film1_idx` ON `film_service_db`.`Film_in_Article` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person_in_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person_in_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person_in_Article` (
  `Article_id` INT NOT NULL,
  `Person_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Article_id`, `Person_id`),
  CONSTRAINT `fk_Person_in_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_in_Article_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `film_service_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Person_in_Article_Person1_idx` ON `film_service_db`.`Person_in_Article` (`Person_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio_in_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio_in_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio_in_Article` (
  `Article_id` INT NOT NULL,
  `Studio_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Article_id`, `Studio_id`),
  CONSTRAINT `fk_Studio_in_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studio_in_Article_Studio1`
    FOREIGN KEY (`Studio_id`)
    REFERENCES `film_service_db`.`Studio` (`idStudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Studio_in_Article_Studio1_idx` ON `film_service_db`.`Studio_in_Article` (`Studio_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Cinema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Cinema` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Cinema` (
  `idCinema` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `website` VARCHAR(255) NULL,
  PRIMARY KEY (`idCinema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Session` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Session` (
  `idFilm_Session` INT NOT NULL,
  `Cinema_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `screening_date` DATETIME NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idFilm_Session`),
  CONSTRAINT `fk_Film_Session_Cinema1`
    FOREIGN KEY (`Cinema_id`)
    REFERENCES `film_service_db`.`Cinema` (`idCinema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Session_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Session_Cinema1_idx` ON `film_service_db`.`Film_Session` (`Cinema_id` ASC) VISIBLE;

CREATE INDEX `fk_Film_Session_Film1_idx` ON `film_service_db`.`Film_Session` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Festival`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Festival` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Festival` (
  `idFilm_Festival` INT NOT NULL,
  `Festival_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idFilm_Festival`),
  CONSTRAINT `fk_Film_Festival_Festival1`
    FOREIGN KEY (`Festival_id`)
    REFERENCES `film_service_db`.`Festival` (`idFestival`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Festival_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Festival_Festival1_idx` ON `film_service_db`.`Film_Festival` (`Festival_id` ASC) VISIBLE;

CREATE INDEX `fk_Film_Festival_Film1_idx` ON `film_service_db`.`Film_Festival` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Photo` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Photo` (
  `idPhoto` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `photo_location` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idPhoto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Photo` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Photo` (
  `Photo_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Photo_id`, `Film_id`),
  CONSTRAINT `fk_Film_Photo_Photo1`
    FOREIGN KEY (`Photo_id`)
    REFERENCES `film_service_db`.`Photo` (`idPhoto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Photo_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Photo_Film1_idx` ON `film_service_db`.`Film_Photo` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person_Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person_Photo` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person_Photo` (
  `Photo_id` INT NOT NULL,
  `Person_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Photo_id`, `Person_id`),
  CONSTRAINT `fk_Person_Photo_Photo1`
    FOREIGN KEY (`Photo_id`)
    REFERENCES `film_service_db`.`Photo` (`idPhoto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_Photo_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `film_service_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Person_Photo_Person1_idx` ON `film_service_db`.`Person_Photo` (`Person_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Studio_Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Studio_Photo` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Studio_Photo` (
  `Photo_id` INT NOT NULL,
  `Studio_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Photo_id`, `Studio_id`),
  CONSTRAINT `fk_Studio_Photo_Photo1`
    FOREIGN KEY (`Photo_id`)
    REFERENCES `film_service_db`.`Photo` (`idPhoto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studio_Photo_Studio1`
    FOREIGN KEY (`Studio_id`)
    REFERENCES `film_service_db`.`Studio` (`idStudio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Studio_Photo_Studio1_idx` ON `film_service_db`.`Studio_Photo` (`Studio_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Soundtrack`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Soundtrack` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Soundtrack` (
  `idSoundtrack` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `soundtack_location` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `time_in_film` INT NULL,
  PRIMARY KEY (`idSoundtrack`),
  CONSTRAINT `fk_Soundtrack_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Soundtrack_Film1_idx` ON `film_service_db`.`Soundtrack` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Franchise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Franchise` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Franchise` (
  `idFranchise` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idFranchise`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_in_Franchise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_in_Franchise` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_in_Franchise` (
  `idFilm_in_Franchise` INT NOT NULL,
  `Franchise_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `number` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idFilm_in_Franchise`),
  CONSTRAINT `fk_Film_in_Franchise_Franchise1`
    FOREIGN KEY (`Franchise_id`)
    REFERENCES `film_service_db`.`Franchise` (`idFranchise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_in_Franchise_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_in_Franchise_Franchise1_idx` ON `film_service_db`.`Film_in_Franchise` (`Franchise_id` ASC) VISIBLE;

CREATE INDEX `fk_Film_in_Franchise_Film1_idx` ON `film_service_db`.`Film_in_Franchise` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Video` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Video` (
  `idVideo` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `video_location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idVideo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`Film_Video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Film_Video` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Film_Video` (
  `Video_id` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Video_id`, `Film_id`),
  CONSTRAINT `fk_Film_Video_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `film_service_db`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Video_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Film_Video_Film1_idx` ON `film_service_db`.`Film_Video` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Series` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Series` (
  `idSeries` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `closing_date` DATE NULL,
  PRIMARY KEY (`idSeries`),
  CONSTRAINT `fk_Series_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Series_Film1_idx` ON `film_service_db`.`Series` (`Film_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Season` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Season` (
  `idSeason` INT NOT NULL,
  `Series_id` INT NOT NULL,
  `  name` VARCHAR(255) NULL,
  `number` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idSeason`),
  CONSTRAINT `fk_Season_Series1`
    FOREIGN KEY (`Series_id`)
    REFERENCES `film_service_db`.`Series` (`idSeries`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Season_Series1_idx` ON `film_service_db`.`Season` (`Series_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Episode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Episode` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Episode` (
  `idEpisode` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `number` INT NOT NULL,
  `duration` INT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`idEpisode`),
  CONSTRAINT `fk_Episode_Season1`
    FOREIGN KEY (`Season_id`)
    REFERENCES `film_service_db`.`Season` (`idSeason`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Episode_Season1_idx` ON `film_service_db`.`Episode` (`Season_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Emotion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Emotion` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Emotion` (
  `like` BIT NOT NULL,
  PRIMARY KEY (`like`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Genre` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Genre` (
  `Genre_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `emotion` BIT NOT NULL,
  PRIMARY KEY (`Genre_id`, `User_id`),
  CONSTRAINT `fk_User_Genre_Genre1`
    FOREIGN KEY (`Genre_id`)
    REFERENCES `film_service_db`.`Genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Genre_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Genre_Emotion1`
    FOREIGN KEY (`emotion`)
    REFERENCES `film_service_db`.`Emotion` (`like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Genre_User1_idx` ON `film_service_db`.`User_Genre` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Genre_Emotion1_idx` ON `film_service_db`.`User_Genre` (`emotion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Country` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Country` (
  `Country_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `Emotion_like` BIT NOT NULL,
  PRIMARY KEY (`Country_id`, `User_id`),
  CONSTRAINT `fk_User_Country_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `film_service_db`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Country_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Country_Emotion1`
    FOREIGN KEY (`Emotion_like`)
    REFERENCES `film_service_db`.`Emotion` (`like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Country_User1_idx` ON `film_service_db`.`User_Country` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Country_Emotion1_idx` ON `film_service_db`.`User_Country` (`Emotion_like` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Article` (
  `User_id` INT NOT NULL,
  `Article_id` INT NOT NULL,
  `Emotion_like` BIT NOT NULL,
  PRIMARY KEY (`User_id`, `Article_id`),
  CONSTRAINT `fk_User_Article_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Article_Emotion1`
    FOREIGN KEY (`Emotion_like`)
    REFERENCES `film_service_db`.`Emotion` (`like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Article_Article1_idx` ON `film_service_db`.`User_Article` (`Article_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Article_Emotion1_idx` ON `film_service_db`.`User_Article` (`Emotion_like` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Film_Session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Film_Session` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Film_Session` (
  `Film_Session_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`Film_Session_id`, `User_id`),
  CONSTRAINT `fk_User_Film_Session_Film_Session1`
    FOREIGN KEY (`Film_Session_id`)
    REFERENCES `film_service_db`.`Film_Session` (`idFilm_Session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Film_Session_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Film_Session_User1_idx` ON `film_service_db`.`User_Film_Session` (`User_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Person_on_Festival`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Person_on_Festival` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Person_on_Festival` (
  `Festival_id` INT NOT NULL,
  `Person_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Festival_id`, `Person_id`),
  CONSTRAINT `fk_Person_Festival_Festival1`
    FOREIGN KEY (`Festival_id`)
    REFERENCES `film_service_db`.`Festival` (`idFestival`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_Festival_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `film_service_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Person_Festival_Person1_idx` ON `film_service_db`.`Person_on_Festival` (`Person_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Photo_in_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Photo_in_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Photo_in_Article` (
  `Article_id` INT NOT NULL,
  `Photo_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Article_id`, `Photo_id`),
  CONSTRAINT `fk_Photo_in_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Photo_in_Article_Photo1`
    FOREIGN KEY (`Photo_id`)
    REFERENCES `film_service_db`.`Photo` (`idPhoto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Photo_in_Article_Photo1_idx` ON `film_service_db`.`Photo_in_Article` (`Photo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Video_in_Article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Video_in_Article` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Video_in_Article` (
  `Article_id` INT NOT NULL,
  `Video_id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`Article_id`, `Video_id`),
  CONSTRAINT `fk_Video_in_Article_Article1`
    FOREIGN KEY (`Article_id`)
    REFERENCES `film_service_db`.`Article` (`idArticle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_in_Article_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `film_service_db`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Video_in_Article_Video1_idx` ON `film_service_db`.`Video_in_Article` (`Video_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`User_Franchise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`User_Franchise` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`User_Franchise` (
  `Franchise_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `Emotion_like` BIT NOT NULL,
  PRIMARY KEY (`Franchise_id`, `User_id`),
  CONSTRAINT `fk_User_Franchise_Franchise1`
    FOREIGN KEY (`Franchise_id`)
    REFERENCES `film_service_db`.`Franchise` (`idFranchise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Franchise_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Franchise_Emotion1`
    FOREIGN KEY (`Emotion_like`)
    REFERENCES `film_service_db`.`Emotion` (`like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_Franchise_Franchise1_idx` ON `film_service_db`.`User_Franchise` (`Franchise_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Franchise_User1_idx` ON `film_service_db`.`User_Franchise` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Franchise_Emotion1_idx` ON `film_service_db`.`User_Franchise` (`Emotion_like` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `film_service_db`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `film_service_db`.`Comment` ;

CREATE TABLE IF NOT EXISTS `film_service_db`.`Comment` (
  `idComment` INT NOT NULL,
  `Film_id` INT NOT NULL,
  `User_id` INT NULL,
  `text` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idComment`),
  CONSTRAINT `fk_Comment_Film1`
    FOREIGN KEY (`Film_id`)
    REFERENCES `film_service_db`.`Film` (`idFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comment_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `film_service_db`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comment_Film1_idx` ON `film_service_db`.`Comment` (`Film_id` ASC) VISIBLE;

CREATE INDEX `fk_Comment_User1_idx` ON `film_service_db`.`Comment` (`User_id` ASC) VISIBLE;

USE `film_service_db`;
DROP function IF EXISTS `film_service_db`.`get_old_birth_date`;

DELIMITER $$
USE `film_service_db`$$
CREATE FUNCTION `get_old_birth_date` (person_id INT)
RETURNS DATE DETERMINISTIC
BEGIN
	RETURN (SELECT birth_date FROM Person 
    WHERE idPerson = person_id ORDER BY id DESC LIMIT 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_old_death_date
-- -----------------------------------------------------

USE `film_service_db`;
DROP function IF EXISTS `film_service_db`.`get_old_death_date`;

DELIMITER $$
USE `film_service_db`$$
CREATE FUNCTION `get_old_death_date` (person_id INT)
RETURNS DATE DETERMINISTIC
BEGIN
	RETURN (SELECT death_date FROM Person 
    WHERE idPerson = person_id ORDER BY id DESC LIMIT 1);
END$$

DELIMITER ;



USE `film_service_db`;

DELIMITER $$

USE `film_service_db`$$
DROP TRIGGER IF EXISTS `film_service_db`.`Person_BEFORE_INSERT` $$
USE `film_service_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `film_service_db`.`Person_BEFORE_INSERT` BEFORE INSERT ON `Person` FOR EACH ROW
BEGIN
	IF NEW.birth_date > DATE(NOW()) THEN
		SET NEW.birth_date = NULL;
	END IF;
END$$


USE `film_service_db`$$
DROP TRIGGER IF EXISTS `film_service_db`.`Person_BEFORE_INSERT_1` $$
USE `film_service_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `film_service_db`.`Person_BEFORE_INSERT_1` BEFORE INSERT ON `Person` FOR EACH ROW
BEGIN
	IF NEW.death_date > DATE(NOW()) THEN
		SET NEW.death_date = NULL;
	END IF;
END$$


USE `film_service_db`$$
DROP TRIGGER IF EXISTS `film_service_db`.`Person_BEFORE_UPDATE` $$
USE `film_service_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `film_service_db`.`Person_BEFORE_UPDATE` BEFORE UPDATE ON `Person` FOR EACH ROW
BEGIN
	IF NEW.birth_date > DATE(NOW()) THEN
		SET NEW.birth_date = get_old_birth_date(NEW.idPerson);
	END IF;
    IF NEW.death_date > DATE(NOW()) THEN
		SET NEW.death_date = get_old_death_date(NEW.idPerson);
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `film_service_db`.`Person`
-- -----------------------------------------------------
START TRANSACTION;
USE `film_service_db`;
INSERT INTO `film_service_db`.`Person` (`idPerson`, `birth_date`, `death_date`, `first_name`, `second_name`, `description`) VALUES (1, '2012-01-01', NULL, 'John', 'Smith', NULL);

COMMIT;

