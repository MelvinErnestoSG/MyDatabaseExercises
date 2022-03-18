--Clase 8
--Triggers
---crear un trigger modifica clientes

GO
 if object_id('Customers') is not null
  drop table Customers

CREATE TABLE Customers(
   CustomerID INT,
   ContactName VARCHAR (20),
   ADDRESS CHAR (25) ,
   SALARY DECIMAL (18, 2)
   PRIMARY KEY (CustomerID)
)

GO
create trigger ModificaClientes
on customers for update as
print 'SE HAN MODIFICADO INFORMACION EN LA TABLA CLIENTES'

--------------------------------------
SELECT * FROM Customers
UPDATE Customers SET ContactName='EURY' WHERE CustomerID='ALFKI'

-------------------------
--BORRAR
DROP TRIGGER ModificaClientes
-------------------------
 if object_id('PASAJERO') is not null
  drop table PASAJERO;

--MOSTRAR UN MENSAJE CADA QUE VEZ QUE SE INSERTE O ACTUALICE UN REGISTRO EN LA TABLA PASAJERO.
/*CREATE TABLE PASAJERO(
	idpasajero char(8) NOT NULL,
	nombre varchar(20) NOT NULL,
	apaterno varchar(20) NOT NULL,
	amaterno varchar(20) NOT NULL,
	tipo_documento varchar(30) NOT NULL,
	num_documento varchar(12) NOT NULL,
	fecha_nacimiento date NOT NULL,
	idpais char(4) NOT NULL,
	telefono varchar(15) NULL,
	email varchar(50) NOT NULL,
	clave varchar(20) NOT NULL,
)*/

/*GO
CREATE TRIGGER TGMensajePasajero
on pasajero 
for insert, update
  as
    print 'Pasajero actualizado'*/

CREATE TABLE PASAJERO(
	idpasajero char(8) NOT NULL,
	nombre varchar(20) NOT NULL,
	apaterno varchar(20) NOT NULL,
	amaterno varchar(20) NOT NULL,
	tipo_documento varchar(30) NOT NULL,
	num_documento varchar(12) NOT NULL,
	fecha_nacimiento date NOT NULL,
	idpais char(4) NOT NULL,
	telefono varchar(15) NULL,
	email varchar(50) NOT NULL,
	clave varchar(20) NOT NULL,
)
	
select * from PASAJERO

--probar
update PASAJERO set nombre='Juan'
 where num_documento='47715777'
 
insert into PASAJERO values('P0000009','Pedro','Gonzalez','Acosta','DNI',12345,'2000-01-01','0001',131231,'eury123@hotmail.com','123')

-------------------------------
--ejemplo 3
--Implementar un trigger que permita crear una replica de los registros 
--insertados en la tabla avion para dicho proceso implementar una nueva tabla 
--llamada avionBAK con las mismas columnas de la tabla avion.

CREATE TABLE AVION(
	idavion char(5) NOT NULL,
	idaerolinea int NOT NULL,
	fabricante varchar(40) NULL,
	tipo varchar(30) NOT NULL,
	capacidad int NOT NULL,
)

select * from AVION

--------------
if OBJECT_ID ('AvionBak') is not null
 begin
	drop table AvionBAK
 end

CREATE TABLE AEROLINEA(
	idaerolinea int NOT NULL,
	ruc char(11) NOT NULL,
	nombre varchar(40) NOT NULL,
)
--crear la tabla AvionBak
create table AvionBak
(	
idavion char(5),
/*IdAerolinea int constraint FK_AVION_AEROLINEA foreign key (idaerolinea) references AEROLINEA (idaerolinea),*/
IdAerolinea int,
Fabricante varchar(40) null,
Tipo varchar(30) not null,
Capacidad int not null,
)
GO
------
if OBJECT_ID ('replicacionAvion') is not null
 begin
	drop trigger replicacionAvion
 end

 if object_id('AVION') is not null
  drop table AVION;

CREATE TABLE AVION(
	idavion char(5) NOT NULL,
	idaerolinea int NOT NULL,
	fabricante varchar(40) NULL,
	tipo varchar(30) NOT NULL,
	capacidad int NOT NULL,
)
 if object_id('AEROLINEA') is not null
  drop table AEROLINEA;

CREATE TABLE AEROLINEA(
	idaerolinea int NOT NULL,
	ruc char(11) NOT NULL,
	nombre varchar(40) NOT NULL,
)
GO
create trigger replicacionAvion
on avion
after insert
as
  begin
	--insert AvionBak 
	select * from inserted
  end
  
    --probar

	insert into AVION values(5,2,'datos','prueba',250)

