--Procedimientos almacenados (usando DB Northwind)

USE Northwind

DECLARE @Promedio INT	
DECLARE @CantOrdenes INT
DECLARE @CantEmpleado INT
DECLARE @Comisión MONEY

SET @CantOrdenes = (SELECT COUNT(o.OrderID) FROM Orders o WHERE YEAR(o.OrderDate) = 1997)
SET @CantEmpleado = (SELECT COUNT(*) FROM Employees)
SET @Promedio = (@CantOrdenes/@CantEmpleado)

IF(@CantOrdenes > @Promedio)
	BEGIN
		SET @Comisión = 0.25
	END
ELSE
	BEGIN
		SET @Comisión = 0.10
	END

SELECT
	o.EmployeeID AS IdEmpleado,
	e.FirstName AS [Primer Nombre],
	COUNT(o.OrderID) AS [Cantidad de Órdenes],
	SUM(od.UnitPrice) AS [Recaudación],
	SUM(od.UnitPrice * @Comisión) AS Comisión
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY o.EmployeeID, e.FirstName