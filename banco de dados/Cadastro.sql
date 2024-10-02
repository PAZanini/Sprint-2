create database empresa;

use empresa;

create table cadastro (
idCad int primary key auto_increment not null,
nomeCompleto varchar(70) not null,
dtNascimento date not null,
telefone varchar(11) not null,
cpf char(11) not null,
cnpj char(14) not null,
cep char(8) not null,
rua Varchar(45),
cidade varchar(50) not null,
numero varchar(10),
uf char(2) not null,
complemento varchar(40)
);

desc cadastro;

create table login (
idLogin int primary key auto_increment not null,
email varchar(80),
senha varchar(255) not null,
fkCad int,
constraint fkCad foreign key (fkCad)
	references cadastro(idCad)
);

desc login;

insert into cadastro (nomeCompleto, dtNascimento, telefone, cpf, cnpj, cep, rua, cidade, numero, uf, complemento) values
('João Silva', '1985-05-20', '11987654321', '12345678901', '12345678000199', '01001000', 'Rua das Flores', 'São Paulo', '123', 'SP', 'Apt 101'),
('Maria Oliveira', '1990-07-15', '11923456789', '98765432101', '98765432000188', '20020000', 'Av. Central', 'Rio de Janeiro', '456', 'RJ', 'Casa 5'),
('Carlos Souza', '1978-11-10', '11987654322', '12345678902', '12345678000177', '30130000', 'Rua dos Mineiros', 'Belo Horizonte', '789', 'MG', 'Apt 302');


insert into login (email, senha, fkCad) values 
('joao.silva@email.com', 'senhaSegura123', 1),
('maria.oliveira@email.com', 'senhaForte456', 2),
('carlos.souza@email.com', 'senhaTop789', 3);


select * from cadastro;

select * from login join cadastro
	on idCad = fkCad;
    
    


