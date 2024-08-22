-- Exercício 1:
/* Escreva um procedimento armazenado para registrar os itens vendidos. No modelo de banco utilizado para cada pedido registrado é necessário registrar todos os itens.

O seu procedimento deverá receber os dados de um item pedido (número do pedido, número do produto, quantidade vendida e o valor da venda) e realizar uma consulta para saber se existe esse produto em estoque (campo prd_qtd da tabela de produtos) caso sim registre o item vendido e faça a baixa da quantidade vendida do estoque, ou seja, atualize o campo prd_qtd subtraindo a quantidade vendida para o item. Caso não exista quantidade suficiente no estoque exiba uma mensagem de estoque insuficiente e não registre as operações.

Utilize as técnicas de programação para banco de dados apresentadas nas aulas. A sua solução deve utilizar um try catch. */

-- Procedure para registrar itens
create procedure sp_registrar_pedido
	@ped_numero int, -- Criado as variáveis para receber os dados informados
	@prd_codigo int,
	@itp_qtd int,
	@itp_valor decimal(7,2)
as
begin
    set nocount on
    begin try -- Try para armazenar o código
        begin transaction
		
		insert into itens_pedidos (ped_numero, prd_codigo, itp_qtd, itp_valor) -- Insere os dados informados na tabela de Itens Pedidos
		values (@ped_numero, @prd_codigo, @itp_qtd, @itp_valor)

		if (select prd_qtd from produtos where @prd_codigo = prd_codigo) >= @itp_qtd -- Seleciona a quantidade de itens do estoque e verifica se é sufiente para a compra ocorrer

		update produtos -- Atualiza a quantidade de itens presentes no estoque após a compra
		set prd_qtd -= @itp_qtd 
		where @prd_codigo = prd_codigo

		else -- Caso o estoque não for o suficiente para a compra ocorrer, deleta os dados informados da tabela de Itens Pedidos
		begin
			delete from itens_pedidos where ped_numero = @ped_numero 
            raiserror('estoque insuficiente', 16, 1) -- Informa que o estoque é insuficiente
        end

        commit transaction
    end try

    begin catch -- Captura os erros usando funções
        rollback transaction
        declare @errormessage nvarchar(4000)
        declare @errorseverity int
        declare @errorstate int

        select 
            @errormessage = error_message(),
            @errorseverity = error_severity(),
            @errorstate = error_state()

        raiserror (@errormessage, @errorseverity, @errorstate)
    end catch
end

insert into pedidos values -- Cria o pedido número 7 para inserirmos os itens
('2010-08-20T14:00:00',null,1,8,1,3)

exec sp_registrar_pedido 7, 2, 8, 2.5 -- Insere 8 quantidades do produto 2 no pedido 7

exec sp_registrar_pedido 7, 5, 10000, 2.5 -- Informa a falta de estoque

select * from itens_pedidos -- Verifica se os Itens Pedidos foram registrados

select * from produtos -- Verifica se a quantidade do estoque foi atualizada

-- Exercício 2:
/* Faça uma view para exibir todos os dados de pedido:
·       O número do pedido
·       O nome do cliente
·       O nome do vendedor
·       O nome do estagiário
·       O valor total do pedido
·       O status do pedido – esse campo deverá ser renomeado na view para Situação

Mostre o código para exibir (utilizando a view criada) os pedidos com a situação = 2

Se for necessário atualize os dados do seu banco para testar a consulta */

-- Criando a para exibir todos os dados de pedido
create view vw_pedidos
as
select
	p.ped_numero as numero_pedido, -- Selecionando os dados e renomeando
	cli.pes_nome as nome_cliente,
	fun.pes_nome as nome_vendedor,
	est.pes_nome as nome_estagiario,
	p.ped_valor as valor_pedido,
	p.ped_status as situação -- Status renomeado para "situação"

	from pedidos p -- Utiliza join para juntar as tabelas para a view
		join clientes c on p.cli_codigo = c.pes_codigo
		join funcionarios f on p.fun_codigo = f.pes_codigo
		join estagiarios e on p.est_codigo = e.pes_codigo
		join pessoas cli on c.pes_codigo = cli.pes_codigo
		join pessoas fun on f.pes_codigo = fun.pes_codigo
		join pessoas est on e.pes_codigo = est.pes_codigo

update pedidos -- Atualizando o status dos pedidos para testar a consulta
set ped_status = 2

select * from vw_pedidos -- Verificando todos os dados da view

/* Não consegui solucionar a parte de selecionar apenas a Situação = 2 durante a prova */

select * from vw_pedidos vp -- Tentativa 1
where vp.ped_status = 2

select * from vw_pedidos -- Tentativa 2
join pedidos
where ped_status = 2
		
select distinct vwped.* -- Tentativa 3
from vw_pedidos vwped
join pedidos stts on vwped.ped_numero = stts.ped_numero
where stts.ped_status = 2

/* Solução posterior */
select * from vw_pedidos
where situação = 2
