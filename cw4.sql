create extension postgis;



select st_srid(trees.geometry) from trees