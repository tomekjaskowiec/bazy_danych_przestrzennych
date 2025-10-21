create extension postgis;

create table cw2.buildings
(
    id       serial
        constraint buildings_pk
            primary key,
    geometry geometry,
    name     varchar
);

create table cw2.roads
(
    id_roads serial
        constraint roads_pk
            primary key,
    geometry geometry,
    name     varchar
);

INSERT INTO cw2.buildings (geometry, name)
VALUES
    (ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))'), 'BuildingC'),

(ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))'), 'BuildingB'),
    (ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))'), 'BuildingA'),
    (ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))'), 'BuildingD'),
    (ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))'), 'BuildingF')

;


INSERT INTO cw2.roads (geometry, name)
VALUES
    (ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)'), 'RoadX'),
    (ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)'), 'RoadY')

;
INSERT INTO cw2.poi (geometry, name)
VALUES
    (ST_GeomFromText('POINT(6 9.5)'), 'K'),
    (ST_GeomFromText('POINT(6.5 6)'), 'J'),
    (ST_GeomFromText('POINT(9.5 6)'), 'I'),
    (ST_GeomFromText('POINT(6 9.5)'), 'K'),
    (ST_GeomFromText('POINT(5.5 1.5)'), 'H')

;

--a

select sum(st_length(roads.geometry)) from roads;

--b
select buildings.geometry  from buildings
where buildings.name like 'BuildingA';
--c
select buildings.name, st_area(buildings.geometry) from buildings
order by buildings.name;
--d
select buildings.name, ST_Perimeter(buildings.geometry) from buildings
order by buildings.name;
limit 2;
--e


select st_distance(buildings.geometry,
       (select poi.geometry from poi where poi.name ='K'))

from buildings
where buildings.name= 'BuildingC';


--f


select
st_area(st_difference(buildings.geometry,st_intersection(
(select st_buffer(b1.geometry, 0.5) from buildings b1 where b1.name='BuildingB'), buildings.geometry)))as diff
from buildings
where buildings.name= 'BuildingC';

--g


