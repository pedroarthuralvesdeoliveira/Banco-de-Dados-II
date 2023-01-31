/*
	SELECT 
    tb_cargo.Car_Descricao
FROM
    tb_cargo
WHERE
    (SELECT 
            ROUND(AVG(cargos.MediaSalarial)) AS MediaSalarialGeral
        FROM
            (SELECT 
                AVG(Car_Salariobase) AS MediaSalarial
            FROM
                tb_cargo
            GROUP BY Car_Codigo) cargos) > ANY (SELECT 
            ROUND(AVG(Car_Salariobase)) AS MediaSalarial
        FROM
            tb_cargo
        GROUP BY Car_Codigo)
ORDER BY Car_Descricao ASC
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
HAVING ROUND(AVG(mediaSalarialCargo.MediaSalarial)) > mediaSalarialCargo.MediaSalarial;