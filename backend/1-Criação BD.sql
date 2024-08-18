-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

CREATE SCHEMA BD_Trabalho;

use BD_Trabalho;

-- -----------------------------------------------------
-- Table Pessoa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pessoa (
  idPessoa INT NOT NULL AUTO_INCREMENT,
  ehCliente TINYINT NOT NULL,
  PRIMARY KEY (idPessoa))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PessoaFone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PessoaFone (
  Pessoa_idPessoa INT NOT NULL,
  fone CHAR(14) NOT NULL,
  PRIMARY KEY (Pessoa_idPessoa, fone),
  CONSTRAINT fk_fone_Pessoa1
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PessoaFisica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PessoaFisica (
  Pessoa_idPessoa INT NOT NULL,
  cpf CHAR(11) NOT NULL,
  nome VARCHAR(80) NOT NULL,
  PRIMARY KEY (Pessoa_idPessoa),
  INDEX fk_PessoaFisica_Pessoa1_idx (Pessoa_idPessoa ASC),
  UNIQUE INDEX cpf_UNIQUE (cpf ASC),
  CONSTRAINT fk_PessoaFisica_Pessoa1
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PessoaJuridica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PessoaJuridica (
  Pessoa_idPessoa INT NOT NULL,
  cnpj CHAR(14) NOT NULL,
  razaoSocial VARCHAR(45) NOT NULL UNIQUE,
  nomeFantasia VARCHAR(45) NULL,
  fornecedor TINYINT NOT NULL,
  transportadora TINYINT NOT NULL,
  PRIMARY KEY (Pessoa_idPessoa),
  INDEX fk_PessoaJuridica_Pessoa1_idx (Pessoa_idPessoa ASC),
  UNIQUE INDEX cnpj_UNIQUE (cnpj ASC),
  CONSTRAINT fk_PessoaJuridica_Pessoa1
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Vendedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Vendedor (
  PessoaFisica_Pessoa_idPessoa INT NOT NULL,
  numRegistro INT NOT NULL,
  dataAdimissao DATE NOT NULL,
  PRIMARY KEY (PessoaFisica_Pessoa_idPessoa),
  UNIQUE INDEX numRegistro_UNIQUE (numRegistro ASC),
  CONSTRAINT fk_Vendedor_PessoaFisica1
    FOREIGN KEY (PessoaFisica_Pessoa_idPessoa)
    REFERENCES PessoaFisica (Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido (
  id INT NOT NULL AUTO_INCREMENT,
  Pessoa_idPessoa INT NOT NULL,
  dataPedido DATE NOT NULL,
  situacao CHAR(12) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Pedido_Pessoa1_idx (Pessoa_idPessoa ASC),
  CONSTRAINT fk_Pedido_Pessoa1
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PedidoVenda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PedidoVenda (
  Pedido_id INT NOT NULL,
  Vendedor_PessoaFisica_Pessoa_idPessoa INT NOT NULL,
  tipoDeVenda CHAR(1) NOT NULL,
  possuiOrcamento TINYINT NOT NULL,
  PRIMARY KEY (Pedido_id),
  INDEX fk_PedidoVenda_Vendedor1_idx (Vendedor_PessoaFisica_Pessoa_idPessoa ASC),
  INDEX fk_PedidoVenda_Pedido1_idx (Pedido_id ASC),
  CONSTRAINT fk_PedidoVenda_Vendedor1
    FOREIGN KEY (Vendedor_PessoaFisica_Pessoa_idPessoa)
    REFERENCES Vendedor (PessoaFisica_Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PedidoVenda_Pedido1
    FOREIGN KEY (Pedido_id)
    REFERENCES Pedido (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Produto (
  codProd INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(300) NULL,
  precoVenda FLOAT NOT NULL,
  qtdeEstoque INT NOT NULL,
  marca VARCHAR(45) NULL,
  nome VARCHAR(45) NOT NULL,
  material VARCHAR(45) NULL,
  cor VARCHAR(45) NOT NULL,
  PRIMARY KEY (codProd)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PedidoCompra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PedidoCompra (
  Pedido_id INT NOT NULL,
  INDEX fk_PedidoCompra_Pedido1_idx (Pedido_id ASC),
  PRIMARY KEY (Pedido_id),
  CONSTRAINT fk_PedidoCompra_Pedido1
    FOREIGN KEY (Pedido_id)
    REFERENCES Pedido (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table OrcCompra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrcCompra (
  dataCotacao DATE NOT NULL,
  PessoaJuridica_Pessoa_idPessoa INT NOT NULL,
  precoCotado FLOAT NOT NULL,
  dataValidade DATE NOT NULL,
  prazoEntregaDias INT NOT NULL,
  PedidoCompra_Pedido_id INT NULL,
  PRIMARY KEY (dataCotacao, PessoaJuridica_Pessoa_idPessoa),
  INDEX fk_EhCotado_PessoaJuridica1_idx (PessoaJuridica_Pessoa_idPessoa ASC),
  INDEX fk_OrcCompra_PedidoCompra1_idx (PedidoCompra_Pedido_id ASC),
  CONSTRAINT fk_EhCotado_PessoaJuridica1
    FOREIGN KEY (PessoaJuridica_Pessoa_idPessoa)
    REFERENCES PessoaJuridica (Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OrcCompra_PedidoCompra1
    FOREIGN KEY (PedidoCompra_Pedido_id)
    REFERENCES PedidoCompra (Pedido_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Leads
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Lead` (
  PessoaFisica_Pessoa_idPessoa INT NOT NULL,
  plataformaOrigem INT NULL,
  idAnuncio INT NOT NULL UNIQUE,
  dataCadastro DATE NOT NULL,
  PRIMARY KEY (PessoaFisica_Pessoa_idPessoa),
  CONSTRAINT fk_Vendedor_PessoaFisica10
    FOREIGN KEY (PessoaFisica_Pessoa_idPessoa)
    REFERENCES PessoaFisica (Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CompoeOrcCompra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CompoeOrcCompra (
  OrcCompra_dataCotacao DATE NOT NULL,
  OrcCompra_PessoaJuridica_Pessoa_idPessoa INT NOT NULL,
  Produto_codProd INT NOT NULL,
  quantidade INT NOT NULL,
  preco FLOAT NOT NULL,
  PRIMARY KEY (OrcCompra_dataCotacao, OrcCompra_PessoaJuridica_Pessoa_idPessoa, Produto_codProd),
  INDEX fk_OrcCompra_has_Produto_Produto1_idx (Produto_codProd ASC),
  INDEX fk_OrcCompra_has_Produto_OrcCompra1_idx (OrcCompra_dataCotacao ASC, OrcCompra_PessoaJuridica_Pessoa_idPessoa ASC),
  CONSTRAINT fk_OrcCompra_has_Produto_OrcCompra1
    FOREIGN KEY (OrcCompra_dataCotacao , OrcCompra_PessoaJuridica_Pessoa_idPessoa)
    REFERENCES OrcCompra (dataCotacao , PessoaJuridica_Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OrcCompra_has_Produto_Produto1
    FOREIGN KEY (Produto_codProd)
    REFERENCES Produto (codProd)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table OrcVenda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrcVenda (
  dataCotacao DATE NOT NULL,
  Pessoa_idPessoa INT NOT NULL,
  dataValidade DATE NOT NULL,
  prazoEntrega DATE NOT NULL,
  precoCotado FLOAT NOT NULL,
  PRIMARY KEY (dataCotacao, Pessoa_idPessoa),
  INDEX fk_OrcVenda_Pessoa1_idx (Pessoa_idPessoa ASC),
  CONSTRAINT fk_OrcVenda_Pessoa1
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CompoeVendaSemOrc
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CompoeVendaSemOrc (
  PedidoVenda_Pedido_id INT NOT NULL,
  Produto_codProd INT NOT NULL,
  quantidade INT NOT NULL,
  preco FLOAT NOT NULL,
  PRIMARY KEY (PedidoVenda_Pedido_id, Produto_codProd),
  INDEX fk_PedidoVendaSemOrc_has_Produto_Produto1_idx (Produto_codProd ASC),
  INDEX fk_CompoeVendaSemOrc_PedidoVenda1_idx (PedidoVenda_Pedido_id ASC),
  CONSTRAINT fk_PedidoVendaSemOrc_has_Produto_Produto1
    FOREIGN KEY (Produto_codProd)
    REFERENCES Produto (codProd)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CompoeVendaSemOrc_PedidoVenda1
    FOREIGN KEY (PedidoVenda_Pedido_id)
    REFERENCES PedidoVenda (Pedido_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CompoeOrcVenda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CompoeOrcVenda (
  Produto_codProd INT NOT NULL,
  OrcVenda_dataCotacao DATE NOT NULL,
  OrcVenda_Pessoa_idPessoa INT NOT NULL,
  quantidade INT NOT NULL,
  preco FLOAT NOT NULL,
  PRIMARY KEY (Produto_codProd, OrcVenda_dataCotacao, OrcVenda_Pessoa_idPessoa),
  INDEX fk_OrcVenda_has_Produto_Produto1_idx (Produto_codProd ASC),
  INDEX fk_CompoeVendaComOrc_OrcVenda1_idx (OrcVenda_dataCotacao ASC, OrcVenda_Pessoa_idPessoa ASC),
  CONSTRAINT fk_OrcVenda_has_Produto_Produto1
    FOREIGN KEY (Produto_codProd)
    REFERENCES Produto (codProd)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CompoeVendaComOrc_OrcVenda1
    FOREIGN KEY (OrcVenda_dataCotacao , OrcVenda_Pessoa_idPessoa)
    REFERENCES OrcVenda (dataCotacao , Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PessoaEndereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PessoaEndereco (
  idEndereco INT NOT NULL AUTO_INCREMENT,
  Pessoa_idPessoa INT NOT NULL,
  numero INT NOT NULL,
  logadouro VARCHAR(30) NOT NULL,
  complemento VARCHAR(30) NULL,
  bairro VARCHAR(20) NOT NULL,
  cidade VARCHAR(20) NOT NULL,
  cep VARCHAR(8) NOT NULL,
  estado VARCHAR(2) NOT NULL,
  PRIMARY KEY (idEndereco, Pessoa_idPessoa),
  CONSTRAINT fk_PessoaEndereco_Pessoa
    FOREIGN KEY (Pessoa_idPessoa)
    REFERENCES Pessoa (idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PedidoVendaOrc
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PedidoVendaOrc (
  PedidoVenda_Pedido_id INT NOT NULL,
  OrcVenda_dataCotacao DATE NOT NULL,
  OrcVenda_Pessoa_idPessoa INT NOT NULL,
  PRIMARY KEY (PedidoVenda_Pedido_id, OrcVenda_dataCotacao, OrcVenda_Pessoa_idPessoa),
  INDEX fk_PedidoVenda_has_OrcVenda_OrcVenda1_idx (OrcVenda_dataCotacao ASC, OrcVenda_Pessoa_idPessoa ASC),
  INDEX fk_PedidoVenda_has_OrcVenda_PedidoVenda1_idx (PedidoVenda_Pedido_id ASC),
  CONSTRAINT fk_PedidoVenda_has_OrcVenda_PedidoVenda1
    FOREIGN KEY (PedidoVenda_Pedido_id)
    REFERENCES PedidoVenda (Pedido_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PedidoVenda_has_OrcVenda_OrcVenda1
    FOREIGN KEY (OrcVenda_dataCotacao , OrcVenda_Pessoa_idPessoa)
    REFERENCES OrcVenda (dataCotacao , Pessoa_idPessoa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE USER 'estudante'@'localhost' IDENTIFIED BY 'estudante1';
GRANT ALL PRIVILEGES ON BD_Trabalho.* TO 'estudante'@'localhost';
FLUSH PRIVILEGES;

-- DROP USER 'estudante'@'localhost';
-- FLUSH PRIVILEGES;
