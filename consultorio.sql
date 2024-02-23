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

create table exame(
	id int not null primary key,
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

USE master;
DROP DATABASE consultorio;

insert into pessoas values('1983-05-23', 'masculino', 'casado', '33.333.333-3');
insert into pessoas values('1987-11-09', 'masculino', 'viuvo', '66.666.666-6');
insert into pessoas values('2000-01-03', 'feminino', 'solteira', '12.345.678-9');
insert into pessoas values('1990-07-21', 'feminino', 'casada', '11.333.555-0');
insert into pessoas values('2005-03-11', 'masculino', 'solteiro', '44.111.777-3');
insert into pessoas values('1982-09-15', 'feminino', 'divorciada', '55.555.555-5');
insert into pessoas values('1975-12-30', 'masculino', 'solteiro', '77.777.777-7');
insert into pessoas values('1995-04-18', 'feminino', 'casada', '88.888.888-8');
insert into pessoas values('1988-10-05', 'masculino', 'viúvo', '99.999.999-9');
insert into pessoas values('1970-03-25', 'feminino', 'casada', '10.101.010-1');

insert into medicos values (1, '165215-sp');
insert into medicos values (2, '678910-rj');
insert into medicos values (3, '123456-pa');
insert into medicos values (4, '456078-mg');
insert into medicos values (5, '978567-es');

insert into pacientes values(6, 'unimed');
insert into pacientes values(7, 'amil');
insert into pacientes values(8, 'bradesco');
insert into pacientes values(9, 'intermedica');
insert into pacientes values(10, 'golden cross');
