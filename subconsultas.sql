USE GDA_PRACTICA_LABORATORIO;

-- SUBCONSULTAS
-- ejercicio 1
SELECT 
	E.nombre,
	E.apellido,
	E.fecha_ingreso
FROM empleados E
WHERE E.depto_id = (
	SELECT Em.depto_id
	FROM empleados Em
	WHERE Em.apellido = 'Magee'
	);

-- ejercicio 2

SELECT
	E.id,
	E.nombre,
	E.apellido,
	E.id_usuario
FROM empleados E
WHERE E.salario > (
	SELECT AVG(EM.salario)
	FROM empleados EM
	);

-- ejercicio 3
SELECT
	E.apellido,
	E.depto_id,
	E.titulo
FROM empleados E
	JOIN depto D 
		ON E.depto_id = D.id
WHERE D.id_region IN (
	SELECT De.id_region
	FROM depto De
	WHERE De.id_region IN (1, 2)
	);

-- ejercicio 4
/*es incorrecta porque si hay mas de un jefe 
con apellido 'Ngao' la subconsulta retornará más de un valor y la consulta principal fallará*/
SELECT
	E.apellido,
	E.salario
FROM empleados E
WHERE E.id_jefe = (
	SELECT Em.id
	FROM empleados Em
	WHERE Em.apellido = 'Ngao'
);

/*ejercicio 4 corregida ya que si hay más de un jefe con apellido 'Ngao' 
la subconsulta retornará más de un valor y la consulta principal no fallará, 
sino que devolverá los empleados cuyo jefe tenga el apellido 'Ngao'*/
SELECT
	E.apellido,
	E.salario
FROM empleados E
WHERE EXISTS (
	SELECT 1
	FROM empleados Em
	WHERE Em.apellido = 'Ngao' 
	  AND Em.id = E.id_jefe 
);

-- ejercicio 5
SELECT
	E.id,
	E.nombre,
	E.apellido
FROM empleados E
WHERE E.salario > (
	SELECT AVG(Em.salario)
	FROM empleados Em
)
AND E.depto_id IN (
	SELECT DISTINCT Em2.depto_id
	FROM empleados Em2
	WHERE Em2.apellido LIKE '%t%'
);

-- ejercicio 5 con referencia externa
SELECT
	E.id,
	E.nombre,
	E.apellido
FROM empleados E
WHERE E.salario > (
	SELECT AVG(Em.salario)
	FROM empleados Em
) -- Primera condición (se mantiene igual con Test de Comparación)
AND EXISTS (
	SELECT 1
	FROM empleados Em2
	WHERE Em2.depto_id = E.depto_id -- Referencia externa: mismo departamento
	  AND Em2.apellido LIKE '%t%'
); -- Segunda condición utilizando Test de Existencia

-- ejercicio 6

-- Solucion valida sin subconsulta pero hay mucho acomplamiento entre tablas
SELECT
	E.apellido,
	C.nombre,
	COUNT(P.id) AS cantidad_pedidos
FROM clientes C
	JOIN empleados E
		ON C.id_vendedor = E.id
	JOIN depto D
		ON E.depto_id = D.id 
	JOIN pedido P
		ON P.id_cliente = C.id
WHERE D.id_region IN (1,2)
GROUP BY E.apellido, C.nombre;

-- con test existencia para evitar el acoplamiento entre tablas y mejorar la legibilidad de la consulta
SELECT
	E.apellido,
	C.nombre,
	COUNT(P.id)
FROM clientes C
	JOIN empleados E
		ON C.id_vendedor = E.id
	JOIN pedido P
		ON P.id_cliente = C.id
WHERE EXISTS (
	SELECT 1
	FROM depto D
	WHERE D.id_region IN (1, 2)
	  AND D.id = E.depto_id 
)
GROUP BY E.apellido, C.nombre;


-- con IN para evitar el acoplamiento entre tablas y mejorar la legibilidad de la consulta
SELECT
	E.apellido,
	C.nombre,
	COUNT(P.id) 
FROM clientes C
	JOIN empleados E
		ON C.id_vendedor = E.id
	JOIN pedido P
		ON P.id_cliente = C.id
WHERE E.depto_id IN (
	SELECT D.id
	FROM depto D
	WHERE D.id_region IN (1, 2)
)
GROUP BY E.apellido, C.nombre;


-- ejercicio 7
SELECT
	P.id,
	P.nombre,
	SUM(I.cant_en_stock) AS "total inventario"
FROM producto P
	JOIN inventario I
		ON I.Id_producto = P.id
WHERE EXISTS (
	SELECT 1
	FROM pedido Pe JOIN item It
		ON It.ord_id = Pe.id
	WHERE It.Id_producto = P.id -- referencia externa a la tabla producto
	 AND MONTH(Pe.fecha_pedido) = 8
	)
GROUP BY P.id, P.nombre
HAVING COUNT(DISTINCT I.id_almacenes) >= 5 
;

-- forma con IN 

SELECT
	P.id,
	P.nombre,
	SUM(I.cant_en_stock) AS "total inventario"
FROM producto P
	JOIN inventario I ON I.Id_producto = P.id
WHERE P.id IN (
	SELECT It.Id_producto
	FROM pedido Pe 
	JOIN item It ON It.ord_id = Pe.id
	WHERE MONTH(Pe.fecha_pedido) = 8
) -- Subconsulta aislada con Test de Pertenencia
GROUP BY P.id, P.nombre
HAVING COUNT(DISTINCT I.id_almacenes) >= 5;



SELECT
	P.id,
	--I.Id_producto,
	--I.id_almacenes,
	P.nombre,
	COUNT(I.id_almacenes) AS cantidad_almacenes
FROM producto P
	JOIN inventario I
		ON I.Id_producto = P.id
GROUP BY P.id, P.nombre
ORDER BY cantidad_almacenes DESC;

