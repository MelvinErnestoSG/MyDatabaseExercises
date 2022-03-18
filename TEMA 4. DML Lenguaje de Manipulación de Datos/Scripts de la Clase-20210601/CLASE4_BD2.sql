--CLASE NO. 4
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT E.EmployeeID, (SELECT COUNT(*) FROM [Order Details] AS OD WHERE OD.OrderID=O.OrderID) FROM Employees AS E
  INNER JOIN ORDERS AS O ON O.EmployeeID=E.EmployeeID 
  INNER JOIN [Order Details] AS D ON D.OrderID =O.OrderID

 ----------------------
 --SUBCONSULTAS.
 --1...OBTENER LAS ORDENES DONDE SE VENDIERON LOS PRODUCTOS DEL PROVEEDOR LLAMADO YOKYO TRAADERS.

--A.. 
SELECT s.SupplierID FROM Suppliers AS S WHERE S.CompanyName='Tokyo traders'
--B
select p.ProductID from Products as P where p.SupplierID = (select s.SupplierID from Suppliers as S where s.CompanyName ='tokyo traders')
GO

--2  obtener los productos del proveedor tokyo traders (9,10,74) 
--obtener aquellos ordenes en las que se vendieron dichos productos.
select O.OrderID as 'NoOrden', od.ProductID as 'CodPro', p.ProductName as 'Producto',
  P.UnitPrice as 'Precio', Od.Quantity as 'Cant', format(o.OrderDate,'dd/mm/yyyy') as 'FechaOrden',s.CompanyName
    from [Order Details] as OD
  inner join orders as O on o.OrderID=OD.OrderID
  inner join Products as p on p.ProductID=OD.ProductID
   inner join Suppliers as S on s.SupplierID=p.SupplierID
    where P.ProductID in (select p.ProductID from Products as p 
	   where P.SupplierID = (select s.SupplierID from Suppliers as S where s.CompanyName='tokyo traders'))
	GO
   --------------------------------------
--Mostrar los productos con cantidades mayores a 100..
  select  p.ProductID,p.ProductName,UnitPrice
    from Products as P 
	   where ProductID in (select ProductID from [Order Details] where Quantity >=100) order by ProductName
-----------------------------------------------------------------------------------------------------------
--mismo ejemplo con EXISTS...
select p.ProductID, p.ProductName,UnitPrice from Products as P
  where Exists (select ProductID  from [Order Details] as OD where OD.Quantity>=100
    and P.ProductID=Od.ProductID) order by ProductName
-----------------------------------------------------------------
---Funciones
--DateDiff

set dateformat dmy
declare @fechainicial date='01-01-2021'
--declare @fechafinal date='01-06-2021'
declare @fechafinal date=getdate()
select DATEDIFF(day,@fechainicial,@fechafinal) as 'dias'
---------------
select DATENAME(month,getdate()) as 'MES'
-------------------------
Declare @cadena varchar(40)
select @cadena = '   base DE DATOS AVANZADO'
select LEFT(upper(LTRIM(@cadena)),4) as 'REsultado'
----------------
GO
create function ConvierteMayusculas
(
@Nombre varchar(50),
@apellido varchar(50)
)
returns varchar (100)
as 
 begin
	Return (upper(@nombre) + ' '+upper(@apellido))
 end
 GO
 ---------------------------
 --ejecutar funcion
 print dbo.ConvierteMayusculas('jose','gonzalez')
 --------------------------------------------
 GO
create function ventasProductos (@Idprod varchar(10))
 returns table
 as
   return (select sum(Od.UnitPrice*od.Quantity) as VentasBrutas from [Order Details] as OD
     where Od.ProductID=@Idprod)
     GO
---------------------
GO
alter function ventasProductos (@Idprod varchar(10))
 returns table
 as
   return (select sum(Od.UnitPrice*od.Quantity) as VentasBrutas from [Order Details] as OD
     where Od.ProductID=@Idprod)
	 GO
select * from Northwind.dbo.ventasProductos(1)
------------------------------------------------------
GO
create function SumarValores
(
@valor1 decimal(5,2),
@valor2 decimal(5,2)
) returns decimal(5,2)
as 
begin
	declare @resultado decimal(5,2)
	set @resultado=@valor1 + @valor2
   return @resultado
end
GO
select dbo.sumarvalores(1.5,1.5)
