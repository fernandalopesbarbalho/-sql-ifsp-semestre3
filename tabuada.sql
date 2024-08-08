/* Escreva uma procedure que:

1.	Receba um parâmetro de número entre 1 e 10
	a.	Caso não seja um número desses, lançar exceção com a mensagem “número escolhido fora do range aceito”

2.	Fazer a tabuada desse número usando comando print.
	a.	Usar While para isso.
	b.	Exemplo para número 1:
		i. 1 X 0 = 0
		ii. 1 X 1 = 1
		iii. 1 X 2 = 2

3.	Use try catch nesse código. 
	a.	Caso exista algum erro, usar Print para mostrar a mensagem */

create database tabuada

use tabuada

create procedure gerar_tabuada
	@numero int
as
begin
    begin try
        -- Verifica se o número está entre 1 e 10
        if @numero < 1 or @numero > 10
        begin
            -- Mensagem de exceção caso o número não esteja entre 1 e 10
            throw 50000, 'número escolhido fora do range aceito', 1 
			-- Gera uma exceção e transfere a execução para o catch
        end

        declare @i int = 0  -- Contador i inicializado em 0

        -- Enquanto o contador não for igual a 10, a tabuada será impressa
        while @i <= 10
        begin
            -- Imprimindo a multiplicação
            print cast(@numero as varchar) + ' x ' + cast(@i as varchar) + ' = ' + cast(@numero * @i as varchar)
            set @i = @i + 1;  -- Atualizar contador
        end
    end try

    begin catch -- Catch caso ocorra erro
        print 'um erro ocorreu: ' + error_message() -- Imprimindo a mensagem de erro
    end catch
end
go

exec gerar_tabuada 7

exec gerar_tabuada 0 -- Mensagem de erro

exec gerar_tabuada 10

exec gerar_tabuada 1

exec gerar_tabuada 12 -- Mensagem de erro