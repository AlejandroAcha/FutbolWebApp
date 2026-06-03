-- ============================================================
-- Script de configuracion: Code Validation Table PAIS
-- Ejecutar en la base de datos MySQL 'futbol'
-- ============================================================

-- 1. Insertar el tipo PAIS en CodeType (si no existe)
INSERT INTO CodeType (Type, Description, Comment)
SELECT 'PAIS', 'Nacionalidad', 'Valores de nacionalidad para jugadores y entrenadores'
WHERE NOT EXISTS (SELECT 1 FROM CodeType WHERE Type = 'PAIS');

-- 2. Insertar todas las nacionalidades de jugadores (ajustar con resultado de SELECT DISTINCT)
--    Ejecutar primero: SELECT DISTINCT nacionalidad FROM jugador;
--    Ejecutar primero: SELECT DISTINCT nacionalidad FROM entrenador;
--    Luego insertar cada valor encontrado con la siguiente plantilla:

INSERT IGNORE INTO CodeMast (Type, Code, Description)
SELECT 'PAIS', nacionalidad, nacionalidad FROM (
    SELECT DISTINCT nacionalidad FROM jugador WHERE nacionalidad IS NOT NULL AND nacionalidad <> ''
    UNION
    SELECT DISTINCT nacionalidad FROM entrenador WHERE nacionalidad IS NOT NULL AND nacionalidad <> ''
) AS valores;
