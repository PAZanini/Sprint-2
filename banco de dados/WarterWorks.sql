CREATE DATABASE WaterWorks;
USE WaterWorks;
-- Criação da tabela 'login'
CREATE TABLE login (
    idLOGIN INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45)
);

-- Criação da tabela 'empresa'
CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    cnpj CHAR(14)
);

-- Criação da tabela 'usuario'
CREATE TABLE usuario (
    idUSER INT AUTO_INCREMENT PRIMARY KEY,
    nomeCompleto VARCHAR(50),
    cpf CHAR(11),
    telCelular CHAR(11),
    cargo VARCHAR(45),
    cep CHAR(8),
    rua VARCHAR(100),
    cidade VARCHAR(50),
    numero VARCHAR(10),
    uf CHAR(2),
    fkCargo INT,
    fkLogin INT,
    fkEmpresa INT,
    FOREIGN KEY (fkLogin) REFERENCES login(idLOGIN),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Criação da tabela 'sensor'
CREATE TABLE Sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    plantacao_idPLANTACAO INT
);

-- Criação da tabela 'plantacao'
CREATE TABLE plantacao (
    idPLANTACAO INT AUTO_INCREMENT PRIMARY KEY,
    qtdSensor INT,
    nome VARCHAR(45),
    area INT
);

-- Criação da tabela 'plantacoes_empresas'
CREATE TABLE plantacoes_empresas (
    fkPlantacao INT,
    fkEmpresa INT,
    PRIMARY KEY (fkPlantacao, fkEmpresa),
    FOREIGN KEY (fkPlantacao) REFERENCES plantacao(idPLANTACAO),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Criação da tabela 'Registro'
CREATE TABLE Registro (
    idRegistro INT AUTO_INCREMENT PRIMARY KEY,
    dadoSensor FLOAT,
    dataRegistro DATETIME,
    Sensor_idSensor INT,
    FOREIGN KEY (Sensor_idSensor) REFERENCES Sensor(idSensor)
);

-- Criação da tabela 'alerta'
CREATE TABLE alerta (
    idALERTA INT AUTO_INCREMENT PRIMARY KEY,
    gravidade VARCHAR(45),
    responsavel VARCHAR(45),
    descricao VARCHAR(45),
    protocolo VARCHAR(256),
    fRegistro INT,
    FOREIGN KEY (fRegistro) REFERENCES Registro(idRegistro)
);
