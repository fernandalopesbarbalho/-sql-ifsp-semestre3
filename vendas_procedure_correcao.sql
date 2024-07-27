--Procedures que realizem as seguintes operações: Insert, update e delete de produtos; Insert, update e delete de funcionários. Código de correção do professor:

--INSERT produtos
alter PROCEDURE sp_inserir_produtos
	@descricao varchar(50), @quantidade int, @valor decimal(7,2), @status int
AS
BEGIN
	INSERT INTO produtos VALUES (@descricao, @quantidade, @valor, @status)
	select @@IDENTITY --ultimo id inserido
END;

-- DELETE produtos
create procedure sp_deletar_produtos
	@id int
as
begin
	delete from produtos where prd_codigo = @id
end;

-- UPDATE produtos
create procedure sp_atualizar_produtos
	@id int,@descricao varchar(50), @quantidade int, @valor decimal(7,2), @status int
as
begin
	update produtos 
	set prd_descricao = @descricao, prd_qtd = @quantidade, prd_valor = @valor, prd_status =  @status
	where prd_codigo = @id
end;


alter PROCEDURE inserir_funcionario
	@nome varchar(50),@cpf varchar(12), @status int, @salario decimal(7,2), @sup_cod int
AS
BEGIN
	--declaracao de variavel
	DECLARE @id_pessoa int;

	INSERT INTO pessoas VALUES (@nome, @cpf, @status)
	set @id_pessoa = @@IDENTITY
	insert Into funcionarios values (@id_pessoa, @salario,@sup_cod)
END;


-- delete produtos
alter procedure sp_deletar_funcionario
	@id int
as
begin
	delete from funcionarios where pes_codigo = @id
	delete from pessoas where pes_codigo = @id
end;

--atualizar funcionario
alter procedure sp_atualizar_funcionario
	@nome varchar(50), @cpf varchar(12), @status int, @salario decimal(7,2), @sup_cod int,@id int
as
begin
	update pessoas 
	set pes_nome = @nome, pes_cpf = @cpf, pes_status = @status
	where pes_codigo = @id

	update funcionarios 
	set fun_salario = @salario, sup_codigo = @sup_cod
	where pes_codigo = @id
end;

------ testes ------------------- testes -------------------- testes ----------------------

--EXEC inserir_produtos @descricao = 'batata', @quantidade  = 10, @valor = 1, @status = 1 

Select * from funcionarios
Select * from pessoas
select * from produtos

EXEC sp_inserir_produtos @descricao = 'refrigerante', @quantidade = 5, @valor = 5, @status = 1 

EXEC sp_deletar_produtos @id = 8

EXEC sp_atualizar_produtos @id = 9, @descricao = 'REFRIGERANTE', @quantidade = 20, @status = 1, @valor = 5

EXEC inserir_funcionario @nome = 'Homem Sereio', @cpf = '5555', @status = 1, @salario = 5000, @sup_cod = null

EXEC sp_atualizar_funcionario @nome	= 'H Sereio', @id=15, @salario = 2000, @cpf = 5555,@status = 1, @sup_cod = null

EXEC sp_deletar_funcionario @id = 15
