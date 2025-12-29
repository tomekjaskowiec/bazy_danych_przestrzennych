create extension postgis;


CREATE EXTENSION postgis_raster;



CREATE TABLE exports_union AS
WITH ref AS (
    SELECT rast
    FROM exports
    LIMIT 1
)
SELECT
    ST_Union(
        ST_Resample(e.rast, ref.rast),
        'MAX'
    ) AS rast
FROM exports e, ref;