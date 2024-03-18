-- CÓDIGO DO PROFESSOR INÍCIO

-- Criando o banco de dados ----------------
create database vendas2
go
use vendas2
go
 
-- Create Tables ----------------------------

-- Tabela Pessoas ------------------------

create table pessoas
(
    pes_codigo int not null identity,
    pes_nome   varchar(50)  not null,
    pes_cpf    varchar(12)  not null unique,
    pes_status int 
             check(pes_status in (1,2,3,4)),
    primary key(pes_codigo)	
)

-- Tabela Clientes -----------------------

create table clientes 
( 
    pes_codigo  int not null primary key,
    cli_renda   decimal(7,2),
    cli_credito decimal(7,2),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
)

-- Tabela Estagiarios --------------------

create table estagiarios
(
    pes_codigo int not null primary key,
    est_bolsa  decimal(7,2) 
               check(est_bolsa >= 0),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
)
 
-- Tabela Funcionarios --------------------

create table funcionarios
(
   pes_codigo  int not null primary key,
   fun_salario decimal(7,2) 
               check(fun_salario > 0),
   sup_codigo int,
   foreign key(pes_codigo) 
           references pessoas(pes_codigo),
   foreign key(sup_codigo) 
           references funcionarios(pes_codigo)
)

-- Tabela Produtos -----------------------

create table produtos
(
   prd_codigo   int not null identity,
   prd_descricao varchar(50) not null,
   prd_qtd      int, 
   prd_valor    decimal(7,2),
   prd_status   int 
               check(prd_status in (1,2,3,4)),
   primary key(prd_codigo)
)

-- Tabela Pedidos ------------------------

create table pedidos
(
   ped_numero int not null identity,
   ped_data   datetime,
   ped_valor  decimal(7,2) 
              check(ped_valor > 0),
   ped_status int  
              check(ped_status in (1,2,3,4)),
   fun_codigo int not null,       
   cli_codigo int not null,
   est_codigo int,
   foreign key(fun_codigo) 
          references funcionarios(pes_codigo),
   foreign key(cli_codigo) 
          references clientes(pes_codigo),
   foreign key(est_codigo) 
           references estagiarios(pes_codigo),
   primary key(ped_numero)
)

-- Tabela Intes_Pedidos --------------------

create table itens_pedidos
(
   ped_numero int not null,
   prd_codigo int not null,
   itp_qtd    int not null,
   itp_valor  decimal(7,2) not null,
   primary key(ped_numero, prd_codigo),
   foreign key(ped_numero) 
           references pedidos(ped_numero),
   foreign key(prd_codigo) 
           references produtos(prd_codigo)
)

--Inserts
insert into produtos values ('Lápis',100,0.8,1)
insert into produtos values ('Apontador',100,2.5,1)
insert into produtos values ('Caneta',100,1.2,1)     
insert into produtos values ('Caderno',100,4.5,1)
insert into produtos values ('Borracha',100,0.85,1)

select * from produtos

-- Inserts Pessoas
insert into pessoas values ('Batman','3030',1)
insert into pessoas values ('SuperMain','1515',1)
insert into pessoas values ('SpiderMan','3131',1)
insert into pessoas values ('Super Foca','2020',1)
insert into pessoas values ('Buslaboo','007',1)
insert into pessoas values ('BuschaGalack','4343',1)
insert into pessoas values ('Super Prof','3636',1)
insert into pessoas values ('Ensina Legal','3333',1)

select * from pessoas

-- Inserts Clientes
insert into clientes values (1,10000,3000)
insert into clientes values (2,15000,5000)

select * from clientes

-- Inserts Estagiários
insert into estagiarios values (3,725)
insert into estagiarios values (5,500)

select * from estagiarios

-- Inserts funcionarios

insert into funcionarios values (4,2500,null)
insert into funcionarios values (6,1000,4)
insert into funcionarios values (7,2500,null)
insert into funcionarios values (8,1050,7)

select * from funcionarios

-- ALTEREI O CÓDIGO INÍCIO

-- Insert Pedidos
insert into pedidos values 
('2009-08-19T10:00:00',null,1,6,1,3)

insert into pedidos values
('2009-08-19T12:00:00',null,1,8,2,5)

insert into pedidos values
('2009-08-19T14:00:00',null,1,6,1,5)

