CREATE DATABASE WaterWorks;
USE WaterWorks;


CREATE TABLE endereco (
idEndereco INT primary key auto_increment,
cep char (8) not null,
rua varchar(45) not null,
cidade varchar(45) not null,
numero varchar(10),
uf char(2) not null
);

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(45) NOT NULL,
codigo char(9),
fkMatriz INT,
fkEndereco INT,
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
FOREIGN KEY (fkMatriz) REFERENCES empresa(idEmpresa)
);

CREATE TABLE usuario (
    idUSER INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(50) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    cargo VARCHAR(45),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE plantacao (
    idPLANTACAO INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fkMatriz INT,
    FOREIGN KEY (fkMatriz) REFERENCES empresa(idEmpresa)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fkPlantacao INT,
    FOREIGN KEY (fkPlantacao) REFERENCES plantacao(idPLANTACAO)
);

CREATE TABLE registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    dadoSensor FLOAT NOT NULL,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

CREATE TABLE Alerta (
    idALERTA INT AUTO_INCREMENT,
    gravidade VARCHAR(45),
    dhora DATETIME DEFAULT CURRENT_TIMESTAMP,
    protocolo VARCHAR(256),
    fkEmpresa INT,
    constraint pkComposta primary key (idALERTA, fkEmpresa),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

	select * from usuario;


INSERT INTO empresa  VALUES 
(default, '12345678000100', 'Empresa Matriz', 123456789, NULL, null),
(default, '98765432000100', 'Empresa Filial', 222222222, NULL, null);