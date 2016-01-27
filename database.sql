-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema payments_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema payments_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `payments_db` DEFAULT CHARACTER SET utf8 ;
USE `payments_db` ;

-- -----------------------------------------------------
-- Table `payments_db`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments_db`.`client` (
  `idclient` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `phonenumber` VARCHAR(13) NOT NULL,
  `is_admin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idclient`),
  UNIQUE INDEX `idclient_UNIQUE` (`idclient` ASC),
  UNIQUE INDEX `phonenumber_UNIQUE` (`phonenumber` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `payments_db`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments_db`.`account` (
  `idaccount` INT(16) ZEROFILL NOT NULL AUTO_INCREMENT,
  `client_idclient` INT NOT NULL,
  `currency` VARCHAR(7) NOT NULL,
  `amount` DECIMAL(12,2) NOT NULL,
  `is_blocked` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idaccount`),
  UNIQUE INDEX `idaccount_UNIQUE` (`idaccount` ASC),
  INDEX `fk_account_client_idx` (`client_idclient` ASC),
  CONSTRAINT `fk_account_client`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `payments_db`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `payments_db`.`refill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments_db`.`refill` (
  `idrefill` INT NOT NULL AUTO_INCREMENT,
  `account_idaccount` INT(16) ZEROFILL NOT NULL,
  `amount` DECIMAL(12,2) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrefill`),
  UNIQUE INDEX `idrefill_UNIQUE` (`idrefill` ASC),
  INDEX `fk_refill_account1_idx` (`account_idaccount` ASC),
  CONSTRAINT `fk_refill_account1`
    FOREIGN KEY (`account_idaccount`)
    REFERENCES `payments_db`.`account` (`idaccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `payments_db`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments_db`.`payment` (
  `idpayment` INT NOT NULL AUTO_INCREMENT,
  `account_idaccount` INT(16) ZEROFILL NOT NULL,
  `idaccountTO` INT(16) ZEROFILL NOT NULL,
  `amount` DECIMAL(12,2) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpayment`),
  UNIQUE INDEX `idpayment_UNIQUE` (`idpayment` ASC),
  INDEX `fk_payment_account1_idx` (`account_idaccount` ASC),
  CONSTRAINT `fk_payment_account1`
    FOREIGN KEY (`account_idaccount`)
    REFERENCES `payments_db`.`account` (`idaccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `payments_db`.`credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payments_db`.`credit_card` (
  `account_idaccount` INT(16) ZEROFILL NOT NULL,
  `type` VARCHAR(13) NOT NULL,
  `cvv2_code` INT NOT NULL,
  `date_works` DATE NOT NULL,
  `password` INT NOT NULL,
  PRIMARY KEY (`account_idaccount`),
  CONSTRAINT `fk_credit_card_account1`
    FOREIGN KEY (`account_idaccount`)
    REFERENCES `payments_db`.`account` (`idaccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
