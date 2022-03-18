USE pubs

GO

--1. Buscar los tipos de libros publicados por m�s de un editor.

SELECT * FROM dbo.titles

SELECT type AS MAS_Publicados
FROM dbo.titles
WHERE type like'%psychology%'

--2.  Buscar todos los t�tulos con un precio mayor que el precio promedio para libros del mismo tipo.

SELECT * FROM dbo.titles

SELECT title_id, title, price 
FROM dbo.titles
WHERE price = 22.95 or price = 19.99