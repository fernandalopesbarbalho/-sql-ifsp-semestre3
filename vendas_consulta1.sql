-- MINHA RESOLUÇÃO DA ATIVIDADE 1:

-- 8. Consultar duas pessoas que possuem nome com alguma subpalavra 'super'
select top 2 pes_nome as nome 
from pessoas
where pes_nome like '%super%';

-- 9. Consultar as pessoas com letra b na a inicial do nome
select pes_nome as nome
from pessoas
where pes_nome like 'b%';

-- 10. Consultar as pessoas que possuem a letra p como sendo a terceira letra do nome
select pes_nome as nome
from pessoas
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
select pes_nome as nome
from pessoas
where pes_codigo = 1 or pes_codigo = 7;

-- 16. Consultar as pessoas com o código 1 e 7
select pes_nome as nome
from pessoas
where pes_codigo in (1, 7);

-- 17. Consultar as pessoas que possuem os códigos 1, 2 e 5
select pes_nome as nome
from pessoas
where pes_codigo in (1, 2, 5);

-- 18. Consultar as pessoas que possuem código entre 3 e 6
select pes_nome as nome
from pessoas
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
