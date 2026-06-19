USE GDA_PRACTICA_LABORATORIO;

-- EJERCICIO MULTITABLA
-- ejercicio 1

SELECT
	E.nombre AS 'Nombre Empleado',
	D.id	 AS 'Depto',
	D.nombre AS 'Nombre Departamento'
FROM empleados E
	JOIN depto D
		ON E.depto_id = D.id;

-- ejercicio 2

SELECT
	D.id AS 'Numero Departamento',
	D.id_region AS 'Numero Region',
	R.name
FROM depto D 
	JOIN region R
	ON D.id_region = R.id;

-- ejercicio 3

SELECT
	E.apellido AS 'Apellido Empleado',
	R.name AS 'Nombre Region',
	E.porcent_comision 
FROM empleados E
	JOIN depto D
		ON E.depto_id = D.id
	JOIN region R
		ON D.id_region = R.id
WHERE E.porcent_comision IS NOT NULL;

-- ejercicio 4

SELECT
	E.apellido,
	E.salario,
	E.depto_id AS 'Numero Depto',
	D.nombre   AS 'Nombre Depto'
FROM empleados E JOIN depto D
		ON E.depto_id = D.id
WHERE (E.depto_id = 44 
		AND E.salario >= 1000)
	OR (E.depto_id = 42) ;

-- ejercicio 5
SELECT
	E.nombre AS 'Nombre Empleado',
	E.id AS 'ID Empleado',
	E.id_jefe AS 'ID Jefe',
	J.nombre AS 'Nombre Jefe'
	/*aplicamos left join para que nos muestre a todos los empleados aunque no tengan jefe asignado, 
	en ese caso el nombre del jefe aparecerá como null*/
FROM empleados E LEFT JOIN empleados J
	ON E.id_jefe = J.id ;

-- ejercicio 6
SELECT DISTINCT
	E.nombre,
	E.apellido
FROM pedido P 
	JOIN empleados E
		ON P.Ventas_rep_id = E.id
	JOIN clientes C
		ON P.id_cliente = C.id
WHERE C.pais IN ('USA', 'Mexico')
	AND MONTH(P.fecha_pedido) = 9
	AND YEAR(P.fecha_pedido) = 1992;

-- ejercicio 7
SELECT 
	I.*,
	P.fecha_pedido,
	E.nombre
FROM item I
	JOIN pedido P
		ON I.ord_id = P.id
	JOIN empleados E
		ON P.Ventas_rep_id = E.id
WHERE I.cantidad_enviada >= 500 
ORDER BY I.ord_id, I.item_id;

-- ejercicio 8
SELECT
	I.Id_producto,
	I.cant_en_stock,
	I.max_en_stock
FROM inventario I 
	JOIN almacenes A
		ON I.id_almacenes = A.id
WHERE A.pais = 'Brasil'
	/*si necesito comparar deber ser el mismo tipo de dato, 
	por eso convierto cant_en_stock a float*/
	AND CONVERT(float, I.cant_en_stock) >= (I.max_en_stock * 0.90);