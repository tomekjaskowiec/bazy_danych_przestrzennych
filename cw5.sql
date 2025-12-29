create extension postgis;



create table public.obiekty
(
    id       serial
        constraint buildings_pk
            primary key,
    geometry geometry,
    name     varchar
);




--a

INSERT INTO public.obiekty (geometry, name)
VALUES (
        st_curvetoline(
                ST_GeomFromText('COMPOUNDCURVE(
        (0 1, 1 1),
        CIRCULARSTRING(1 1, 2 0, 3 1),
        CIRCULARSTRING(3 1, 4 2, 5 1),
        (5 1, 6 1)
    )', 0)),
                'object1'
        );






--b
INSERT INTO public.obiekty (geometry, name)
VALUES (
    ST_CurveToLine(
        ST_GeomFromText(
            'CURVEPOLYGON(
                COMPOUNDCURVE(
                    (10 6, 14 6),
                    CIRCULARSTRING(14 6, 16 4, 14 2),
                    CIRCULARSTRING(14 2, 12 0, 10 2),
                    (10 2, 10 6)
                ),
                COMPOUNDCURVE(
                    CIRCULARSTRING(11 2, 12 1, 13 2, 12 3, 11 2)
                )
            )',
            0
        )
    ),
    'object2'
);






--c
INSERT INTO public.obiekty (geometry, name)
VALUES (

        ST_GeomFromText(
            'POLYGON(
                    (10 17, 12 13, 7 15, 10 17)
                    )',
            0
        ),
    'object3'
);


--d
INSERT INTO public.obiekty (geometry, name)
VALUES (

        ST_GeomFromText(
            'LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)',0
        ),
    'object4'
);
--e

INSERT INTO obiekty (geometry, name) VALUES
(
 ST_GeomFromEWKT('SRID=0;MULTIPOINTZ((30 30 59),(38 32 234))'),
 'object5');

SELECT ST_AsEWKT(geometry) FROM obiekty WHERE name = 'object5';

select * from obiekty;

--f
INSERT INTO public.obiekty (geometry, name)
VALUES (
    st_collect(ST_GeomFromText('LINESTRING(1 1, 3 2)', 0),ST_GeomFromText('POINT(4 2)', 0)),
    'object6'
);






--2
SELECT
    st_area(
    st_buffer(
        st_shortestline(
            a.geometry,
            b.geometry
                        )
        ,5)
    )
FROM public.obiekty a, public.obiekty b
WHERE a.name = 'object3'
  AND b.name = 'object4';






--3
SELECT
    st_makepolygon(st_addpoint(geometry, st_startpoint(geometry)))
FROM public.obiekty
WHERE name = 'object4';




--4

INSERT INTO public.obiekty (geometry, name)
VALUES (

        (SELECT st_collect(a.geometry, b.geometry)
FROM public.obiekty a, public.obiekty b
WHERE a.name = 'object3'
  AND b.name = 'object4'),
    'object7'
);






--5

SELECT
    sum(st_area(
    st_buffer(a.geometry,5)
    ))
FROM public.obiekty a
WHERE not ST_HasArc(a.geometry);




SELECT * FROM obiekty;


