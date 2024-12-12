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
    cpf CHAR(11) NOT NULL UNIQUE,
    telCelular CHAR(11),
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


INSERT INTO endereco (cep, rua, cidade, numero, uf) VALUES 
('12345678', 'Rua A', 'Cidade A', '100', 'SP'),
('87654321', 'Rua B', 'Cidade B', '200', 'MG');


INSERT INTO empresa (cnpj, nome, fkEndereco) VALUES 
('12345678000100', 'Empresa Matriz', 1),
('98765432000100', 'Empresa Filial', 2);


INSERT INTO usuario (nomeCompleto, cpf, email, senha, telCelular, cargo, fkEmpresa) VALUES 
('Fernando Brandão', '11111111111', 'brandao@sptech.school','urubu100', '11999999999', 'Gerente', 1),
('Clara', '22222222222', 'clara@sptech.school','urubu100', '11888888888', 'Técnico', 2);


UPDATE usuario set fkSupervisor = 1 WHERE idUSER = 2;

INSERT INTO plantacao (nome, fkMatriz) VALUES 
('Plantação Norte', 1),
('Plantação Sul', 2);


INSERT INTO sensor (nome, fkPlantacao) VALUES 
('Sensor Umidade 1', 1),
('Sensor Umidade 2', 2);


INSERT INTO registro (dadoSensor, dataRegistro, fkSensor) VALUES 
(35.5, '2024-10-01 08:00:00', 1),
(28.7, '2024-10-02 09:30:00', 2);


INSERT INTO alerta (gravidade, dhora, protocolo, fkEmpresa) VALUES 
('Alta', '2024-10-01 08:10:00', 'ALERTA001', 1),
('Média', '2024-10-02 09:40:00', 'ALERTA002', 2);



CREATE VIEW viewalerta as SELECT 
    a.idALERTA,
    a.gravidade,
    a.dhora,
    a.protocolo,
    e.nome AS responsavel
FROM 
    alerta AS a
JOIN 
    empresa AS e ON a.fkEmpresa = e.idEmpresa;

-- Selecionar todos os dados combinados (dados de alertas, registros, sensores, plantações, empresas e usuários)

CREATE VIEW viewgeral as
SELECT 
    e.idEmpresa AS ID_Empresa,
    e.cnpj AS CNPJ_Empresa,
    e.nome AS Nome_Empresa,
    e.codigo AS Codigo_Empresa,
    e.fkMatriz AS FK_Matriz_Empresa,
    en.cep AS CEP_Endereco,
    en.rua AS Rua_Endereco,
    en.cidade AS Cidade_Endereco,
    en.numero AS Numero_Endereco,
    en.uf AS UF_Endereco,
    
    u.idUSER AS ID_Usuario,
    u.nomeCompleto AS Nome_Usuario,
    u.email AS Email_Usuario,
    u.cpf AS CPF_Usuario,
    u.telCelular AS Telefone_Usuario,
    u.cargo AS Cargo_Usuario,
    u.fkSupervisor AS FK_Supervisor_Usuario,
    
    p.idPLANTACAO AS ID_Plantacao,
    p.nome AS Nome_Plantacao,
    p.fkMatriz AS FK_Matriz_Plantacao,

    s.idSensor AS ID_Sensor,
    s.nome AS Nome_Sensor,
    s.fkPlantacao AS FK_Plantacao_Sensor,
    
    r.idRegistro AS ID_Registro,
    r.dadoSensor AS Dado_Sensor,
    r.dataRegistro AS Data_Registro,
    
    a.idALERTA AS ID_Alerta,
    a.gravidade AS Gravidade_Alerta,
    a.dhora AS Data_Hora_Alerta,
    a.protocolo AS Protocolo_Alerta,
    a.fkEmpresa AS FK_Empresa_Alerta
FROM 
    empresa e
JOIN 
    endereco en ON e.fkEndereco = en.idEndereco
LEFT JOIN 
    usuario u ON u.fkEmpresa = e.idEmpresa
LEFT JOIN 
    plantacao p ON p.fkMatriz = e.idEmpresa
LEFT JOIN 
    sensor s ON s.fkPlantacao = p.idPLANTACAO
LEFT JOIN 
    registro r ON r.fkSensor = s.idSensor
LEFT JOIN 
    alerta a ON a.fkEmpresa = e.idEmpresa;

    SELECT * FROM viewalerta;
    SELECT * FROM viewgeral;

