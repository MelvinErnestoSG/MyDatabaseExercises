--Procedimientos almacenados (usando DB Northwind)

USE Northwind

DECLARE @Promedio INT	
DECLARE @CantOrdenes INT
DECLARE @CantEmpleado INT
DECLARE @Comisi�n MONEY

SET @CantOrdenes = (SELECT COUNT(o.OrderID) FROM Orders o WHERE YEAR(o.OrderDate) = 1997)
SET @CantEmpleado = (SELECT COUNT(*) FROM Employees)
SET @Promedio = (@CantOrdenes/@CantEmpleado)

IF(@CantOrdenes > @Promedio)
	BEGIN
		SET @Comisi�n = 0.25
	END
ELSE
	BEGIN
		SET @Comisi�n = 0.10
	END

SELECT
	o.EmployeeID AS IdEmpleado,
	e.FirstName AS [Primer Nombre],
	COUNT(o.OrderID) AS [Cantidad de �rdenes],
	SUM(od.UnitPrice) AS [Recaudaci�n],
	SUM(od.UnitPrice * @Comisi�n) AS Comisi�n
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY o.EmployeeID, e.FirstName