CREATE DATABASE WaterWorks;
USE WaterWorks;

-- Tabela USER
CREATE TABLE USUARIO (
    idUSER INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(50),
    cpf CHAR(11),
    cnpj CHAR(14),
    telCelular CHAR(11),
    cargo VARCHAR(45),
    cep CHAR(8),
    rua VARCHAR(100),
    cidade VARCHAR(50),
    numero VARCHAR(10),
    uf CHAR(2),
    fkLogin INT,
    fkSupervisor INT,
    CONSTRAINT fk_login FOREIGN KEY (fkLogin) REFERENCES LOGIN(idLOGIN),
    CONSTRAINT fk_supervisor FOREIGN KEY (fkSupervisor) REFERENCES USUARIO(idUSER)
);

-- Tabela LOGIN
CREATE TABLE LOGIN (
    idLOGIN INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45)
);

-- Tabela PLANTACAO
CREATE TABLE PLANTACAO (
    idPLANTACAO INT PRIMARY KEY AUTO_INCREMENT,
    numSensor int,
    umidade FLOAT,
    nome VARCHAR(45)
);

-- Tabela PLATACOES_USUARIOS (Tabela de relacionamento entre USER e PLANTACAO)
CREATE TABLE PLATACOES_USUARIOS (
    fkUser INT,
    fkPlantacao INT,
    PRIMARY KEY (fkUser, fkPlantacao),
    CONSTRAINT fk_user FOREIGN KEY (fkUser) REFERENCES USUARIO(idUSER),
    CONSTRAINT fk_plantacao FOREIGN KEY (fkPlantacao) REFERENCES PLANTACAO(idPLANTACAO)
);

-- Tabela ALERTA
CREATE TABLE ALERTA (
    idALERTA INT PRIMARY KEY AUTO_INCREMENT,
    gravidade VARCHAR(45),
    responsavel VARCHAR(45),
    descricao VARCHAR(256),
    protocolo VARCHAR(256),
    fkSensor INT,
    CONSTRAINT fk_sensor FOREIGN KEY (fkSensor) REFERENCES PLANTACAO(idPLANTACAO)
);

-- Inserindo dados na tabela LOGIN
INSERT INTO LOGIN (usuario, email, senha) VALUES
('BrandãoSp', 'usuario1@sptech.com', 'Urubu100@'),
('ClaraSp', 'usuario2@sptech.com', 'Urubu101@');

-- Inserindo dados na tabela USER
INSERT INTO USER (nomeCompleto, cpf, cnpj, telCelular, cargo, cep, rua, cidade, numero, uf, fkLogin, fkSupervisor) VALUES
('Clara', '10987654321', '98765432000123', '11988888888', 'Agricultora', '87654321', 'Rua B', 'Cidade B', '20', 'SP', 2, 1),
('Fernando Brandão', '12345678901', '12345678000123', '11999999999', 'Agricultor', '12345678', 'Rua Haddock Lobo', 'São Paulo', '595', 'SP', 1, NULL);

-- Inserindo dados na tabela PLANTACAO
INSERT INTO PLANTACAO (numSensor, umidade, nome) VALUES
(5, 40.5, 'Plantação 1'),
(8, 35.2, 'Plantação 2');

-- Inserindo dados na tabela PLATACOES_USUARIOS (relacionamento)
INSERT INTO PLATACOES_USUARIOS (fkUser, fkPlantacao) VALUES
(1, 1),
(2, 1);

-- Inserindo dados na tabela ALERTA
INSERT INTO ALERTA (gravidade, responsavel, descricao, protocolo, fkSensor) VALUES
('Alta', 'Fernando Brandão', 'Alerta de umidade baixa', 'PRT123', 1),
('Média', 'Clara', 'Alerta de sensor desconectado', 'PRT456', 2);


-- SELECT que traz todos os usuários de uma determinada plantação
SELECT 
    u.nomeCompleto AS usuario, 
    p.nome AS plantacao
FROM 
    USUARIO as u
JOIN 
    PLATACOES_USUARIOS as pu ON u.idUSER = pu.fkUser
JOIN 
    PLANTACAO as p ON pu.fkPlantacao = p.idPLANTACAO
WHERE 
    p.idPLANTACAO = 1; -- Substitua o valor pelo ID da plantação desejada
    
-- SELECT para mostrar o alerta e o usuário responsável

SELECT 
    a.gravidade, 
    a.descricao, 
    a.responsavel, 
    p.nome AS plantacao
FROM 
    ALERTA as a
JOIN 
    PLANTACAO as p ON a.fkSensor = p.idPLANTACAO;

-- SELECT que mostra todas as informações (usuário, plantação, alerta)    

SELECT 
    u.nomeCompleto AS usuario, 
    p.nome AS plantacao, 
    a.gravidade AS alerta_gravidade, 
    a.descricao AS alerta_descricao
FROM 
    USUARIO as u
JOIN 
    PLATACOES_USUARIOS as pu ON u.idUSER = pu.fkUser
JOIN 
    PLANTACAO as p ON pu.fkPlantacao = p.idPLANTACAO
JOIN 
    ALERTA as a ON a.fkSensor = p.idPLANTACAO;

