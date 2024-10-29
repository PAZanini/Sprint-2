CREATE DATABASE WaterWorks;
USE WaterWorks;

DROP DATABASE WaterWorks;

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
fkMatriz INT,
fkEndereco INT,
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
FOREIGN KEY (fkMatriz) REFERENCES empresa(idEmpresa)
);

CREATE TABLE login (
    idLOGIN INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL
);

CREATE TABLE usuario (
    idUSER INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(50) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telCelular CHAR(11),
    cargo VARCHAR(45),
    fkSupervisor INT,
    fkLogin INT,
    fkEmpresa INT,
    fkEndereco INT,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
    FOREIGN KEY (fkSupervisor) REFERENCES usuario(idUSER),
    FOREIGN KEY (fkLogin) REFERENCES login(idLOGIN),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE plantacao (
    idPLANTACAO INT PRIMARY KEY AUTO_INCREMENT,
    qtdSensor INT,
    nome VARCHAR(45),
    area INT,
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
    fkUsuario INT,
    fkRegistro INT,
    constraint pkComposta primary key (idALERTA, fkUsuario, fkRegistro),
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUSER),
    FOREIGN KEY (fkRegistro) REFERENCES registro(idRegistro)
);

INSERT INTO endereco (cep, rua, cidade, numero, uf) VALUES 
('12345678', 'Rua A', 'Cidade A', '100', 'SP'),
('87654321', 'Rua B', 'Cidade B', '200', 'MG');


INSERT INTO empresa (cnpj, nome, fkEndereco) VALUES 
('12345678000100', 'Empresa Matriz', 1),
('98765432000100', 'Empresa Filial', 2);


INSERT INTO login (email, senha) VALUES 
('fernando@sptech.com', '@Urubu100'),
('clara@sptech.com', '@Urubu101');


INSERT INTO usuario (nomeCompleto, cpf, telCelular, cargo, fkLogin, fkEmpresa, fkEndereco) VALUES 
('Fernando Brandão', '11111111111', '11999999999', 'Gerente', 1, 1, 1),
('Clara', '22222222222', '11888888888', 'Técnico', 2, 2, 2);


UPDATE usuario set fkSupervisor = 1 WHERE idUSER = 2;

INSERT INTO plantacao (qtdSensor, nome, area, fkMatriz) VALUES 
(10, 'Plantação Norte', 500, 1),
(15, 'Plantação Sul', 700, 2);


INSERT INTO sensor (nome, fkPlantacao) VALUES 
('Sensor Umidade 1', 1),
('Sensor Umidade 2', 2);


INSERT INTO registro (dadoSensor, dataRegistro, fkSensor) VALUES 
(35.5, '2024-10-01 08:00:00', 1),
(28.7, '2024-10-02 09:30:00', 2);


INSERT INTO alerta (gravidade, dhora, protocolo, fkUsuario, fkRegistro) VALUES 
('Alta', '2024-10-01 08:10:00', 'ALERTA001', 1, 1),
('Média', '2024-10-02 09:40:00', 'ALERTA002', 2, 2);

--  Selecionar todos os dados de registro, alerta e o responsável pelo alerta

SELECT 
    a.idALERTA,
    a.gravidade,
    a.dhora,
    a.protocolo,
    u.nomeCompleto AS responsavel,
    r.dadoSensor,
    r.dataRegistro
FROM 
    alerta AS a
JOIN 
    usuario AS u ON a.fkUsuario = u.idUSER
JOIN 
    registro AS r ON a.fkRegistro = r.idRegistro;

-- Selecionar todos os dados combinados (dados de alertas, registros, sensores, plantações, empresas e usuários)

SELECT 
    a.idALERTA,
    a.gravidade,
    a.dhora,
    a.protocolo,
    u.nomeCompleto AS usuario_responsavel,
    u.cargo AS cargo_usuario,
    e.nome AS empresa,
    s.nome AS sensor,
    r.dadoSensor,
    r.dataRegistro,
    p.nome AS plantacao,
    p.area AS area_plantacao
FROM 
    alerta AS a
JOIN 
    usuario AS u ON a.fkUsuario = u.idUSER
JOIN 
    empresa AS e ON u.fkEmpresa = e.idEmpresa
JOIN 
    registro AS r ON a.fkRegistro = r.idRegistro
JOIN 
    sensor AS s ON r.fkSensor = s.idSensor
JOIN 
    plantacao AS p ON s.fkPlantacao = p.idPLANTACAO;







