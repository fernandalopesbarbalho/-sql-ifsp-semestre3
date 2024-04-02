-- CÓDIGO DO PROFESSOR INÍCIO

-- Criando o banco de dados ----------------
create database vendas4
go
use vendas4
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

-- MINHA ATIVIDADE 2 CORRIGIDA:

-- 23. Consultar os pedidos que foram solicitados pelo cliente 2, registrados pelo funcionário 8 e conferidos pelo estagiário 5
select * from pedidos
where cli_codigo = 2 and fun_codigo = 8 and est_codigo = 5;

-- 24. Consultar a quantidade de itens vendidos
select COUNT(*) as quant_itens
from itens_pedidos;

-- 25. Consultar a quantidade de pedidos do cliente 1
select COUNT(*) as quant_pedidos 
from pedidos
where cli_codigo = 1;

-- 26. Consultar a quantidade de itens vendidos relacionada ao pedido 2
select COUNT(*) as quant_itens
from itens_pedidos
where ped_numero = 2;

-- 27. Consultar quantos pedidos foram registrados pelo funcionário 6
select COUNT(*) as quant_ped_func6 
from pedidos
where fun_codigo = 6;

-- 28. Consultar quantas vezes o produto 3 foi vendido
select COUNT(*) as quant_vendido_prd3 
from itens_pedidos
where prd_codigo = 3;

-- 29. Consultar todas as pessoas
select p.pes_codigo codigo,
p.pes_cpf cpf, 
pes_nome nome
from Pessoas p;

-- 30. Consultar todos os dados dos clientes
select * from Pessoas p, Clientes c
where p.pes_codigo = c.pes_codigo;

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
select f.pes_codigo as codigo_func, fun.pes_nome as nome_func, f.fun_salario as salario_func, sup.pes_nome as nome_supervisor 
from Funcionarios f, Pessoas fun, Pessoas sup
where f.pes_codigo = fun.pes_codigo and
f.sup_codigo = sup.pes_codigo;

-- 36. Consultar o valor de cada item vendido
select i. *, i.itp_qtd * i.itp_valor [valor_item]
from Itens_pedidos i;

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
select SUM(i.itp_qtd * i.itp_valor) as quant_vendida_prod4
from Itens_pedidos i
where i.prd_codigo = 4;

-- MINHA RESOLUÇÃO DA ATIVIDADE 3 (Aguardando a correção):

-- 41. Consultar o valor total de cada pedido
select ped_numero, SUM(itp_qtd * itp_valor) as valor_total
from itens_pedidos
group by ped_numero;

-- 42. Consultar o total vendido do produto 3 em cada pedido
select ped_numero, SUM(itp_qtd) as total_prod3
from itens_pedidos
where prd_codigo = 3
group by ped_numero;

-- 43. Consultar os pedidos com valor total acima de R$ 30,00 reais
select ped_numero, SUM(itp_qtd * itp_valor) as valor_total
from itens_pedidos
group by ped_numero
having SUM(itp_qtd * itp_valor) > 30;

-- 44. Consultar a quantidade de itens por pedido
select ped_numero, COUNT(*) as quant_itens
from itens_pedidos
group by ped_numero;

-- 45. Consultar a quantidade de vezes que cada produto foi vendido
select prd_codigo, SUM(itp_qtd) as quant_vendida
from itens_pedidos
group by prd_codigo;

-- 46. Consultar quantos pedidos cada cliente solicitou
select cli_codigo, COUNT(*) as quant_pedidos
from pedidos
group by cli_codigo;

-- 47. Consultar quantos pedidos cada funcionário registrou
select fun_codigo, COUNT(*) as quant_pedidos
from pedidos
group by fun_codigo;

-- 48. Consultar os pedidos que possuem mais do que 3 itens
select ped_numero, COUNT(*) as quant_itens
from itens_pedidos
group by ped_numero
having COUNT(*) > 3;

-- 49. Consultar o produto mais vendido em quantidade de itens
select top 1 prd_codigo, SUM(itp_qtd) as quant_vendida
from itens_pedidos
group by prd_codigo
order by SUM(itp_qtd) desc;

-- 50. Consultar os pedidos (ped_numero, ped_data) que possuem mais do que 3 itens. Usar exists
select ped_numero, ped_data from Pedidos p
where exists (
    select 1
    from Itens_pedidos i
    where i.ped_numero = p.ped_numero
    group by i.ped_numero
    having COUNT(*) > 3
);

-- 51. Consultar as pessoas que são clientes. Usar exists
select * from Pessoas p
where exists (
    select 1
    from Clientes c
    where c.pes_codigo = p.pes_codigo
);

-- 52. Consultar os clientes que possuem pedidos com valor total acima de R$ 20,00. Usar exists
select p.pes_nome as nome_cliente, ped.ped_numero, SUM(i.itp_qtd * i.itp_valor) as valor_total
from Pessoas p
inner join Clientes c on p.pes_codigo = c.pes_codigo
inner join Pedidos ped on c.pes_codigo = ped.cli_codigo
inner join Itens_pedidos i on ped.ped_numero = i.ped_numero
where exists (
    select 1
    from itens_pedidos i2
    where i2.ped_numero = ped.ped_numero
    group by i2.ped_numero
    having SUM(i2.itp_qtd * i2.itp_valor) > 20
)
group by p.pes_nome, ped.ped_numero;

