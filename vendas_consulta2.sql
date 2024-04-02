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
