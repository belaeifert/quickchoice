-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema quickchoice
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema quickchoice
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quickchoice` DEFAULT CHARACTER SET utf8 ;
USE `quickchoice` ;

-- -----------------------------------------------------
-- Table `quickchoice`.`tb_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_cliente` (
  `idt_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome_cliente` VARCHAR(255) NOT NULL,
  `cpf_cliente` INT NOT NULL,
  PRIMARY KEY (`idt_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quickchoice`.`tb_restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_restaurante` (
  `idt_restaurante` INT NOT NULL AUTO_INCREMENT,
  `tb_restaurante_franquia` INT NULL,
  `nome_restaurante` VARCHAR(500) NOT NULL,
  `cnpj_restaurante` INT NOT NULL,
  `seguro_celiaco_restaurante` TINYINT(1) NOT NULL,
  `filial_restaurante` TINYINT(1) NOT NULL,
  `endereco_restaurante` VARCHAR(1000) NOT NULL,
  `cep_restaurante` INT NOT NULL,
  PRIMARY KEY (`idt_restaurante`),
  CONSTRAINT `fk_tb_restaurante_tb_restaurante1`
    FOREIGN KEY (`tb_restaurante_franquia`)
    REFERENCES `quickchoice`.`tb_restaurante` (`idt_restaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_restaurante_tb_restaurante1_idx` ON `quickchoice`.`tb_restaurante` (`tb_restaurante_franquia` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`disponibilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`disponibilidade` (
  `idt_disponibilidade` INT NOT NULL AUTO_INCREMENT,
  `disponibilidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idt_disponibilidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quickchoice`.`tb_item_cardapio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_item_cardapio` (
  `idt_item_cardapio` INT NOT NULL AUTO_INCREMENT,
  `cod_restaurante` INT NOT NULL,
  `cod_disponibilidade` INT NOT NULL,
  `nome_item` VARCHAR(255) NOT NULL,
  `descricao_item` VARCHAR(1000) NOT NULL,
  `imagem_item` VARCHAR(45) NOT NULL,
  `individual_item` TINYINT(1) NOT NULL,
  `compartilhado_qtd` INT NULL,
  PRIMARY KEY (`idt_item_cardapio`),
  CONSTRAINT `fk_tb_item_cardapio_tb_restaurante1`
    FOREIGN KEY (`cod_restaurante`)
    REFERENCES `quickchoice`.`tb_restaurante` (`idt_restaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_item_cardapio_disponibilidade1`
    FOREIGN KEY (`cod_disponibilidade`)
    REFERENCES `quickchoice`.`disponibilidade` (`idt_disponibilidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_item_cardapio_tb_restaurante1_idx` ON `quickchoice`.`tb_item_cardapio` (`cod_restaurante` ASC);

CREATE INDEX `fk_tb_item_cardapio_disponibilidade1_idx` ON `quickchoice`.`tb_item_cardapio` (`cod_disponibilidade` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`tb_mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_mesa` (
  `idt_mesa` INT NOT NULL AUTO_INCREMENT,
  `cod_cliente` INT NOT NULL,
  `nome_mesa` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idt_mesa`),
  CONSTRAINT `fk_tb_mesa_tb_cliente1`
    FOREIGN KEY (`cod_cliente`)
    REFERENCES `quickchoice`.`tb_cliente` (`idt_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_mesa_tb_cliente1_idx` ON `quickchoice`.`tb_mesa` (`cod_cliente` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`tb_garçom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_garçom` (
  `idt_garçom` INT NOT NULL AUTO_INCREMENT,
  `cod_restaurante` INT NOT NULL,
  `nome_garcom` VARCHAR(255) NOT NULL,
  `cpf_garcom` INT NOT NULL,
  PRIMARY KEY (`idt_garçom`),
  CONSTRAINT `fk_tb_garçom_tb_restaurante`
    FOREIGN KEY (`cod_restaurante`)
    REFERENCES `quickchoice`.`tb_restaurante` (`idt_restaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_garçom_tb_restaurante_idx` ON `quickchoice`.`tb_garçom` (`cod_restaurante` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`tb_alergenicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`tb_alergenicos` (
  `idt_alergenicos` INT NOT NULL AUTO_INCREMENT,
  `cod_item_cardapio` INT NOT NULL,
  `nome_alergenico` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`idt_alergenicos`),
  CONSTRAINT `fk_tb_alergenicos_tb_item_cardapio1`
    FOREIGN KEY (`cod_item_cardapio`)
    REFERENCES `quickchoice`.`tb_item_cardapio` (`idt_item_cardapio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_alergenicos_tb_item_cardapio1_idx` ON `quickchoice`.`tb_alergenicos` (`cod_item_cardapio` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`ta_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`ta_pedido` (
  `idt_pedido` INT NOT NULL AUTO_INCREMENT,
  `tb_garçom_idt_garçom` INT NOT NULL,
  `tb_mesa_idt_mesa` INT NOT NULL,
  `hr_atendimento` DATE NOT NULL,
  PRIMARY KEY (`idt_pedido`),
  CONSTRAINT `fk_tb_garçom_has_tb_mesa_tb_garçom1`
    FOREIGN KEY (`tb_garçom_idt_garçom`)
    REFERENCES `quickchoice`.`tb_garçom` (`idt_garçom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_garçom_has_tb_mesa_tb_mesa1`
    FOREIGN KEY (`tb_mesa_idt_mesa`)
    REFERENCES `quickchoice`.`tb_mesa` (`idt_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tb_garçom_has_tb_mesa_tb_mesa1_idx` ON `quickchoice`.`ta_pedido` (`tb_mesa_idt_mesa` ASC);

CREATE INDEX `fk_tb_garçom_has_tb_mesa_tb_garçom1_idx` ON `quickchoice`.`ta_pedido` (`tb_garçom_idt_garçom` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`ta_pedido_has_tb_item_cardapio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`ta_pedido_has_tb_item_cardapio` (
  `ta_pedido_idt_pedido` INT NOT NULL,
  `tb_item_cardapio_idt_item_cardapio` INT NOT NULL,
  CONSTRAINT `fk_ta_pedido_has_tb_item_cardapio_ta_pedido1`
    FOREIGN KEY (`ta_pedido_idt_pedido`)
    REFERENCES `quickchoice`.`ta_pedido` (`idt_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ta_pedido_has_tb_item_cardapio_tb_item_cardapio1`
    FOREIGN KEY (`tb_item_cardapio_idt_item_cardapio`)
    REFERENCES `quickchoice`.`tb_item_cardapio` (`idt_item_cardapio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ta_pedido_has_tb_item_cardapio_tb_item_cardapio1_idx` ON `quickchoice`.`ta_pedido_has_tb_item_cardapio` (`tb_item_cardapio_idt_item_cardapio` ASC);

CREATE INDEX `fk_ta_pedido_has_tb_item_cardapio_ta_pedido1_idx` ON `quickchoice`.`ta_pedido_has_tb_item_cardapio` (`ta_pedido_idt_pedido` ASC);


-- -----------------------------------------------------
-- Table `quickchoice`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `quickchoice`.`area` (
  `idt_area` INT NOT NULL,
  `cod_mesa` INT NOT NULL,
  `tipo_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idt_area`),
  CONSTRAINT `fk_area_tb_mesa1`
    FOREIGN KEY (`cod_mesa`)
    REFERENCES `quickchoice`.`tb_mesa` (`idt_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_area_tb_mesa1_idx` ON `quickchoice`.`area` (`cod_mesa` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
