/* 1) Crie uma procedure para ser possível contratar um estagiário.
- Todo pedido que tem esse estagiário envolvido deve ser mantido por questões de histórico.
- Quando você desliga um estagiário, é necessário mudar o status dele para inativo (1 = ativo, 0 = inativo)
- Contratar um funcionário implica em criar um registro na tabela funcionário.
- Por ser um funcionário novo, é necessário escolher outro funcionário para ser seu supervisor. */

create procedure sp_promocao_estagiario
    @pes_codigo int, -- Código do estagiário
    @operacao int, -- 1 = Desligar, 2 = Contratar
    @salario decimal(7,2) = null, -- Salário, obrigatório para contratação
    @sup_codigo int = null -- Código do supervisor, obrigatório para contratação
as
begin
    set nocount on
    begin try -- Try para armazenar o código
        begin transaction

        if exists (select 1 from estagiarios where pes_codigo = @pes_codigo) -- Verifica se o código da pessoa corresponde a um estagiário
        begin

            if @operacao = 1 -- Desligar estagiário
            begin
                update pessoas
                set pes_status = 0 -- Muda o status para 0 = inativo
                where pes_codigo = @pes_codigo
            end

            else if @operacao = 2 -- Contratar estagiário
            begin
                if @salario is null or @sup_codigo is null -- Verifica se todos os dados necessários estão preenchidos
                begin
                    raiserror('Informar "salário" e "supervisor" é obrigatório para contratar', 16, 1)
                    return
                end

                -- Insere o estagiário como funcionário
                insert into funcionarios (pes_codigo, fun_salario, sup_codigo)
                values (@pes_codigo, @salario, @sup_codigo)
            end

            else
            begin
                raiserror('Operação inválida', 16, 1) -- Informa que há erro no número da operação
                return
            end
        end

        else -- Se não for um estagiário, retorna erro
        begin
            raiserror('Estagiário não encontrado', 16, 1)
            return
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

        raiserror(@errormessage, @errorseverity, @errorstate)
    end catch
end

-- Mudando a tabela pessoas para adicionar o status '0' = inativo
alter table pessoas
drop constraint ck__pessoas__pes_sta__38996ab5

alter table pessoas
add constraint ck__pessoas__pes_sta__38996ab5
check (pes_status in (0, 1, 2, 3, 4, 5))

select * from estagiarios -- Verifica os estagiários atuais

-- Desligar estágiario
exec sp_promocao_estagiario 3, 1

select * from pessoas -- Verifica o status inativo

-- Contratar estágiario
exec sp_promocao_estagiario 5, 2, 1100.00, 7

select * from funcionarios -- Verifica a contratação

exec sp_promocao_estagiario 1, 1 -- Erro por não ser um estagiário

exec sp_promocao_estagiario 5, 2 -- Erro por falta de dados

select * from pedidos -- Verifica os dados dos pedidos

/* 2) Criar uma View com os pedidos existentes que tenham estagiários inativos envolvidos. 
Retorne o número do pedido, nome do cliente e nome do estagiário. */

create view vw_pedidos_est_inativos
as 
select
    p.ped_numero as numero_pedido, -- Selecionando os dados e renomeando
    cli.pes_nome as nome_cliente,
    est.pes_nome as nome_estagiario

from pedidos p -- Utiliza join para juntar as tabelas para a view
	join estagiarios e on p.est_codigo = e.pes_codigo
	join pessoas est on e.pes_codigo = est.pes_codigo
	join clientes c on p.cli_codigo = c.pes_codigo
	join pessoas cli on c.pes_codigo = cli.pes_codigo

where -- Seleciona apenas os pedidos que possuem estagiário inativo
    est.pes_status = 0

select * from vw_pedidos_est_inativos -- Verificando os dados da view

select * from pedidos -- Verficando se corresponde ao resultado da view
