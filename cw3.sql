create extension if not exists postgis;



--1


select * from t2019_kar_buildings
except
select * from t2018_kar_buildings;


--2

select st_srid(t2019_kar_buildings.geometry) from t2019_kar_buildings;
update t2019_kar_buildings
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(t2019_kar_buildings.geometry) != 3068;

update t2019_kar_buildings
set geometry = ST_SetSRID(geometry, 0)
where st_srid(t2019_kar_buildings.geometry) != 0;

update t2018_kar_buildings
set geometry = ST_SetSRID(geometry, 0)
where st_srid(t2018_kar_buildings.geometry) != 0;


update t2019_kar_poi_table
set geometry = ST_SetSRID(geometry, 0)
where st_srid(t2019_kar_poi_table.geometry) != 0;

update t2018_kar_poi_table
set geometry = ST_SetSRID(geometry, 0)
where st_srid(t2018_kar_poi_table.geometry) != 0;


Select poi.type, count(poi.*) from (select poi2019.* from t2019_kar_poi_table poi2019
               except select poi2018.* from t2018_kar_poi_table poi2018) poi
join
(select * from t2019_kar_buildings
except
select * from t2018_kar_buildings) new_buildings
on ST_WITHIN(st_setsrid(poi.geometry,25832),st_buffer(st_setsrid(new_buildings.geometry,25832), 500))
group by poi.type;










--3

select st_srid(t2019_kar_streets.geometry) from t2019_kar_streets;


create table streets_reprojected as
Select *
From t2019_kar_streets;

update streets_reprojected
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(streets_reprojected.geometry) != 3068;


select st_srid(streets_reprojected.geometry) from streets_reprojected;


--4
create table input_points
(
    id       serial
        constraint input_points_pk
            primary key,
    geometry geometry,
    name     varchar
);


insert into input_points (id, geometry, name)
values (1,ST_GeomFromText('POINT(8.36093 49.03174)'), 'A'),
       (2,ST_GeomFromText('POINT(8.39876 49.00644)'), 'B');

update input_points
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(input_points.geometry) != 3068;

--5
select st_srid(t2019_kar_street_node.geometry) from t2019_kar_street_node;
update t2019_kar_street_node
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(t2019_kar_street_node.geometry) != 3068;

--6
select nodes.* from t2019_kar_street_node nodes
where st_within(st_transform(nodes.geometry,25832), st_buffer(st_makeline
      ((select st_transform(poi.geometry,25832) from input_points poi where poi.name like 'A' limit 1),
      (select st_transform(poi.geometry,25832) from input_points poi where poi.name like 'B' limit 1)),200)
       );

--7
select st_srid(t2019_kar_land_use_a.geometry) from t2019_kar_land_use_a;
update t2019_kar_land_use_a
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(t2019_kar_land_use_a.geometry) != 3068;

select st_srid(t2019_kar_poi_table.geometry) from t2019_kar_poi_table;
update t2019_kar_poi_table
set geometry = ST_SetSRID(geometry, 3068)
where st_srid(t2019_kar_poi_table.geometry) != 3068;

select count(*) as number_of_shops
from t2019_kar_poi_table as poi
where poi.type like 'Sporting Goods Store'
  and ST_DWithin(ST_Transform(poi.geometry, 25832),(SELECT ST_Union(ST_Transform(land.geometry, 25832))FROM t2019_kar_land_use_a AS land WHERE land.type ILIKE '%park%'),
        200
      );




--select poi.* from t2019_kar_poi_table poi
--where poi.type like 'Sporting Goods Store'


--8
create table input_points
(
    id       serial
        constraint input_points_pk
            primary key,
    geometry geometry,
    name     varchar
);
drop table T2019_KAR_BRIDGES;


select distinct st_intersection(water.geometry, rails.geometry) as geometry into T2019_KAR_BRIDGES from t2019_kar_railways rails
join t2019_kar_water_lines water on st_intersects(water.geometry,rails.geometry)
