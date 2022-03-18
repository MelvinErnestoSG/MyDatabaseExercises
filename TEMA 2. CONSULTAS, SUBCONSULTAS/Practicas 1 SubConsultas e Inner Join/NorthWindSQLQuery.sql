USE Northwind

GO

--1. lista de clientes que han pedido más de 20 unidades del producto número 23.

 SELECT * FROM Orders
 SELECT * FROM Customers

 SELECT o.OrderID, c.CustomerID, c.CompanyName
 FROM Orders AS O
 INNER JOIN Customers AS C 
 ON o.CustomerID = c.CustomerID
 WHERE o.CustomerID IS NOT NULL

--2. lista de productos y el pedido mayor realizado hasta la fecha de cada producto de la tabla Order Details. 

 SELECT * FROM Products
 SELECT * FROM [Order Details]

 SELECT P.ProductID, P.ProductName, UnitsOnOrder
 FROM Products AS P
 WHERE ProductID in (SELECT ProductID FROM [Order Details]
 WHERE Quantity > 0)
 ORDER BY ProductName