insert into pedidos values 
('2009-08-20T10:00:00',null,1,8,1,3)

insert into pedidos values 
('2009-08-20T12:00:00',null,1,6,2,5)

insert into pedidos values 
('2009-08-20T14:00:00',null,1,8,2,3)

select * from pedidos

-- Insert itens_pedidos
insert into itens_pedidos values (1,1,10,0.8)
insert into itens_pedidos values (1,2,10,2.5)
insert into itens_pedidos values (1,3,10,1.2)
insert into itens_pedidos values (1,4,10,4.5)
insert into itens_pedidos values (1,5,10,0.85)

insert into itens_pedidos values (2,1,5,0.8)
insert into itens_pedidos values (2,2,5,2.5)
insert into itens_pedidos values (2,3,5,1.2)
insert into itens_pedidos values (2,4,5,4.5)

insert into itens_pedidos values (3,2,3,2.5)
insert into itens_pedidos values (3,3,3,1.2)
insert into itens_pedidos values (3,4,3,4.5)

insert into itens_pedidos values (4,3,2,1.2)
insert into itens_pedidos values (4,5,2,0.85)

insert into itens_pedidos values (5,5,1,0.85)

select * from itens_pedidos

-- ALTEREI O CÓDIGO FIM

-- 1. Consultar todas as pessoas
select * from pessoas

-- 2. Consultar os nomes das pessoas em ordem alfabética descendente
select p.pes_nome [nome]
from Pessoas p order by p.pes_nome desc

-- 3. Consultar a quantidade de pessoas cadastradas
select COUNT(*) Qtd from pessoas

-- 4. Consultar a pessoa com o cpf igual a '007'
select * from Pessoas p
where p.pes_cpf = '007'

-- 5. Consultar as primeiras pessoas cadastradas
select top 2 * from pessoas

-- 6. Consultar três pessoas ordenando-as pelo nome em ordem decrescente
select top 3 * from pessoas
order by pes_nome desc

-- 7. Consultar a pessoa que possui o nome 'Batman'
select * from Pessoas p
where p.pes_nome = 'Batman'

-- CÓDIGO DO PROFESSOR FIM

-- MINHA ATIVIDADE 1 CORRIGIDA:

-- 8. Consultar duas pessoas que possuem nome com alguma subpalavra 'super'
select top 2 * from pessoas
where pes_nome like '%super%';

-- 9. Consultar as pessoas com letra b na a inicial do nome
select * from pessoas
where pes_nome like 'b%';

-- 10. Consultar as pessoas que possuem a letra p como sendo a terceira letra do nome
select * from pessoas
where pes_nome like '__p%';

-- 11. Consultar o valor médio dos produtos
select AVG(prd_valor) as valor_medio 
from produtos;

-- 12. Consultar o maior valor de venda de produto
select MAX(prd_valor) as maior_valor
from produtos;

-- 13. Consultar o menor valor de venda de produto
select MIN(prd_valor) as menor_valor
from produtos;

-- 14. Consultar o valor médio de produto, bem como o maior valor, o menor valor e a quantidade de produtos cadastrados
select AVG(prd_valor) as valor_medio,
MAX(prd_valor) as maior_valor,
MIN(prd_valor) as menor_valor,
COUNT(*) as quant_cadastrada 
from produtos;

-- 15. Consultar as pessoas com o código 1 ou 7
select * from pessoas
where pes_codigo = 1 or pes_codigo = 7;

-- 16. Consultar as pessoas com o código 1 e 7
select * from pessoas
where pes_codigo = 1 and pes_codigo = 7;

-- 17. Consultar as pessoas que possuem os códigos 1, 2 e 5
select * from pessoas
where pes_codigo in (1, 2, 5);

-- 18. Consultar as pessoas que possuem código entre 3 e 6
select * from pessoas
where pes_codigo between 3 and 6;

-- 19. Consultar os supervisores
select * from funcionarios
where sup_codigo is null;

-- 20. Consultar somente os funcionários
select * from funcionarios
where sup_codigo is not null;

-- 21. Consultar todos os pedidos do cliente 2
select * from pedidos
where cli_codigo = 2;

