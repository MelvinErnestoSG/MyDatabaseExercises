--CLASE NO. 5
--STORE PRODCEDURE
--SP DEL SISTEMA

exec sp_datatype_info

-----------------
--Ejemplo 1
GO
create procedure ObtenerNombre
@ClienteId nvarchar(5) 
as
select ContactName
	from Customers  where CustomerID=@ClienteId
GO


Exec ObtenerNombre 'AlFKI'

Exec ObtenerNombre @clienteId='ALFKI'

---------------------------------------------
--EJEMPLO 2
GO
CREATE PROCEDURE NOPRODUCTOS 
 @PROD INT
  OUTPUT AS
 SELECT * FROM Products
 SELECT @PROD = @@ROWCOUNT
 RETURN(0)
 GO

DECLARE	@PROD int
SELECT	@PROD = 1
EXEC NOPRODUCTOS @PROD = @PROD OUTPUT
SELECT	@PROD as '@PROD'
-----------------------------------------------
--EJEMPLO 3
GO
CREATE PROC SP_AGREGAR_CATEGORIAS
@ID INT,
@NOMBRE VARCHAR(20)
AS
  IF (SELECT COUNT(*) FROM Categoria
	   WHERE CodigoCategoria=@ID OR Descripcion=@NOMBRE) = 0
	     INSERT INTO  Categoria (CodigoCategoria,Descripcion)
		  VALUES (@ID,@NOMBRE)
   ELSE
    PRINT 'ERROR LA CATEGORIA YA EXISTE'
GO

Exec SP_AGREGAR_CATEGORIAS 1,'Alimentos'
Exec SP_AGREGAR_CATEGORIAS 7,'bebidas'
Exec SP_AGREGAR_CATEGORIAS 8,'Alimentos'

select * from Categoria
-----------------------------------------------------
--borrar store procedure

drop procedure SP_AGREGAR_CATEGORIAS
--------------------------------------------
--ejemplo 3
GO
ALTER proc sp_Existeclientes
 @ciudad varchar(15)
 as
  select case(select count(*) from Customers where City=@ciudad)
         when 0 then 'NO HAY CLIENTES EN LA CIUDAD DE:' + SPACE(2) +UPPER(@ciudad)
		  ELSE 'HAY CLIENTES EN LA CIUDAD DE:  '+UPPER(@ciudad)
		  END AS 'MENSAJE'
GO

EXEC sp_Existeclientes 'PIMENTEL'
EXEC sp_Existeclientes 'New York'
EXEC sp_Existeclientes 'Barcelona'

