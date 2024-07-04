-- MINHA ATIVIDADE 8.1

-- 40. Consultar o total vendido do Produto 4
select SUM(i.itp_qtd * i.itp_valor) as quant_vendida_prod4
from Itens_pedidos i
where i.prd_codigo = 4;

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
