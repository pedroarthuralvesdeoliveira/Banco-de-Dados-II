/*
	Exercício 1
*/

WITH mediaSalarialCargo AS (
	SELECT 
            ROUND(AVG(Car_Salariobase)) AS MediaSalarial, Car_Descricao
        FROM
            tb_cargo
        GROUP BY Car_Descricao
)
SELECT
	Car_Descricao
FROM 
	mediaSalarialCargo
GROUP BY 
	Car_Descricao 
HAVING AVG(MediaSalarial) > ANY (SELECT MediaSalarial FROM mediaSalarialCargo)
ORDER BY Car_Descricao ASC;

/*
	Exercício 2
*/

WITH emprestimos AS (
	SELECT 
		Emp_Data, COUNT(Emp_Codcliente) AS QuantidadeEmprestimosPorData
        FROM 
			tb_emprestimo
        GROUP BY Emp_Data 
        ORDER BY Emp_Data, QuantidadeEmprestimosPorData  ASC
),
reservas AS (SELECT 
		Res_Data,
		COUNT(Res_Codcliente) AS QuantidadeReservasPorData
        FROM 
			tb_reserva
        GROUP BY Res_Data 
        ORDER BY Res_Data, QuantidadeReservasPorData  ASC)
SELECT 
	Emp_Data, QuantidadeEmprestimosPorData
FROM 
	emprestimos
INNER JOIN
    reservas ON emprestimos.Emp_Data = reservas.Res_Data
GROUP BY Emp_Data
HAVING QuantidadeEmprestimosPorData > ANY (SELECT QuantidadeReservasPorData FROM reservas);

/*
	Exercício 3
*/

WITH exemplar AS (SELECT Exe_Codigo AS codigoExemplar, Exe_Codlivro as codigoExemplarLivro, Exe_Status AS statusExemplar FROM tb_exemplar),
exemplarEmprestimo AS (SELECT Exepre_Codexemplar AS codigoExemplarEmprestimo, Exepre_Codemprestimo AS codigoEmprestimo FROM tb_exemplaremprestimo),
livro AS (SELECT Liv_Codigo AS codigoLivro, Liv_Titulo AS tituloLivro FROM tb_livro)
SELECT 
	codigoLivro, tituloLivro
FROM 
	livro
INNER JOIN exemplar ON exemplar.codigoExemplarLivro = livro.codigoLivro
LEFT JOIN exemplarEmprestimo ON exemplarEmprestimo.codigoExemplarEmprestimo = exemplar.codigoExemplarLivro
WHERE codigoLivro NOT IN (SELECT codigoExemplarEmprestimo FROM exemplarEmprestimo)
GROUP BY codigoLivro
ORDER BY codigoLivro ASC;	


/*
	Exercício 4
*/

WITH rua AS (SELECT 
    End_Codigo AS enderecoID, End_Descricao AS descricaoEndereco
FROM
    tb_endereco),
cliente AS (SELECT 
    Cli_Codendereco,
    COUNT(DISTINCT Cli_Codigo) AS quantidadeClientes
FROM
    tb_cliente
GROUP BY Cli_Codendereco)
SELECT 
	descricaoEndereco
FROM cliente
INNER JOIN rua ON rua.enderecoID = cliente.Cli_Codendereco
GROUP BY descricaoEndereco, quantidadeClientes
HAVING quantidadeClientes > ANY (SELECT 
    ROUND(AVG(quantidadeClientes)) 
FROM
    cliente)
ORDER BY descricaoEndereco ASC;