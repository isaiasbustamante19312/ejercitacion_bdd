USE GDA_PRACTICA_LABORATORIO;

-- CONSULTAS SUMARIAS
-- ejercicio 1
SELECT 
	E.depto_id,
	AVG(E.salario) AS "Salario Promedio"
FROM empleados E
GROUP BY E.depto_id
HAVING AVG(E.salario) >= 2000;

-- ejercicio 2
SELECT
	P.id AS "pedido",
	COUNT(I.ord_id) AS "items"
FROM item I
	JOIN pedido P
		ON I.ord_id = P.id
GROUP BY P.id
ORDER BY COUNT(I.ord_id) DESC;

-- ejercicio 3

SELECT
	J.id,
	MIN(D.salario) AS "sueldo" 
FROM empleados D
	JOIN empleados J
		ON D.id_jefe = J.id
GROUP BY J.id
HAVING MIN(D.salario) >= 1000
ORDER BY "sueldo";

-- ejercicio 4
SELECT
	(MAX(E.salario) - MIN(E.salario))
FROM empleados E;

-- ejercicio 5

SELECT
	R.id,
	R.name,
	COUNT(D.id) 
FROM region R
	JOIN depto D
		ON D.id_region = R.id
GROUP BY R.id, R.name;

-- ejercicio 6

SELECT 
	R.id AS "Reg",
	COUNT(E.id) AS "Empleados"
FROM empleados E
	JOIN depto D
		ON E.depto_id = D.id
	JOIN region R
		ON D.id_region = R.id
GROUP BY R.id;

-- ejercicio 7

SELECT
	P.id AS "venta",
	COUNT(DISTINCT I.Id_producto) AS "productos"
FROM item I
	JOIN pedido P
		ON I.ord_id = P.id
	JOIN producto PR
		ON I.Id_producto = PR.id
GROUP BY P.id;



SELECT *
FROM item;