select * from AVION
select * from AEROLINEA
---------------------------------
--ejemplo 3
--Implementar un trigger que permita controlar el registro de un pago, 
--se deberá evaluar que el monto a registrar sea mayor que cero en la columna monto de la tabla pago.
--
---Evaluamos si ya existe nuestro trigger

--si ya existe lo eliminamos para implementarlo

--nuevamente

If object_id('validapago') is not null

begin

     drop trigger validapago
end
GO

 if object_id('PAGO') is not null
  drop table PAGO;

CREATE TABLE PAGO(
	idpago int IDENTITY(1,1) NOT NULL,
	idreserva int NOT NULL,
	fecha date NULL DEFAULT (getdate()),
	idpasajero char(8) NOT NULL,
	monto money NOT NULL,
	tipo_comprobante varchar(20) NOT NULL,
	num_comprobante varchar(15) NOT NULL,
	impuesto decimal(5, 2) NOT NULL,
)
GO
----Creamos nuestro trigger
CREATE TRIGGER validapago
ON pago
--El desencadenador se activará cuando
--la operación Insert sea correcta
FOR INSERT
--Instrucciones del desencadenador
AS
     IF (select monto from inserted)<=0
     BEGIN
           ROLLBACK TRANSACTION
          PRINT 'No puede registrar monto Cero'
     END
     ELSE
          PRINT 'Pago registrado correctamente'
GO

--Probamos la implementación de nuestro trigger
/*insert into pago (idreserva,fecha,idpasajero,monto,tipo_comprobante,
num_comprobante,impuesto) values(1,'2015-09-12','P0000007',0,'Factura',
'0001-00015',0.18)*/

insert into pago (idreserva,fecha,idpasajero,monto,tipo_comprobante,
num_comprobante,impuesto) values(1,'2015-09-12','P0000007',100,'Factura',
'0001-00015',0.18)

select * from PAGO

--ejemplo 4  --auditorias
--Vamos a crear 3 triggers diferentes. 
--Si bien se puede hacer en uno sólo, es más didáctico, 
--y más fácil de manejar, tenerlos separados. Y no tiene ningún coste adicional.

CREATE TABLE tableDatos(
id INT IDENTITY(1, 1) PRIMARY KEY, 
columnaInt INT, 
columnaDateTime DATETIME, 
columnaVarchar  VARCHAR(10), 
columnaFloat    FLOAT
)

if object_id('auditoriaDatos') is not null
  drop table auditoriaDatos

CREATE TABLE auditoriaDatos(
 id                INT, 
 columnaInt        INT, 
 columnaDateTime   DATETIME, 
 columnaVarchar    VARCHAR(10), 
 columnaFloat      FLOAT, 
 fechaInsertModify DATETIME, 
 typeMov           VARCHAR(25)
)

/*GO
CREATE TRIGGER trTableDatos_Delete 
ON tableDatos
AFTER DELETE
AS
     BEGIN
         SET NOCOUNT ON;
         INSERT INTO auditoriaDatos
                SELECT *, 
                       GETDATE(), 
                       'Delete'
                FROM deleted;
     END;*/

/*GO
CREATE TRIGGER trTableDatos_Update 
ON tableDatos
AFTER UPDATE
AS
     BEGIN
         SET NOCOUNT ON;
         INSERT INTO auditoriaDatos
                SELECT *, 
                       GETDATE(), 
                       'Before Update'
                FROM deleted;
         INSERT INTO auditoriaDatos
                SELECT *, 
                       GETDATE(), 
                       'After Update'
                FROM inserted
     END*/


/*GO
CREATE TRIGGER trTableDatos_Insert
 ON tableDatos
AFTER INSERT
AS
     BEGIN
         SET NOCOUNT ON;
         INSERT INTO auditoriaDatos
                SELECT *, 
                       GETDATE(), 
                       'Insert'
                FROM inserted;
     END;*/
/*GO

INSERT INTO dbo.tableDatos
(columnaInt, 
 columnaDateTime, 
 columnaVarchar, 
 columnaFloat
)
VALUES
(1, '20190130 15:45', 'Primera', 0.5);*/


/*insert into dbo.tableDatos 
(
columnaInt, 
columnaDateTime,
columnaVarchar,
columnaFloat
)
values
(1,'20190130 15:45','Segunda',0.5),
(1,'20190130 15:45','Tercera',0.5),
(1,'20190130 15:45','Cuartaa',0.5),
(1,'20190130 15:45','Quinta',0.5),
(1,'20190130 15:45','Sexta',0.5);*/


/*UPDATE dbo.tableDatos
  SET
      columnaFloat = 1, 
      columnaVarchar = 'Cuarta'
WHERE columnaVarchar = 'Cuartaa';


select * from auditoriaDatos
GO*/