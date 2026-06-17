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
