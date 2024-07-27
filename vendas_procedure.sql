-- Realize uma pesquisa e implemente procedures que realizem as seguintes operações: Insert, update e delete de produtos; Insert, update e delete de funcionários.

-- Procedure é um conjunto de instruções SQL que pode ser armazenado no banco de dados e reutilizado posteriormente.
-- A váriavel inicia com @.
-- Para executar uma procedure basta utiilizar a cláusula EXECUTE seguido pelo nome da procedure e na frente o valor a ser utilizado como parâmetro.

-- Procedure Inserir Produto
create procedure InserirProduto
	@prd_descricao varchar(50),
    @prd_qtd int,
    @prd_valor decimal(7,2),
    @prd_status int
as
    insert into produtos (prd_descricao, prd_qtd, prd_valor, prd_status)
    values (@prd_descricao, @prd_qtd, @prd_valor, @prd_status)

execute InserirProduto 'Notebook', 100, 50, 1

select * from produtos

-- Procedure Atualizar Produto
create procedure AtualizarProduto
    @prd_codigo int,
    @prd_descricao varchar(50),
    @prd_qtd int,
    @prd_valor decimal(7,2),
    @prd_status int
as
    update produtos
    set prd_descricao = @prd_descricao,
        prd_qtd = @prd_qtd,
        prd_valor = @prd_valor,
        prd_status = @prd_status
    where prd_codigo = @prd_codigo

execute AtualizarProduto 6, 'Agenda', 100, 4, 1

select * from produtos

-- Procedure Deletar Produto
create procedure DeletarProduto
    @prd_codigo int
as
    delete from produtos
    where prd_codigo = @prd_codigo

execute DeletarProduto 6

select * from produtos

-- Procedure Inserir Funcionário
create procedure InserirFuncionario
    @pes_codigo int,
    @fun_salario decimal(7,2),
    @sup_codigo int
as
    insert into funcionarios (pes_codigo, fun_salario, sup_codigo)
    values (@pes_codigo, @fun_salario, @sup_codigo)

execute InserirFuncionario 3, 1000, 7

select * from funcionarios

-- Procedure Atualizar Funcionário
create procedure AtualizarFuncionario
    @pes_codigo int,
    @fun_salario decimal(7,2),
    @sup_codigo int
as
    update funcionarios
    set fun_salario = @fun_salario,
        sup_codigo = @sup_codigo
    where pes_codigo = @pes_codigo

execute AtualizarFuncionario 3, 1200, 4

select * from funcionarios

-- Procedure Deletar Funcionário
create procedure DeletarFuncionario
    @pes_codigo int
as
    delete from funcionarios
    where pes_codigo = @pes_codigo

execute DeletarFuncionario 3

select * from funcionarios
