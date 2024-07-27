/*Crie procedures para inserção, atualização e deleção de pedidos.*/

-- Procedure Inserir Pedido
create procedure InserirPedido
    @ped_data datetime,
    @ped_valor decimal(7,2),
    @ped_status int,
    @fun_codigo int,
    @cli_codigo int,
    @est_codigo int,
    @prd_codigo int, 
	@itp_qtd int, 
	@itp_valor decimal(7,2)
as
begin
    declare @ped_numero int

    insert into pedidos (ped_data, ped_valor, ped_status, fun_codigo, cli_codigo, est_codigo)
    values (@ped_data, @ped_valor, @ped_status, @fun_codigo, @cli_codigo, @est_codigo)
    
    set @ped_numero = SCOPE_IDENTITY()

    insert into itens_pedidos (ped_numero, prd_codigo, itp_qtd, itp_valor)
    values (@ped_numero, @prd_codigo, @itp_qtd, @itp_valor)
end

execute InserirPedido '2024-07-17T10:00:00', null, 1, 6, 1, 5, 1, 10, 0.8

select * from pedidos
select * from itens_pedidos

-- Procedure Atualizar Pedido
create procedure AtualizarPedido
    @ped_numero int,
    @ped_data datetime = null,
    @ped_valor decimal(7,2) = null,
    @ped_status int = null,
    @fun_codigo int = null,
    @cli_codigo int = null,
    @est_codigo int = null,
    @prd_codigo int = null,
    @itp_qtd int = null,
    @itp_valor decimal(7,2) = null
as
begin
    update pedidos
    set ped_data = isnull(@ped_data, ped_data),
        ped_valor = isnull(@ped_valor, ped_valor),
        ped_status = isnull(@ped_status, ped_status),
        fun_codigo = isnull(@fun_codigo, fun_codigo),
        cli_codigo = isnull(@cli_codigo, cli_codigo),
        est_codigo = isnull(@est_codigo, est_codigo)
    where ped_numero = @ped_numero

    update itens_pedidos
    set prd_codigo = isnull(@prd_codigo, prd_codigo),
        itp_qtd = isnull(@itp_qtd, itp_qtd),
        itp_valor = isnull(@itp_valor, itp_valor)
    where ped_numero = @ped_numero
end

execute AtualizarPedido
    @ped_numero = 7,
    @ped_data = '2024-07-18T19:00:00',
    @ped_valor = null,
    @ped_status = null, --null quando eu não preciso atualizar o valor
    @fun_codigo = null,
    @cli_codigo = 2,
    @est_codigo = 3,
    @prd_codigo = 4,
    @itp_qtd = 6,
    @itp_valor = 9.99

select * from pedidos
select * from itens_pedidos

-- Procedure Deletar Pedido
create procedure DeletarPedido
    @ped_numero int
as
begin
    delete from itens_pedidos where ped_numero = @ped_numero

    delete from pedidos where ped_numero = @ped_numero
end

execute DeletarPedido @ped_numero = 7

select * from pedidos
select * from itens_pedidos
