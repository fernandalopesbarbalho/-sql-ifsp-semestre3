/* Escreva uma procedure que:

1.	Receba um par�metro de n�mero entre 1 e 10
	a.	Caso n�o seja um n�mero desses, lan�ar exce��o com a mensagem �n�mero escolhido fora do range aceito�

2.	Fazer a tabuada desse n�mero usando comando print.
	a.	Usar While para isso.
	b.	Exemplo para n�mero 1:
		i. 1 X 0 = 0
		ii. 1 X 1 = 1
		iii. 1 X 2 = 2

3.	Use try catch nesse c�digo. 
	a.	Caso exista algum erro, usar Print para mostrar a mensagem */

create database tabuada

use tabuada

create procedure gerar_tabuada
	@numero int
as
begin
    begin try
        -- Verifica se o n�mero est� entre 1 e 10
        if @numero < 1 or @numero > 10
        begin
            -- Mensagem de exce��o caso o n�mero n�o esteja entre 1 e 10
            throw 50000, 'n�mero escolhido fora do range aceito', 1 
			-- Gera uma exce��o e transfere a execu��o para o catch
        end

        declare @i int = 0  -- Contador i inicializado em 0

        -- Enquanto o contador n�o for igual a 10, a tabuada ser� impressa
        while @i <= 10
        begin
            -- Imprimindo a multiplica��o
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