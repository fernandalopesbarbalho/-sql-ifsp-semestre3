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