-- 22. Consultar todos os pedidos do cliente 2 que foram vendidos pelo funcionário 6
select * from pedidos
where cli_codigo = 2 and fun_codigo = 6;

-- MINHA RESOLUÇÃO DA ATIVIDADE 2:

-- 23. Consultar os pedidos que foram solicitados pelo cliente 2, registrados pelo funcionário 8 e conferidos pelo estagiário 5
select * from pedidos
where cli_codigo = 2 and fun_codigo = 8 and est_codigo = 5;

-- 24. Consultar a quantidade de itens vendidos
select SUM(itp_qtd) as quant_vendida_itens 
from itens_pedidos;

-- 25. Consultar a quantidade de pedidos do cliente 1
select COUNT(*) as quant_pedidos 
from pedidos
where cli_codigo = 1;

-- 26. Consultar a quantidade de itens vendidos relacionada ao pedido 2
select SUM(itp_qtd) as quant_itens_ped2 
from itens_pedidos
where ped_numero = 2;

-- 27. Consultar quantos pedidos foram registrados pelo funcionário 6
select COUNT(*) as quant_ped_func6 
from pedidos
where fun_codigo = 6;

-- 28. Consultar quantas vezes o produto 3 foi vendido
select SUM(itp_qtd) as quant_vendido_prd3 
from itens_pedidos
where prd_codigo = 3;

-- 29. Consultar todas as pessoas
select pes_nome from pessoas;

-- 30. Consultar todos os dados dos clientes
select * from clientes;

-- 31. Consultar nome, CPF, renda e crédito de todos os clientes
select pes_nome, pes_cpf, cli_renda, cli_credito 
from Pessoas p
inner join Clientes c on p.pes_codigo = c.pes_codigo;

-- 32. Consultar os produtos (descrição) e as quantidades vendidas no pedido 1
select prd_descricao, itp_qtd as quant_vendido_ped1
from Produtos p
inner join Itens_pedidos i on p.prd_codigo = i.prd_codigo
where ped_numero = 1;

-- 33. Consultar os produtos (descrição), quantidades vendidas, valores unitários e o valor de cada item do pedido 2
select prd_descricao, itp_qtd, p.prd_valor, (itp_qtd * prd_valor) as valor_item_ped2
from Produtos p
inner join Itens_pedidos i on p.prd_codigo = i.prd_codigo
where ped_numero = 2;

-- 34. Consultar número, data, nome do funcionário, nome do cliente e nome do estagiário de cada pedido
select ped_numero, ped_data, p1.pes_nome as nome_func, p2.pes_nome as nome_cli, p3.pes_nome as nome_est 
from Pedidos p
inner join Funcionarios f on p.fun_codigo = f.pes_codigo
inner join Pessoas p1 on f.pes_codigo = p1.pes_codigo
inner join Clientes c on p.cli_codigo = c.pes_codigo
inner join Pessoas p2 on c.pes_codigo = p2.pes_codigo
inner join Estagiarios e on p.est_codigo = e.pes_codigo
inner join Pessoas p3 on e.pes_codigo = p3.pes_codigo;

-- 35. Consultar código, nome, salário e o nome do supervisor de cada funcionário
select f1.pes_codigo as codigo_func, p1.pes_nome as nome_func, f1.fun_salario as salario_func, p2.pes_nome as nome_supervisor 
from funcionarios f1
inner join Pessoas p1 on f1.pes_codigo = p1.pes_codigo
left join Funcionarios f2 on f1.sup_codigo = f2.pes_codigo
left join Pessoas p2 on f2.pes_codigo = p2.pes_codigo;

-- 36. Consultar o valor de cada item vendido
select itp_valor from itens_pedidos;

-- 37. Consultar o total vendido (faturado) até o momento
select SUM(itp_valor * itp_qtd) as total_faturado 
from itens_pedidos;

-- 38. Consultar o total da folha de pagamento dos supervisores
select SUM(fun_salario) as total_pagto_supervisores 
from funcionarios
where sup_codigo is null;

-- 39. Consultar o valor total do pedido 1
select SUM(itp_qtd * itp_valor) as valor_total_ped1 
from itens_pedidos
where ped_numero = 1;

-- 40. Consultar o total vendido do Produto 4
select SUM(itp_qtd) as quant_vendida_prod4
from itens_pedidos
where prd_codigo = 4;