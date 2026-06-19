-- ejercicio 1

USE Editorial;


SELECT 
	ED.cuit,
	ED.nombre_contacto,
	ED.apellido_contacto,
	SUM(ENT.cant_entregada) AS entregas
FROM empresas_distribuidor ED
	JOIN entregas_distrib ENT
		ON ENT.cuit = ED.cuit
GROUP BY
	ED.cuit,
	ED.nombre_contacto,
	ED.apellido_contacto
HAVING SUM(ENT.cant_entregada) >= ALL (
	SELECT  SUM(ENT2.cant_entregada)
	FROM entregas_distrib ENT2
	GROUP BY ENT2.cuit
)
;

-- ejercicio 2
SELECT
	S.apellido,
	S.nombre,
	R.cod_revista,
	R.nombre_revista,
	P.precio_tapa
FROM planes_suscriptor PS 
	JOIN revistas R
		ON PS.cod_revista = R.cod_revista
	JOIN rubros RB 
		ON R.cod_rubro = RB.cod_rubro
	JOIN suscriptores S
		ON PS.nro_doc = S.nro_doc
		AND PS.tipo_doc = S.tipo_doc
	JOIN planes P
		ON P.cod_revista = R.cod_revista
WHERE RB.nombre_rubro LIKE '%CULTURA%'
	AND P.precio_tapa <= 20
	AND NOT EXISTS(
		SELECT 1
		FROM entregas_distrib ET
		WHERE ET.cod_revista = R.cod_revista
	)
;

-- ejercicio 3

SELECT
	ED.cuit,
	ED.nombre_contacto,
	R.nombre_revista,
	SUM(CE.monto) AS "monto publicidad"
FROM empresas_distribuidor ED
	JOIN costos_empresas CE
		ON CE.cuit = ED.cuit
	JOIN revistas R
		ON CE.cod_revista = R.cod_revista
GROUP BY 
	ED.cuit,
	ED.nombre_contacto,
	R.nombre_revista
HAVING SUM(CE.monto) >= ALL(
	SELECT SUM(CE2.monto)
	FROM costos_empresas CE2
		JOIN revistas R2
			ON CE2.cod_revista = R2.cod_revista
	WHERE CE2.cuit = ED.cuit
	GROUP BY R2.cod_revista
)
;
