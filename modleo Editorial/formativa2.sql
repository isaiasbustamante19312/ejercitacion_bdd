USE Editorial;

-- ejercicio1 
SELECT R.cod_revista,
       E.nro_edicion,
       E.fecha,
       E.precio
FROM ediciones E
JOIN revistas R ON E.cod_revista = R.cod_revista
WHERE R.nombre_revista IN ('EL GRAFICO', 'MUY INTERESANTE', 'UTILISIMA')
  AND E.precio = (
        SELECT MAX(E2.precio)
        FROM ediciones E2
        WHERE E2.cod_revista = E.cod_revista
      )
ORDER BY R.cod_revista, E.nro_edicion;

-- ejercicio 2

SELECT
    HE.cuit,
    ED.apellido_contacto,
    HE.fecha_desde,
    HE.cant_dias_pago
FROM empresas_distribuidor ED
    JOIN hist_pago_empresa HE
        ON HE.cuit = ED.cuit
WHERE HE.fecha_desde = (
    SELECT MAX(HE2.fecha_desde)
    FROM hist_pago_empresa HE2
    WHERE HE2.cuit = HE.cuit
)
ORDER BY ED.apellido_contacto;


-- ejercicio 3

SELECT
    R.cod_revista,
    R.nombre_revista,
    COUNT(P.cod_plan) AS "Cantidad de planes"
FROM revistas R 
    JOIN planes P
        ON P.cod_revista = R.cod_revista
GROUP BY R.cod_revista,R.nombre_revista
HAVING COUNT(P.cod_plan) >= ALL (
    SELECT MAX(P2.cod_plan)
    FROM revistas R2
        JOIN planes P2
            ON P2.cod_revista = R2.cod_revista 
    GROUP BY R2.cod_revista)
ORDER BY R.nombre_revista
;

-- ejercicio 4

SELECT
    EM.apellido_contacto,
    ED.cod_revista,
    SUM(ED.cant_entregada) AS "Total Entregado"
FROM empresas_distribuidor EM
    JOIN entregas_distrib ED
        ON ED.cuit = EM.cuit
GROUP BY EM.apellido_contacto,ED.cod_revista
HAVING SUM(ED.cant_entregada) >= ALL (
    SELECT SUM(ED2.cant_entregada)
    FROM entregas_distrib ED2
    WHERE ED2.cuit = ED.cuit
    GROUP BY ED2.cod_revista
)
ORDER BY EM.apellido_contacto,ED.cod_revista;


SELECT EM.apellido_contacto,
       ED.cod_revista,
       SUM(ED.cant_entregada) AS Total_Entregado
FROM empresas_distribuidor EM
JOIN entregas_distrib ED 
     ON ED.cuit = EM.cuit
GROUP BY EM.apellido_contacto, ED.cod_revista
HAVING SUM(ED.cant_entregada) >= ALL (
    SELECT SUM(ED2.cant_entregada)
    FROM entregas_distrib ED2
    GROUP BY ED2.cod_revista
)
ORDER BY EM.apellido_contacto, ED.cod_revista;


-- ejercicio 5

SELECT
    R.cod_revista,
    R.nombre_revista
FROM revistas R
    JOIN rubros RU
        ON R.cod_rubro = RU.cod_rubro
WHERE RU.nombre_rubro LIKE '%CIENCIA Y TECNOLOGIA%' -- de otra forma da error
    AND NOT EXISTS(
        SELECT 1
        FROM planes_suscriptor SC
        WHERE SC.cod_revista = R.cod_revista
    )
ORDER BY R.nombre_revista;

-- ejercicio 6

SELECT
    R.cod_revista,
    R.nombre_revista
FROM revistas R
    JOIN planes P
        ON P.cod_revista = R.cod_revista
WHERE P.fec_fin_plan IS NULL
    AND NOT EXISTS(
        SELECT 1
        FROM planes_suscriptor PS
            JOIN formas_pago MP
                ON PS.forma_pago = MP.forma_pago
        WHERE PS.cod_revista = R.cod_revista
         AND MP.descripcion = 'TRANSFERENCIA'
    )
ORDER BY R.nombre_revista;

-- ejercicio 7 
SELECT
    E.nro_edicion,
    E.fecha,
    E.precio
FROM ediciones E 
    JOIN revistas R
        ON E.cod_revista = R.cod_revista
WHERE R.nombre_revista = 'EL GRAFICO'
    AND YEAR(E.fecha) = 2013 
    AND NOT EXISTS(
        SELECT 1
        FROM entregas_distrib ED
        WHERE  ED.nro_edicion = E.nro_edicion
            AND ED.cant_entregada <= 250
)
ORDER BY E.nro_edicion;

-- ejercicio 8
SELECT
    S.apellido,
    S.nombre,
    COUNT(DISTINCT PS.cod_plan) AS "Cantidad de planes"
FROM suscriptores S
    JOIN localidades L
        ON S.cod_localidad = L.cod_localidad
    JOIN planes_suscriptor PS
        ON PS.nro_doc = S.nro_doc
        AND PS.tipo_doc = S.tipo_doc
WHERE L.nom_localidad = 'CORDOBA'
GROUP BY S.apellido, S.nombre
HAVING COUNT(DISTINCT PS.cod_plan) >= 3
ORDER BY 
    "Cantidad de planes" DESC,
    S.apellido,
    S.nombre
;

-- ejercicio 9

SELECT
    Ed.cod_revista,
    COUNT(Ed.nro_edicion) AS "Cantidad Ediciones",
    SUM(Ed.tirada) AS "Tirada Total"
FROM ediciones Ed
WHERE YEAR(Ed.fecha) = 2014
GROUP BY Ed.cod_revista
HAVING SUM(Ed.tirada) >= 8000
ORDER BY "Tirada Total" DESC, Ed.cod_revista;

-- ejercicio 10

SELECT
    L.nom_localidad,
    P.nombre AS "nombre provincia",
    COUNT(*) AS "cant subs"
FROM suscriptores S
    JOIN localidades L
        ON S.cod_localidad = L.cod_localidad
    JOIN provincias P
        ON L.cod_provincia = P.cod_provincia
GROUP BY L.nom_localidad, P.nombre
ORDER BY "cant subs" DESC, L.nom_localidad;