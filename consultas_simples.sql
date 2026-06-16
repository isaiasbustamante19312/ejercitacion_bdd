USE GDA_PRACTICA_LABORATORIO;

-- CONSULTAS SIMPLES
-- ejercicio 1

SELECT 
	E.depto_id,
	E.apellido, 
	E.id_jefe
FROM empleados E;

-- ejercicio 2
-- Se pueden aplicar operaciones al realizar una consulta
SELECT 
	E.apellido, 
	(E.salario * 12) AS 'Sueldo Anual',
	E.porcent_comision
FROM empleados E;

-- ejercicio 3
-- no me quedo tan bien, ya que no entendi el ejercicio

SELECT 
	E.apellido,
	(E.salario * 12 + 100) AS 'Compensacion Anual',
	E.salario
FROM empleados E
ORDER BY E.salario DESC;

-- ejercicio 4
SELECT 
	E.apellido,
	E.salario,
	E.titulo,
	(E.salario * E.porcent_comision / 100) AS 'comis calc'
FROM empleados E;

--ejercicio 5
-- DISTINCT permite seleccionar columnas distintas
SELECT DISTINCT
	D.nombre
FROM depto D
WHERE D.nombre LIKE '%O%';

-- ejercicio 6

SELECT
	E.nombre,
	E.apellido,
	E.titulo
FROM empleados E
WHERE E.apellido = 'Magee';

--ejercicio 7

SELECT 
	T.*,
	(T.cantidad * T.precio) AS 'Total'
FROM item T
WHERE T.item_id = 1;

-- ejercicio 8

SELECT C.*
FROM empleados C
WHERE C.nombre LIKE 'C_r%'

-- ejercicio 9

SELECT P.*
FROM pedido P
WHERE 
    P.fecha_pedido BETWEEN CONVERT(DATE, '30/08/1992', 103) 
                       AND CONVERT(DATE, '05/09/1992', 103)
    AND P.tipo_pago = 'CREDITO'
    -- DATEDIFF calcula la diferencia exacta en días entre el pedido y el envío
    AND DATEDIFF(DAY, P.fecha_pedido, P.fecha_enviado) <= 15
ORDER BY P.fecha_pedido DESC;

-- ejercicio 10

SELECT E.*
FROM empleados E
WHERE E.id_jefe IS NULL;

-- ejercicio 11

SELECT C.*
FROM clientes C
WHERE C.id_vendedor IS NOT NULL;

-- ejercicio 12
SELECT 
	C.id,
	C.nombre,
	C.direccion
FROM clientes C
WHERE 
	C.pais = 'USA'
	AND C.id_vendedor = 11
ORDER BY nombre DESC;

-- ejercicio 13

SELECT 
	E.nombre,
	E.apellido,
	E.fecha_ingreso
FROM empleados E
WHERE E.fecha_ingreso
	BETWEEN CONVERT(DATE,'09-05-1991', 103)
		AND CONVERT(DATE, '17-06-1991', 103);


SELECT *
FROM item
ORDER BY item_id;

SELECT *
FROM empleados
ORDER BY apellido;