-- 1) Criar as tabelas baseadas no diagrama do consultório apresentado
create database consultorio;
use consultorio;

create table pessoas(
	id int not null primary key identity,
	data_nascimento date not null,
	genero varchar(20) not null,
	estado_civil varchar(20) not null,
	rg varchar(14) not null
);

create table medicos(
	id_pessoa int not null primary key,
	crm  varchar(10) not null,
	foreign key (id_pessoa) references pessoas(id)
);

create table pacientes(
	id_pessoa int not null primary key,
	convenio varchar(100) not null,
	foreign key (id_pessoa) references pessoas(id)
);

create table consultas(
	id int not null primary key identity,
	data_consulta datetime not null,
	diagnostico varchar(200) not null,
	id_medico int not null,
	id_paciente int not null,
	foreign key (id_medico) references medicos(id_pessoa),
	foreign key (id_paciente) references pacientes(id_pessoa)
);

create table exames(
	id int not null primary key identity,
	id_consulta int not null,
	data_exame datetime not null,
	exame varchar(100) not null,
	foreign key (id_consulta) references consultas(id)
);

create table enderecos(
	id int not null identity,
	id_pessoa int not null,
	logradouro varchar(100) not null,
	numero int not null,
	cep varchar(9) not null,
	bairro varchar(50) not null,
	cidade varchar(50) not null,
	estado varchar(50) not null,
	primary key (id, id_pessoa),
	foreign key (id_pessoa) references pessoas(id)
);

create table telefones(
	id_pessoa int not null,
	ddd int not null,
	telefone varchar(10) not null,
	primary key (id_pessoa, ddd, telefone),
	foreign key (id_pessoa) references pessoas(id)
);

-- 2) Inserir no mínimo 5 linhas para cada tabela
insert into pessoas values('1983-05-23', 'masculino', 'casado', '33.333.333-3');
insert into pessoas values('1987-11-09', 'masculino', 'viuvo', '66.666.666-6');
insert into pessoas values('2000-01-03', 'feminino', 'solteira', '12.345.678-9');
insert into pessoas values('1990-07-21', 'feminino', 'casada', '11.333.555-0');
insert into pessoas values('2005-03-11', 'masculino', 'solteiro', '44.111.777-3');
insert into pessoas values('1982-09-15', 'feminino', 'divorciada', '55.555.555-5');
insert into pessoas values('1975-12-30', 'masculino', 'solteiro', '77.777.777-7');
insert into pessoas values('1995-04-18', 'feminino', 'casada', '88.888.888-8');
insert into pessoas values('1988-10-05', 'masculino', 'viuvo', '99.999.999-9');
insert into pessoas values('1970-03-25', 'feminino', 'casada', '10.101.010-1');

insert into medicos values (1, '165215-sp');
insert into medicos values (2, '678910-rj');
insert into medicos values (3, '123456-pa');
insert into medicos values (4, '456078-mg');
insert into medicos values (5, '978567-es');

insert into pacientes values(6, 'Unimed');
insert into pacientes values(7, 'Amil');
insert into pacientes values(8, 'Bradesco');
insert into pacientes values(9, 'Intermedica');
insert into pacientes values(10, 'Golden Cross');

insert into consultas values('2024-02-11 13:25:00', 'Virose', 1, 6);
insert into consultas values('2024-05-03 15:00:00', 'Gripe', 2, 7);
insert into consultas values('2024-01-06 18:10:00', 'Dor de ouvido', 3, 8);
insert into consultas values('2024-02-01 10:20:00', 'Dengue', 4, 9);
insert into consultas values('2024-03-07 13:00:00', 'Dor muscular', 5, 10);

insert into exames values(1, '2024-02-11 13:40:00', 'Observação dos sintomas');
insert into exames values(2, '2024-05-03 15:05:00', 'Teste de covid negativo');
insert into exames values(3, '2024-01-06 18:45:00', 'Observacao otologica');
insert into exames values(4, '2024-02-01 10:55:00', 'Teste de dengue positivo');
insert into exames values(5, '2024-03-07 13:25:00', 'Observação dos sintomas');

insert into enderecos values(6, 'Rua Antiga', 566, '02645-090', 'Bairro Agua', 'Bahia', 'BA');
insert into enderecos values(7, 'Avenida Principal', 1234, '12345-678', 'Centro', 'Sao Paulo', 'SP');
insert into enderecos values(8, 'Rua das Flores', 987, '54321-098', 'Jardim Botanico', 'Curitiba', 'PR');
insert into enderecos values(9, 'Praça da Liberdade', 456, '45678-321', 'Liberdade', 'Belo Horizonte', 'MG');
insert into enderecos values(10, 'Avenida das Palmeiras', 741, '13579-246', 'Jardim das Palmeiras', 'Fortaleza', 'CE');

insert into telefones values(1, 11, '99999-9999');
insert into telefones values(2, 22, '93456-8901');
insert into telefones values(3, 33, '94567-9012');
insert into telefones values(4, 44, '95678-0123');
insert into telefones values(5, 55, '96789-1234');
insert into telefones values(6, 66, '97890-2345');
insert into telefones values(7, 77, '98901-3456');
insert into telefones values(8, 88, '99012-4567');
insert into telefones values(9, 99, '90123-5678');
insert into telefones values(10, 10, '91234-6789');

-- 3) Escreva e execute um select para exibir todos os dados de cada tabela
select * from pessoas;
select * from medicos;
select * from pacientes;
select * from consultas;
select * from exames;
select * from enderecos;
select * from telefones;

-- 4) Altere a tabela de pessoas para adicionar o campo nome
alter table pessoas add nome varchar(200);

-- 5) Atualize os registros da tabela de pessoas adicionando um nome para cada tupla (para cada pessoa)
update pessoas set nome = 'Jose Silva Oliveira' where id = 1;
update pessoas set nome = 'Pedro Santos' where id = 2;
update pessoas set nome = 'Maria Fernanda Oliveira' where id = 3;
update pessoas set nome = 'Carolina Costa' where id = 4;
update pessoas set nome = 'Lucas Pereira Gomes' where id = 5;
update pessoas set nome = 'Juliana Reis Souza' where id = 6;
update pessoas set nome = 'Rogerio Ferreira' where id = 7;
update pessoas set nome = 'Camila Almeida Lima' where id = 8;
update pessoas set nome = 'Fabricio Rodrigues' where id = 9;
update pessoas set nome = 'Alice Nunes' where id = 10;

-- 6) Escreva um select para visualizar as consultas de um médico (informe o id do médico)
select * from consultas where id_medico = 3;

-- 7) Escreva um select para visualizar os exames de uma consulta (informe o id da consulta)
select * from exames where id_consulta = 1;

-- 8) Escreva um select para visualizar todos os telefones de uma pessoa (informe o id da pessoa)
select * from telefones where id_pessoa = 5;

-- 9)  Desafio 1: crie uma consulta (select) para visualizar todos os dados dos pacientes (devem ser exibidos os dados da tabela de pessoa e paciente ao mesmo tempo)
select pessoas.*, pacientes.* from pessoas inner join pacientes on pessoas.id = pacientes.id_pessoa;

-- 10) Desafio 2: crie uma consulta (select) para visualizar todos os dados dos médicos (devem ser exibidos os dados da tabela de pessoa e medico ao mesmo tempo)
select pessoas.*, medicos.* from pessoas inner join medicos on pessoas.id = medicos.id_pessoa;
