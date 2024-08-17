/* 1. Crie uma view com o nome VW_PEDIDOS.
2. Número pedido, data pedido, nome funcionario, nome cliente e nome estagiário.
3. Usar JOINS para criar a view. 
4. Faça um select usando sua view.
5. Faça um select usando sua view de três produtos diferentes (usando ids específicos). */

-- Cria a view
create view vw_pedidos 
as 
select -- Seleciona os dados solicitados
p.ped_numero, 
p.ped_data, 
fun.pes_nome as nome_funcionario, 
cli.pes_nome as nome_cliente, 
est.pes_nome as nome_estagiario

from pedidos p -- Utiliza join para juntar as tabelas
left join funcionarios f on p.fun_codigo = f.pes_codigo
left join clientes c on p.cli_codigo = c.pes_codigo
left join estagiarios e on p.est_codigo = e.pes_codigo
left join pessoas fun on f.pes_codigo = fun.pes_codigo
left join pessoas cli on c.pes_codigo = cli.pes_codigo
left join pessoas est on e.pes_codigo = est.pes_codigo

-- Seleciona todos os pedidos
select * from vw_pedidos

-- Seleciona usando id dos produtos
select distinct vwped.*
from 
vw_pedidos vwped
join itens_pedidos item on vwped.ped_numero = item.ped_numero -- Junta a tabela de itens
where item.prd_codigo in (1, 2, 3) -- Seleciona os pedidos que tem os itens 1, 2 e 3
