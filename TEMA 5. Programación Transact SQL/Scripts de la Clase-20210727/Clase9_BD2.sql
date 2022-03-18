--clase 9

--Por ejemplo queremos obtener las ventas mensuales de nuestros clientes. 
--Tenemos que diseñar una consulta sumaria calculando la suma de los importes de los pedidos agrupando por empleado y mes de la venta.

select *from [Order Details]
select *from Orders

select  O.CustomerID ,MONTH(O.OrderDate) as MES,sum(o.Freight) as Total   from Orders as O
  group by  O.OrderDate, O.CustomerID

  --ejemplo ,tablas de referencia cruzadas, funcion pivot
--Mostrar los pagos realizados por los pasajeros, pero ordenar los pagos por meses.

--Paso 1
Select P.apaterno,P.amaterno, DATENAME(Month,Pg.fecha) as Mes,
  sum(Pg.Monto) as Total
 From PAGO  as Pg 
  inner join PASAJERO as P on p.idpasajero=Pg.idpasajero
    group by  P.apaterno,P.amaterno ,datename(MONTH,Pg.fecha)

--Paso 2
select *from 
(Select P.apaterno,P.amaterno, DATENAME(Month,Pg.fecha) as Mes,
  sum(Pg.Monto) as Total
 From PAGO  as Pg 
  inner join PASAJERO as P on p.idpasajero=Pg.idpasajero
    group by  P.apaterno,P.amaterno ,datename(MONTH,Pg.fecha)
	)T
PIVOT (SUM(t.TOTAL) FOR T.MES IN
  ([January],[february],[marz],[april],[may], [june])) pvt

--PASO NO 3

SELECT
 apaterno,amaterno,
 CASE WHEN january IS NOT NULL THEN January else 0 end as Enero,
 CASE WHEN february IS NOT NULL THEN february else 0 end as Febrero,
 CASE WHEN marz IS NOT NULL THEN marz else 0 end as Marzo
  from 
    (Select P.apaterno,P.amaterno, DATENAME(Month,Pg.fecha) as Mes,
  sum(Pg.Monto) as Total
 From PAGO  as Pg 
  inner join PASAJERO as P on p.idpasajero=Pg.idpasajero
    group by  P.apaterno,P.amaterno ,datename(MONTH,Pg.fecha)
	)T
PIVOT (SUM(t.TOTAL) FOR T.MES IN
  ([January],[february],[marz],[april],[may], [june])) pvt
  GO

--ejemplo 3

--obtener pedidos por clientes y tipo de productos.--

SELECT * FROM
(SELECT c.CustomerID, p.ProductName, od.quantity FROM Customers as c 
INNER JOIN Orders o on c.CustomerID = o.CustomerID 
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID 
INNER JOIN Products p ON od.ProductID = p.ProductID) AS T
PIVOT (SUM(t.quantity) FOR t.productname IN ([Spegesild],[Flotemysost],[Queso Cabrales],[Geitost])) PVT
------------------------------------

--ejemplo 4
--Obtener categorías por ano parte 1

create view VentasCategoria
 as
SELECT dbo.Categories.CategoryName, DATEPART(yyyy,dbo.Orders.OrderDate) as ANO, (dbo.[Order Details].UnitPrice * dbo.[Order Details].Quantity) as TOTAL
FROM   
  dbo.Categories INNER JOIN
                  dbo.Products ON dbo.Categories.CategoryID = dbo.Products.CategoryID INNER JOIN
                  dbo.[Order Details] ON dbo.Products.ProductID = dbo.[Order Details].ProductID INNER JOIN
                  dbo.Orders ON dbo.[Order Details].OrderID = dbo.Orders.OrderID

select * from VentasCategoria
pivot (sum(Total)
 for ano in ([1996])) as pvt

 execute ('select * from VentasCategoria
pivot (sum(Total)
 for ano in ([1996])) as pvt')

 