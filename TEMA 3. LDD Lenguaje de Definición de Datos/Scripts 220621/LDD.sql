--� Qu� es LDD? El lenguaje de definici�n de datos, se encarga de la modificaci�n de la estructura de los objetos de la base de datos

--operaciones b�sicas
--Subtopic 1
--CREATE: crear nuevas tablas
--DROP : eliminar tablas e �ndices

--TRUNCATE: borra todo el contenido de la tabla

--Crear tablaText

CREATE TABLE Empleado(

--id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

Nombre VARCHAR(50),

Apellido VARCHAR(50),

Direccion VARCHAR(255),

Ciudad VARCHAR(60),

Telefono VARCHAR(15),

Peso VARCHAR(5),

Edad VARCHAR(2),

--Actividad Espec�fica VARCHAR(100),

idCargo INT

)

--Modificar tablas Subtopic 2

--#ALTER TABLE 'NOMBRE_TABLA' ADD NUEVO_CAMPO INT

--#ALTER TABLE 'NOMBRE_TABLA' DROP COLUMN NOMBRE_COLUMNA

--Eliminar tablas

--#DROP TABLE 'NOMBRE_TABLA'

--#DROP SCHEMA 'ESQUEMA;'

--#DROP DATABASE 'BASEDATOS'

--Chart Borrar contenido
--#TRUNCATE TABLE 'NOMBRE_TABLA'

--Timeline