-- 53. Consultar a data do sistema, e separadamente o ano, mês, dia, hora e minutos
select CURRENT_TIMESTAMP as data_atual,
YEAR(CURRENT_TIMESTAMP) as ano,
MONTH(CURRENT_TIMESTAMP) as mes,
DAY(CURRENT_TIMESTAMP) as dia,
DATEPART(HOUR, CURRENT_TIMESTAMP) as hora,
DATEPART(MINUTE, CURRENT_TIMESTAMP) as minutos;

-- 54. Consultar o valor total do pedido 1
select SUM(itp_qtd * itp_valor) as valor_total_ped1 
from itens_pedidos
where ped_numero = 1;

-- 55. Consultar o total vendido do produto 3
select SUM(i.itp_qtd * i.itp_valor) as quant_vendida_prod3
from Itens_pedidos i
where i.prd_codigo = 3;

-- MINHA RESOLUÇÃO DA ATIVIDADE 4 - JOIN:

-- 1. Selecionar todos os nomes de pessoas envolvidas (estagiário, cliente e funcionário) na compra do produto 3
select ped.ped_numero, p1.pes_nome as estagiario, p2.pes_nome as cliente, p3.pes_nome as funcionario
from Pedidos ped
left join Estagiarios e on ped.est_codigo = e.pes_codigo
left join Clientes c on ped.cli_codigo = c.pes_codigo
left join Funcionarios f on ped.fun_codigo = f.pes_codigo
inner join Pessoas p1 on e.pes_codigo = p1.pes_codigo
inner join Pessoas p2 on c.pes_codigo = p2.pes_codigo
inner join Pessoas p3 on f.pes_codigo = p3.pes_codigo
where ped.ped_numero = 3;

-- 2. Selecionar nome e valor bolsa dos estagiários
select p.pes_nome, e.est_bolsa
from Estagiarios e
inner join Pessoas p on e.pes_codigo = p.pes_codigo;

-- 3. Selecionar nome e renda de todos os clientes
select p.pes_nome, c.cli_renda
from Clientes c
inner join Pessoas p on c.pes_codigo = p.pes_codigo;

-- 4. Selecionar salário e nome de todos os funcionários
select p.pes_nome, f.fun_salario
from Funcionarios f
inner join Pessoas p on f.pes_codigo = p.pes_codigo;

-- 5. Selecione todos os produtos (código, descrição, quantidade) do pedido 1
select p.prd_codigo, p.prd_descricao, i.itp_qtd
from Pedidos ped
inner join Itens_Pedidos i on ped.ped_numero = i.ped_numero
inner join Produtos p on i.prd_codigo = p.prd_codigo
where ped.ped_numero = 1;

-- 6. Selecione o nome dos clientes que compraram o produto 1
select p.pes_nome from Pedidos ped
inner join Itens_pedidos i on ped.ped_numero = i.ped_numero
inner join Produtos pr on i.prd_codigo = pr.prd_codigo
inner join Clientes c on ped.cli_codigo = c.pes_codigo
inner join Pessoas p on c.pes_codigo = p.pes_codigo
where pr.prd_codigo = 1;

-- 7. Construa uma consulta que mostre o código do pedido, a data da compra, o nome do cliente, o nome do funcionário, dos pedidos que foram vendidos mais de 5 itens
select ped.ped_numero, ped.ped_data, p1.pes_nome as cliente, p2.pes_nome as funcionario
from Pedidos ped
inner join Clientes c on ped.cli_codigo = c.pes_codigo
inner join Funcionarios f on ped.fun_codigo = f.pes_codigo
inner join itens_pedidos i on ped.ped_numero = i.ped_numero
inner join Pessoas p1 on c.pes_codigo = p1.pes_codigo
inner join Pessoas p2 on f.pes_codigo = p2.pes_codigo
group by ped.ped_numero, ped.ped_data, p1.pes_nome, p2.pes_nome
having SUM(i.itp_qtd) > 5;

-- 8. Construa uma consulta que mostre o cliente que mais efetuou pedidos
select top 1 p.pes_nome, COUNT(*) as quant_pedidos
from Pedidos ped
inner join Clientes c on ped.cli_codigo = c.pes_codigo
inner join Pessoas p on c.pes_codigo = p.pes_codigo
group by p.pes_nome
order by quant_pedidos desc;

-- 9. Construa uma consulta para exibir o código, o valor, a data (pedido) e o nome do estagiário do pedido com o menor valor efetuado pelo estagiário 3
select top 1 ped.ped_numero, SUM(i.itp_qtd * i.itp_valor) as valor_total, ped.ped_data, p.pes_nome as estagiario
from Pedidos ped
inner join Estagiarios e on ped.est_codigo = e.pes_codigo
inner join Pessoas p on e.pes_codigo = p.pes_codigo
inner join Itens_pedidos i on ped.ped_numero = i.ped_numero
where e.pes_codigo = 3
group by ped.ped_numero, ped.ped_data, p.pes_nome
order by valor_total asc;