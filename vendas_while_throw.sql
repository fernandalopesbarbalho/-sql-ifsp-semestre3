/*Crie uma procedure que insira informações de testes para o seu banco de dados. Como ela vai funcionar:
1. A procedure deve ter o nome sp_inserir_massa(@opcao int)
2. Se a opção for 1 : inserir cinco funcionários (usando While)
3. Se a opção for 2 : inserir cinco clientes (Usando while)
	3.1 os dados podem ser iguais entre eles (exemplo: nome de todos sendo "AAAAAA")
4. Caso não seja uma dessas opções: lancar erro! MSG "opção inválida" (mostrar no terminal)
5. Se algo der errado nos inserts, deve dar rollback na operação. 
6. Usar try catch pra manipular os erros. */

create procedure sp_inserir_massa1
    @opcao int
as
begin
    declare @nome varchar(50), @cpf varchar(12), @status int
    declare @contador int = 0
    
    begin try
        begin transaction
        
        if @opcao = 1 -- se a opção for 1, insere 5 funcionários
        begin
            while @contador < 5
            begin
                set @nome = 'funcionario'
                set @cpf = left(cast(newid() as varchar(50)), 4) -- gera um cpf aleatório de 4 dígitos
                set @status = 1

                -- insere na tabela pessoas
                insert into pessoas (pes_nome, pes_cpf, pes_status)
                values (@nome, @cpf, @status)
                
                -- insere na tabela funcionários
                insert into funcionarios (pes_codigo, fun_salario, sup_codigo)
                values (scope_identity(), 1100.00, null)

                set @contador = @contador + 1 -- atualiza contador
            end
        end

        else if @opcao = 2 -- se a opção for 2, insere 5 clientes
        begin
            while @contador < 5
            begin
                set @nome = 'cliente'
                set @cpf = left(cast(newid() as varchar(50)), 4) -- gera um cpf aleatório de 4 dígitos
                set @status = 1

                -- insere na tabela pessoas
                insert into pessoas (pes_nome, pes_cpf, pes_status)
                values (@nome, @cpf, @status)
                
                -- insere na tabela clientes
                insert into clientes (pes_codigo, cli_renda, cli_credito)
                values (scope_identity(), 12000.00, 3000.00)

                set @contador = @contador + 1 -- atualiza contador
            end
        end
        else
        begin
            raiserror('opção inválida', 16, 1) -- se o númer informado não for 1 ou 2, a opção é inválida
        end

        commit transaction
    end try
    begin catch
        rollback transaction
        print 'ocorreu um erro';
        throw
    end catch
end

exec sp_inserir_massa1 @opcao = 3 -- opção inválida

exec sp_inserir_massa1 @opcao = 1
select * from funcionarios

exec sp_inserir_massa1 @opcao = 2
select * from clientes

select * from pessoas
