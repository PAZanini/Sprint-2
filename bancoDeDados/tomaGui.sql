CREATE DATABASE WaterWorks;
USE WaterWorks;

SELECT * FROM plantacao;
SELECT * FROM registro;
SELECT * FROM sensor;


    SELECT p.nome as Plantação, dadoSensor as dadoSensor, dataRegistro AS dtRegistro FROM plantacao as p JOIN sensor on fkPlantacao = idPLANTACAO 
	JOIN registro as dados on fkSensor = idSensor 
    WHERE idPLANTACAO = 1 and date(dataRegistro) = curdate() order by dataRegistro DESC limit 5;
    
    SELECT p.nome as Plantação, dadoSensor as dadoSensor, dataRegistro AS dtRegistro FROM plantacao as p JOIN sensor on fkPlantacao = idPLANTACAO JOIN registro as dados on fkSensor = idSensor WHERE idPLANTACAO = 1
    order by dataRegistro DESC limit 5;
    
    
    SELECT Mes, AVG(dadoSensor) AS media_valor
    FROM vw_mes where year(dataRegistro) = year(curdate())
    GROUP BY Mes 
    ORDER BY FIELD(Mes, 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro') and idPLANTACAO = 1;

SELECT * FROM plantacao WHERE fkMatriz = 1;

truncate table registro;

SELECT * FROM empresa;

SELECT * FROM usuario;


INSERT INTO registro VALUES
(DEFAULT, 10.49, DEFAULT, 2),
(DEFAULT, 80.10, DEFAULT, 2);

CREATE TABLE endereco (
idEndereco INT primary key auto_increment,
cep char (8) not null,
rua varchar(45) not null,
cidade varchar(45) not null,
numero varchar(10),
uf char(2) not null
);

INSERT INTO endereco values
(default, '12345678', 'Rua das maravilhas do café', 'Salinas', '55', 'MG' );

INSERT into empresa VALUES 
(DEFAULT, 11111111111111, 'Café Brasil', '123456789', null, 1);

SELECT * FROM empresa;

INSERT into plantacao VALUES
(1, 'Plantação vila feliz', 1),
(2, 'Café Maduro', 1);

INSERT into sensor VALUES
(1, 'Sensor 1', 1),
(2, 'Sensor 2', 2);

INSERT into registro values
(1, '60', '2024-01-01 13:00:00', 1),
(2, '70', '2024-02-01 13:00:00', 1),
(3, '55', '2024-03-01 13:00:00', 1),
(4, '67', '2024-04-01 13:00:00', 1),
(5, '30', '2024-05-01 13:00:00', 1),
(6, '80', '2024-06-01 13:00:00', 1),
(7, '70', '2024-07-01 13:00:00', 1),
(8, '65', '2024-08-01 13:00:00', 1),
(9, '71', '2024-09-01 13:00:00', 1),
(10, '75', '2024-10-01 13:00:00', 1),
(11, '63', '2024-11-01 13:00:00', 1),
(12, '74', '2024-12-01 13:00:00', 1);

INSERT into registro values
(13, '78', '2024-01-01 13:00:00', 2),
(14, '61', '2024-02-01 13:00:00', 2),
(15, '43', '2024-03-01 13:00:00', 2),
(16, '70', '2024-04-01 13:00:00', 2),
(17, '80', '2024-05-01 13:00:00', 2),
(18, '63', '2024-06-01 13:00:00', 2),
(19, '67', '2024-07-01 13:00:00', 2),
(20, '70', '2024-08-01 13:00:00', 2),
(21, '61', '2024-09-01 13:00:00', 2),
(22, '66', '2024-10-01 13:00:00', 2),
(23, '75', '2024-11-01 13:00:00', 2),
(24, '74', '2024-12-01 13:00:00', 2);

INSERT into registro VALUES
(26, '65', '2024-12-01 13:00:00', 2);


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
   

SELECT * FROM registro;
CREATE TABLE Alerta (
    idALERTA INT AUTO_INCREMENT,
    descricao VARCHAR(45),
    dhora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkEmpresa INT,
    constraint pkComposta primary key (idALERTA, fkEmpresa),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

   
   CREATE VIEW vw_mes AS
SELECT 
    dataRegistro, 
    dadoSensor,
    idPLANTACAO,
    MONTH(dataRegistro) AS mes_num,
    CASE 
        WHEN MONTH(dataRegistro) = 1 THEN 'Janeiro'
        WHEN MONTH(dataRegistro) = 2 THEN 'Fevereiro'
        WHEN MONTH(dataRegistro) = 3 THEN 'Março'
        WHEN MONTH(dataRegistro) = 4 THEN 'Abril'
        WHEN MONTH(dataRegistro) = 5 THEN 'Maio'
        WHEN MONTH(dataRegistro) = 6 THEN 'Junho'
        WHEN MONTH(dataRegistro) = 7 THEN 'Julho'
        WHEN MONTH(dataRegistro) = 8 THEN 'Agosto'
        WHEN MONTH(dataRegistro) = 9 THEN 'Setembro'
        WHEN MONTH(dataRegistro) = 10 THEN 'Outubro'
        WHEN MONTH(dataRegistro) = 11 THEN 'Novembro'
        WHEN MONTH(dataRegistro) = 12 THEN 'Dezembro'
        ELSE 'Desconhecido'
    END AS Mes
FROM 
    registro 
    JOIN sensor ON fkSensor = idSensor 
    JOIN plantacao ON fkPlantacao = idPLANTACAO;
    
    SELECT Mes, AVG(dadoSensor) AS media_valo FROM vw_mes WHERE YEAR(dataRegistro) = YEAR(CURDATE()) AND idPLANTACAO = 2
GROUP BY Mes, mes_num ORDER BY mes_num; 
   

            





