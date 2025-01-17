SET client_min_messages TO warning;

SELECT 'ndims01', ST_ndims(ST_geomfromewkt('CIRCULARSTRING(
                0 0 0 0,
                0.26794919243112270647255365849413 1 3 -2,
                0.5857864376269049511983112757903 1.4142135623730950488016887242097 1 2)'));
SELECT 'geometrytype01', geometrytype(ST_geomfromewkt('CIRCULARSTRING(
                0 0 0 0,
                0.26794919243112270647255365849413 1 3 -2,
                0.5857864376269049511983112757903 1.4142135623730950488016887242097 1 2)'));
SELECT 'ndims02', ST_ndims(ST_geomfromewkt('CIRCULARSTRING(
                0 0 0,
                0.26794919243112270647255365849413 1 3,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 1)'));
SELECT 'geometrytype02', geometrytype(ST_geomfromewkt('CIRCULARSTRING(
                0 0 0,
                0.26794919243112270647255365849413 1 3,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 1)'));
SELECT 'ndims03', ST_ndims(ST_geomfromewkt('CIRCULARSTRINGM(
                0 0 0,
                0.26794919243112270647255365849413 1 -2,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 2)'));
SELECT 'geometrytype03', geometrytype(ST_geomfromewkt('CIRCULARSTRINGM(
                0 0 0,
                0.26794919243112270647255365849413 1 -2,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 2)'));
SELECT 'ndims04', ST_ndims(ST_geomfromewkt('CIRCULARSTRING(
                0 0,
                0.26794919243112270647255365849413 1,
                0.5857864376269049511981127579 1.4142135623730950488016887242097)'));
SELECT 'geometrytype04', geometrytype(ST_geomfromewkt('CIRCULARSTRING(
                0 0,
                0.26794919243112270647255365849413 1,
                0.5857864376269049511981127579 1.4142135623730950488016887242097)'));

SELECT 'isClosed01', ST_IsClosed(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                2 0,
                0 -2)'));
SELECT 'isSimple01', ST_IsSimple(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                2 0,
                0 -2)'));
SELECT 'isRing01', ST_IsRing(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                2 0,
                0 -2)'));
SELECT 'isClosed02', ST_IsClosed(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                -2 0,
                2 -2,
                -2 0,
                -2 -2,
                -2 0,
                0 -2)'));
SELECT 'isSimple02', ST_IsSimple(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                -2 0,
                2 -2,
                -2 0,
                -2 -2,
                -2 0,
                0 -2)'));
SELECT 'isRing02', ST_IsRing(ST_geomfromewkt('CIRCULARSTRING(
                0 -2,
                -2 0,
                0 2,
                -2 0,
                2 -2,
                -2 0,
                -2 -2,
                -2 0,
                0 -2)'));

CREATE TABLE public.circularstring (id INTEGER, description VARCHAR,
the_geom_2d GEOMETRY(CIRCULARSTRING),
the_geom_3dm GEOMETRY(CIRCULARSTRINGM),
the_geom_3dz GEOMETRY(CIRCULARSTRINGZ),
the_geom_4d GEOMETRY(CIRCULARSTRINGZM));

INSERT INTO public.circularstring (
        id,
        description
      ) VALUES (
        1,
        '180-135 degrees');
UPDATE public.circularstring
        SET the_geom_4d = ST_Geomfromewkt('CIRCULARSTRING(
                0 0 0 0,
                0.26794919243112270647255365849413 1 3 -2,
                0.5857864376269049511983112757903 1.4142135623730950488016887242097 1 2)')
        WHERE id = 1;
UPDATE public.circularstring
        SET the_geom_3dz = ST_Geomfromewkt('CIRCULARSTRING(
                0 0 0,
                0.26794919243112270647255365849413 1 3,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 1)')
        WHERE id = 1;
UPDATE public.circularstring
        SET the_geom_3dm = ST_Geomfromewkt('CIRCULARSTRINGM(
                0 0 0,
                0.26794919243112270647255365849413 1 -2,
                0.5857864376269049511981127579 1.4142135623730950488016887242097 2)')
        WHERE id = 1;
UPDATE public.circularstring
        SET the_geom_2d = ST_Geomfromewkt('CIRCULARSTRING(
                0 0,
                0.26794919243112270647255365849413 1,
                0.5857864376269049511981127579 1.4142135623730950488016887242097)')
        WHERE id = 1;

INSERT INTO public.circularstring (
        id,
        description
      ) VALUES (
        2,
        '2-segment string');
UPDATE public.circularstring
        SET the_geom_4d = ST_Geomfromewkt('CIRCULARSTRING(
                -5 0 0 4,
                0 5 1 3,
                5 0 2 2,
                10 -5 3 1,
                15 0 4 0)')
        WHERE id = 2;
UPDATE public.circularstring
        SET the_geom_3dz = ST_Geomfromewkt('CIRCULARSTRING(
                -5 0 0,
                0 5 1,
                5 0 2,
                10 -5 3,
                15 0 4)')
        WHERE id = 2;
UPDATE public.circularstring
        SET the_geom_3dm = ST_Geomfromewkt('CIRCULARSTRINGM(
                -5 0 4,
                0 5 3,
                5 0 2,
                10 -5 1,
                15 0 0)')
        WHERE id = 2;
UPDATE public.circularstring
        SET the_geom_2d = ST_Geomfromewkt('CIRCULARSTRING(
                -5 0,
                0 5,
                5 0,
                10 -5,
                15 0)')
        WHERE id = 2;

SELECT 'astext01', ST_astext(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'astext02', ST_astext(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'astext03', ST_astext(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'astext04', ST_astext(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'asewkt01', ST_AsEWKT(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkt02', ST_AsEWKT(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkt03', ST_AsEWKT(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkt04', ST_AsEWKT(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'asbinary01', encode(ST_AsBinary(the_geom_2d, 'ndr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asbinary02', encode(ST_AsBinary(the_geom_3dm, 'xdr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asbinary03', encode(ST_AsBinary(the_geom_3dz, 'ndr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asbinary04', encode(ST_AsBinary(the_geom_4d, 'xdr'), 'hex') FROM public.circularstring ORDER BY 1,2;

SELECT 'asewkb01', encode(ST_AsEWKB(the_geom_2d, 'ndr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkb02', encode(ST_AsEWKB(the_geom_3dm, 'xdr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkb03', encode(ST_AsEWKB(the_geom_3dz, 'ndr'), 'hex') FROM public.circularstring ORDER BY 1,2;
SELECT 'asewkb04', encode(ST_AsEWKB(the_geom_4d, 'xdr'), 'hex') FROM public.circularstring ORDER BY 1,2;

SELECT 'ST_CurveToLine-201', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_2d, 2), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-202', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dm, 2), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-203', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dz, 2), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-204', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_4d, 2), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;

SELECT 'ST_CurveToLine-401', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_2d, 4), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-402', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dm, 4), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-403', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dz, 4), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine-404', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_4d, 4), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;

SELECT 'ST_CurveToLine01', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_2d), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine02', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dm), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine03', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_3dz), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;
SELECT 'ST_CurveToLine04', ST_AsEWKT(ST_SnapToGrid(ST_CurveToLine(the_geom_4d), 'POINT(0 0 0 0)'::geometry, 1e-8, 1e-8, 1e-8, 1e-8), 3) FROM public.circularstring ORDER BY 1,2;

-- TODO: ST_SnapToGrid is required to remove platform dependent precision
-- issues.  Until ST_SnapToGrid is updated to work against curves, these
-- tests cannot be run.
--SELECT 'ST_LineToCurve01', ST_AsEWKT(ST_LineToCurve(ST_CurveToLine(the_geom_2d))) FROM public.circularstring ORDER BY 1,2;
--SELECT 'ST_LineToCurve02', ST_AsEWKT(ST_LineToCurve(ST_CurveToLine(the_geom_3dm))) FROM public.circularstring ORDER BY 1,2;
--SELECT 'ST_LineToCurve03', ST_AsEWKT(ST_LineToCurve(ST_CurveToLine(the_geom_3dz))) FROM public.circularstring ORDER BY 1,2;
--SELECT 'ST_LineToCurve04', ST_AsEWKT(ST_LineToCurve(ST_CurveToLine(the_geom_4d))) FROM public.circularstring ORDER BY 1,2;

SELECT 'isValid01', ST_IsValid(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'isValid02', ST_IsValid(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'isValid03', ST_IsValid(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'isValid04', ST_IsValid(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'dimension01', ST_dimension(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'dimension02', ST_dimension(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'dimension03', ST_dimension(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'dimension04', ST_dimension(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'SRID01', ST_SRID(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'SRID02', ST_SRID(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'SRID03', ST_SRID(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'SRID04', ST_SRID(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'accessors01', ST_IsEmpty(the_geom_2d), ST_IsSimple(the_geom_2d), ST_IsClosed(the_geom_2d), ST_IsRing(the_geom_2d) FROM public.circularstring ORDER BY 1,2;
SELECT 'accessors02', ST_IsEmpty(the_geom_3dm), ST_IsSimple(the_geom_3dm), ST_IsClosed(the_geom_3dm), ST_IsRing(the_geom_3dm) FROM public.circularstring ORDER BY 1,2;
SELECT 'accessors03', ST_IsEmpty(the_geom_3dz), ST_IsSimple(the_geom_3dz), ST_IsClosed(the_geom_3dz), ST_IsRing(the_geom_3dz) FROM public.circularstring ORDER BY 1,2;
SELECT 'accessors04', ST_IsEmpty(the_geom_4d), ST_IsSimple(the_geom_4d), ST_IsClosed(the_geom_4d), ST_IsRing(the_geom_4d) FROM public.circularstring ORDER BY 1,2;

SELECT 'envelope01', ST_AsText(ST_Envelope(the_geom_2d), 8) FROM public.circularstring ORDER BY 1,2;
SELECT 'envelope02', ST_AsText(ST_Envelope(the_geom_3dm), 8) FROM public.circularstring ORDER BY 1,2;
SELECT 'envelope03', ST_AsText(ST_Envelope(the_geom_3dz), 8) FROM public.circularstring ORDER BY 1,2;
SELECT 'envelope04', ST_AsText(ST_Envelope(the_geom_4d), 8) FROM public.circularstring ORDER BY 1,2;

SELECT ST_AsText(box2d('CIRCULARSTRING(220268.439465645 150415.359530563,220227.333322076 150505.561285879,220227.353105332 150406.434743975)'::geometry), 4);
SELECT 'npoints_is_five', ST_NumPoints(ST_GeomFromEWKT('CIRCULARSTRING(0 0,2 0, 2 1, 2 3, 4 3)'));

-- See http://trac.osgeo.org/postgis/ticket/2410
SELECT 'straight_curve', ST_AsText(ST_CurveToLine(ST_GeomFromEWKT('CIRCULARSTRING(0 0,1 0,2 0,3 0,4 0)')));

DROP TABLE IF EXISTS public.circularstring;
