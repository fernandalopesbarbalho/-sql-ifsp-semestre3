/* Faça um pesquisa técnica e aprenda como usar transações com try catch.
Crie duas procedures de inserção: uma para clientes e outra para funcionários. 
Lembre-se que um funcionário/cliente também é uma pessoa. */

/* Try/Catch é uma estrutura de controle de fluxo que gerencia erros em scripts de banco de dados.
Try: parte do código onde o script é executado normalmente.
Catch: parte do código onde o erro é tratado. */

-- Procedure Inserir Cliente
create procedure sp_inserir_cliente
    @nome varchar(50),
    @cpf varchar(12),
    @status int,
    @renda decimal(7,2),
    @credito decimal(7,2)
as
begin
    set nocount on
    begin try
        begin transaction
		-- Insere na tabela de pessoas
        insert into pessoas (pes_nome, pes_cpf, pes_status)
        values (@nome, @cpf, @status)

        declare @pes_codigo int
        set @pes_codigo = scope_identity()

		-- Insere na tabela de clientes
        insert into clientes (pes_codigo, cli_renda, cli_credito)
        values (@pes_codigo, @renda, @credito)

        commit transaction
    end try

    begin catch
        rollback transaction
        declare @errormessage nvarchar(4000)
        declare @errorseverity int
        declare @errorstate int

        select -- Captura os erros usando funções
            @errormessage = error_message(),
            @errorseverity = error_severity(),
            @errorstate = error_state()

        raiserror (@errormessage, @errorseverity, @errorstate)
    end catch
end

exec sp_inserir_cliente 'Pokemon', '1234', 1, 11000.00, 4000.00
-- Ao executar a linha acima duas vezes, será informado o erro por conta do CPF duplicado.

exec sp_inserir_cliente 'Whitney Houston', '8922', 9, 19000.00, 8000.00
-- Será informado o erro por conta do status inválido.

select * from pessoas
select * from clientes

-- Procedure Inserir Funcionário
create procedure sp_inserir_funcionario
    @nome varchar(50),
    @cpf varchar(12),
    @status int,
    @salario decimal(7,2),
    @sup_codigo int = null
as
begin
    set nocount on
    begin try
        begin transaction
		-- Insere na tabela de pessoas
        insert into pessoas (pes_nome, pes_cpf, pes_status)
        values (@nome, @cpf, @status)

        declare @pes_codigo int;
        set @pes_codigo = scope_identity()

		-- Insere na tabela de clientes
        insert into funcionarios (pes_codigo, fun_salario, sup_codigo)
        values (@pes_codigo, @salario, @sup_codigo)

        commit transaction
    end try

    begin catch
        rollback transaction;
        declare @errormessage nvarchar(4000)
        declare @errorseverity int
        declare @errorstate int

        select -- Captura os erros usando funções
            @errormessage = error_message(),
            @errorseverity = error_severity(),
            @errorstate = error_state();

        raiserror (@errormessage, @errorseverity, @errorstate)
    end catch
end

exec sp_inserir_funcionario 'Bts Jungkook', '1997', 1, 1500.00, 4

exec sp_inserir_funcionario 'Jiraiya', '190', 1, -1010.00, 7
-- Será informado o erro por conta do salário negativo.

select * from pessoas
select * from funcionarios