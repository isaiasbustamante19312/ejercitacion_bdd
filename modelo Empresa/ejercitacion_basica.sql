USE GDA_PRACTICA_LABORATORIO;

--creacion de una tabla de prueba
CREATE TABLE prueba
(id			INT IDENTITY(1,1) NOT NULL,
dni			INT,
tipo_dni	INT,
nombre		VARCHAR(30),
apellido	VARCHAR(30),
cantidad	INT NOT NULL,
	CONSTRAINT pk_id_prueba 
		PRIMARY KEY(id),
	CONSTRAINT fk_tipo_dni 
		FOREIGN KEY  (tipo_dni)
		REFERENCES tipo_dni (id_tipo_dni)
);

--creacion de una tabla para tipos de dni

CREATE TABLE tipo_dni
(id_tipo_dni	INT IDENTITY(1,1) NOT NULL,
nombre_tipo_dni	VARCHAR(30),
	CONSTRAINT pk_id_tipo_dni 
		PRIMARY KEY(id_tipo_dni)
);

--modificacion de la tabla de prueba

--agregar una columna a la tabla de prueba
ALTER TABLE prueba
	ADD descripcion	VARCHAR(50);	

--eliminar una columna de la tabla de prueba
ALTER TABLE prueba
	DROP COLUMN descripcion;

--eliminar una columna y agregarla nuevamente a la tabla de prueba
ALTER TABLE prueba
	DROP COLUMN dni;

ALTER TABLE prueba
	ADD dni	INT;

--introducir datos a una tabla
/*si la tabla tiene una columna con identidad, 
no es necesario especificar un valor para esa columna, ya que se generará automáticamente. Por lo tanto, 
al insertar datos en la tabla "prueba", no es necesario incluir la columna "id" en la lista de columnas ni proporcionar un valor para ella. 
El sistema asignará automáticamente un valor único a cada nueva fila insertada.*/

INSERT INTO tipo_dni (nombre_tipo_dni)
VALUES	
	('DNI') ,
	('Pasaporte') ,
	('Cedula') ,
	('Cuil') ,
	('Cuit');

-- insercion de datos en tabla de prueba
INSERT INTO prueba (dni, tipo_dni, nombre, apellido, cantidad)
VALUES	(12345678, 1, 'Juan', 'Perez', 10) ;

INSERT INTO prueba (dni, tipo_dni, nombre, apellido, cantidad)
VALUES
	(87654321, 2, 'Maria', 'Gomez', 20) ,
	(11223344, 3, 'Carlos', 'Lopez', 15) ,
	(44332211, 4, 'Ana', 'Martinez', 5) ,
	(55667788, 5, 'Luis', 'Garcia', 8);

/*ALTERE la TABLE prueba para poder introducir datos en la columna cantidad, ya que al crear la tabla se 
estableció como NOT NULL, pero no se proporcionó un valor predeterminado*/
ALTER TABLE prueba
	ALTER COLUMN cantidad INT;

--introduccion de datos a la tabla de prueba utilizando una consulta SELECT
INSERT INTO prueba (tipo_dni)
SELECT D.id_tipo_dni
	FROM tipo_dni D
WHERE D.id_tipo_dni = 1;

--actualizacion de datos en la tabla de prueba
UPDATE prueba
	SET cantidad = 13, tipo_dni = 1
WHERE id = 1 
	OR id = 2
	OR id = 3;

-- eliminar filas con tipo_dni igual a 1

DELETE FROM prueba
WHERE tipo_dni = 1;

-- eliminar todas las filas de la tabla de prueba
DELETE FROM prueba;

-- consultar todos los datos de la tabla de prueba
SELECT *
FROM prueba;