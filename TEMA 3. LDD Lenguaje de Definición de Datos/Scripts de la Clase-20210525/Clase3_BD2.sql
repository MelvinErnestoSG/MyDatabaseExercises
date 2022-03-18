--Clase No.3
--FULL JOIN

SELECT C.CustomerID,O.OrderID FROM Customers  C FULL JOIN ORDERS  AS O 
  ON C.CustomerID= O.CustomerID

--- CROSS JOIN 
SELECT COUNT(*) FROM Suppliers
SELECT COUNT(*) FROM Products

SELECT  P.PRODUCTNAME,S.CompanyName, ContactName FROM Products  AS P
  CROSS JOIN  Suppliers AS s
-----------------------------------------------
-- UNION
GO
CREATE VIEW VISTA_CLIENTESPROVEEDORES   --CREACION DE VISTA
AS
SELECT P.ContactName,P.CompanyName,P.Country,'Proveedor' as Proveedor FROM Suppliers AS p
UNION 
SELECT C.ContactName,C.CompanyName,C.Country, 'Cliente' as Cliente FROM Customers  AS C
GO
-----------------------------------------------------------
SELECT CompanyName FROM VISTA_CLIENTESPROVEEDORES WHERE Country='japan'
----------------------------------------------------------
--Subconsultas...
--1-- Listado de categorias..y la cantidad productos relacionados.
Select 
    c.CategoryID as CodCateg, c.CategoryName as NombreCat,
	(select count(P.ProductID) from Products as P where P.CategoryID=c.CategoryID) as TotalProductos
 from Categories as C

--2... Productos y cantidad de categorias.
select P.ProductID, p.ProductName as Producto,
(select count(c.CategoryID) from Categories as c where P.CategoryID=c.CategoryID) as CantidadCategorias
from Products as P
------------------------------------
---3... Obtener empleados y cantidad ordenes por ano xx..
select e.EmployeeID as CODIGO, (E.FirstName + ' '+ e.LastName) as Empleado from Employees as E
-----------------------------------------------------------
select e.EmployeeID as CODIGO, Empleado = (E.FirstName + ' '+ e.LastName)  from Employees as E
------------------------------------------------------------
select e.EmployeeID as CODIGO, (E.FirstName +SPACE(1)+ e.LastName) as Empleado, e.Address as 'Direccion',
(select count(o.OrderID)  from orders as O   
	where O.EmployeeID=E.EmployeeID and YEAR(O.OrderDate) =1997) as CantidadOrdenes 
from Employees as E
GO
---------------------------------------------------------------
--4. ---Listado de empleados y el monto total generado por cada orden y la cantidad de cada uno.
--a) Cantidad de orden
select count(O.OrderID) from Orders as O where O.EmployeeID =1  and YEAR(o.OrderDate)=1996

--b) --- Monto total de cada orden del empleado 1
select sum(O.Freight) from orders as O where O.EmployeeID =1 and year(o.OrderDate)=1996

--C) --- Incluir las subconsultas al reporte.
Select  e.EmployeeID as CODIGO, (E.FirstName +SPACE(1)+ e.LastName) as Empleado,
(select count(O.OrderID) from Orders as O where O.EmployeeID=E.EmployeeID and YEAR(o.OrderDate)=1996) as 'Cantidad Ordenes',
(select sum(O.Freight) from orders as O where O.EmployeeID=E.EmployeeID and year(o.OrderDate)=1996) as 'MontoTotal'
 from Employees as E 
---------------------------------------------

