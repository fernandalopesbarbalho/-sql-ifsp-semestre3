create database consultorio;
use consultorio;

create table pessoas(
	id int not null primary key identity,
	data_nascimento date not null,
	genero varchar(20) not null,
	estado_civil varchar(20) not null,
	rg varchar(11) not null
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