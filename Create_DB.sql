-- MySQL Script generated by MySQL Workbench
-- Sat May  9 15:14:01 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Uprawnienia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Uprawnienia` (
  `idUprawnienia` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUprawnienia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Osoby`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Osoby` (
  `idOsoba` INT NOT NULL AUTO_INCREMENT,
  `idUprawnienia` INT NOT NULL,
  `eMail` VARCHAR(45) NOT NULL,
  `Haslo` VARCHAR(45) NOT NULL,
  `Imie` VARCHAR(45) NOT NULL,
  `Nazwisko` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOsoba`),
  CONSTRAINT `idUprawnienia`
    FOREIGN KEY (`idUprawnienia`)
    REFERENCES `mydb`.`Uprawnienia` (`idUprawnienia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacjenci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacjenci` (
  `idPacjent` INT NOT NULL AUTO_INCREMENT,
  `idOsoba` INT NOT NULL,
  `Imie` VARCHAR(45) NOT NULL,
  `Gatunek` VARCHAR(45) NOT NULL,
  `DataUrodzenia` DATETIME NOT NULL,
  `Rasa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPacjent`),
  INDEX `idOsoby_idx` (`idOsoba` ASC) VISIBLE,
  CONSTRAINT `idOsoby`
    FOREIGN KEY (`idOsoba`)
    REFERENCES `mydb`.`Osoby` (`idOsoba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Choroby`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Choroby` (
  `idChoroby` INT NOT NULL AUTO_INCREMENT,
  `Kod` INT NOT NULL,
  `Wartosc` INT NOT NULL,
  PRIMARY KEY (`idChoroby`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diagnozy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnozy` (
  `idDiagnozy` INT NOT NULL AUTO_INCREMENT,
  `idChoroby` INT NOT NULL,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Opis` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDiagnozy`),
  INDEX `idChoroby_idx` (`idChoroby` ASC) VISIBLE,
  CONSTRAINT `idChoroby`
    FOREIGN KEY (`idChoroby`)
    REFERENCES `mydb`.`Choroby` (`idChoroby`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LekiIMaterialy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LekiIMaterialy` (
  `idLekiIMaterialy` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Cena` INT NOT NULL,
  `Ilosc` INT NOT NULL,
  PRIMARY KEY (`idLekiIMaterialy`),
  UNIQUE INDEX `Nazwa_UNIQUE` (`Nazwa` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recepty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recepty` (
  `idRecepty` INT NOT NULL AUTO_INCREMENT,
  `idLekiIMaterialy` INT NOT NULL,
  `SposóbDawkowania` VARCHAR(45) NOT NULL,
  `Zalecenia` VARCHAR(45) NULL,
  PRIMARY KEY (`idRecepty`),
  INDEX `idLekiIMaterialy_idx` (`idLekiIMaterialy` ASC) VISIBLE,
  CONSTRAINT `idLekiIMaterialy`
    FOREIGN KEY (`idLekiIMaterialy`)
    REFERENCES `mydb`.`LekiIMaterialy` (`idLekiIMaterialy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zabiegi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zabiegi` (
  `idZabiegi` INT NOT NULL AUTO_INCREMENT,
  `idLekiiMaterialy` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Opis` VARCHAR(360) NULL,
  PRIMARY KEY (`idZabiegi`),
  INDEX `idLekiIMaterialy_idx` (`idLekiiMaterialy` ASC) VISIBLE,
  CONSTRAINT `idLekiIMaterialy`
    FOREIGN KEY (`idLekiiMaterialy`)
    REFERENCES `mydb`.`LekiIMaterialy` (`idLekiIMaterialy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Wizyty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Wizyty` (
  `idWizyty` INT NOT NULL AUTO_INCREMENT,
  `idDiagnozy` INT NOT NULL,
  `idPacjent` INT NOT NULL,
  `idRecepty` INT NOT NULL,
  `idZabiegi` INT NOT NULL,
  `DataPlanowania` DATETIME NOT NULL,
  `Status` INT NOT NULL,
  `DataOdbycia` DATETIME NULL,
  `DlugoscTrwania` TIME NULL,
  `Opis` VARCHAR(360) NULL,
  PRIMARY KEY (`idWizyty`),
  INDEX `idDiagnozy_idx` (`idDiagnozy` ASC) VISIBLE,
  INDEX `idPacjent_idx` (`idPacjent` ASC) VISIBLE,
  INDEX `idRecepty_idx` (`idRecepty` ASC) VISIBLE,
  INDEX `idZabiegi_idx` (`idZabiegi` ASC) VISIBLE,
  CONSTRAINT `idPacjent`
    FOREIGN KEY (`idPacjent`)
    REFERENCES `mydb`.`Pacjenci` (`idPacjent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idDiagnozy`
    FOREIGN KEY (`idDiagnozy`)
    REFERENCES `mydb`.`Diagnozy` (`idDiagnozy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idRecepty`
    FOREIGN KEY (`idRecepty`)
    REFERENCES `mydb`.`Recepty` (`idRecepty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idZabiegi`
    FOREIGN KEY (`idZabiegi`)
    REFERENCES `mydb`.`Zabiegi` (`idZabiegi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
