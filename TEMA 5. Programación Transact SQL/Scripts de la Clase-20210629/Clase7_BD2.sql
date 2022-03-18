--clase 7
--tablas temporales..

--crear
create table #TablaTemporal (ID int, nombre varchar(20))
GO

--insert datos
insert into #TablaTemporal values (1,'Pedro')
insert into #TablaTemporal values (1,'Juan')

select * from #TablaTemporal

----------------------------------------------
--ejemplo primary key

create table #TablaPrimaria (id int primary key,nombre varchar(20))
insert into #TablaPrimaria values (1,'Jose')
insert into #TablaPrimaria values (1,'Maria')

select * from #TablaPrimaria
-----------------------------------------------

--variables de tabla..
declare @variableTabla table (Id int, Nombre varchar(20))

insert into @variableTabla values (1,'Pedro')
insert into @variableTabla values (2,'Maria')

select * from @variableTabla
----------------------------------------------
--ejemplo:

--Vamos a utilizar la base de datos Northwind.
--En esta base de datos los pedidos se envían a través de tres compañías de transportes: 
--Speedy Express(1), United Package(2) y Federal Shipping(3). 
--La compañía Federal Shipping nos oferta realizar todos los envíos 
--que hacemos a través de United Package al precio fijo de 10$.
--Decidimos que este ahorro merece la pena y vamos a cambiar en nuestra base de datos 
--todos los pedidos abiertos que tienen que ser enviados por United Package para 
--que sean enviados a través de Federal Shipping.
--Para hacer esta actualización de los datos tenemos varias opciones. Vamos a comparar tres formas de hacerlo.

--Metodo 1  --tablas temporales
declare @st datetime
set @st = GETDATE()
 create table #Actualizar(OrderId int,ShipVia Int, Freight Money)
   insert into #Actualizar select orderid, Shipvia, Freight from Orders 
	where ShipVia=3 and ShippedDate is null
	   update orders set ShipVia=3, Freight=10 where OrderID in 
	     (select OrderID from #Actualizar) drop table #Actualizar
		print 'Operaciones Completada en: '+ rtrim(cast(datediff(ms,@st,getdate()) as char(10))) + ' Milisegundos'
-- resultado: 17 rows , 23 milisegundos

--Metodo 2, Variables de tabla.
declare @st datetime
set @st=GETDATE()
declare @Actualizar table(OrderId int,ShipVia int, Freight money)
insert into @Actualizar select OrderID,ShipVia,Freight from Orders
  where ShipVia=3 and  ShippedDate is null
  update orders set ShipVia=3, Freight=10 where OrderID in 
	     (select OrderID from @Actualizar) 
		print 'Operaciones Completada en: '+ rtrim(cast(datediff(ms,@st,getdate()) as char(10))) + ' Milisegundos'
-- resultado: 17 rows , 3 milisegundos

---Ejemplo sin tablas temporables...
declare @st datetime
set @st = GETDATE()
UPDATE Orders SET ShipVia=3, Freight=10 WHERE OrderID IN   
	(SELECT OrderID FROM Orders WHERE ShipVia=2 AND ShippedDate IS NULL)
PRINT 'Operacion completada en: '   + rtrim(cast(datediff(ms,@st,getdate()) AS char(10)))   
	+ ' milisegundos'
-- resultado: 0 rows , 6 milisegundos