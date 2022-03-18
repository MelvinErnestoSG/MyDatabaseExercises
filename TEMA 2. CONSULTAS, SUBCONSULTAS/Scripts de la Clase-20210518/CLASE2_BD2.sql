--Clase No. 2
--CASE WHEN THEN ELSE END
declare @Dato int, @MES varchar(25)
set @Dato=5
set @MES = (Case @Dato
			when 1 then 'ENERO'
			WHEN 2 THEN 'FEB'
			WHEN 3 THEN 'MAR'
			WHEN 4 THEN 'ABR'
			WHEN 5 THEN 'MAY'
			ELSE 'EL MES NO ES VALIDO'
			END)
PRINT @MES	

----------------------------------------------------
SELECT EmployeeID, MaritalStatus,(CASE MaritalStatus
								WHEN 'M' THEN 'CASADO'	ELSE 'SOLTERO' END) AS ESTADO
 FROM	HumanResources.Employee 
-------------------------------------------------------------------------------------

DECLARE @STOCK INT
SET @STOCK=50
SELECT P.ProductName, UnitPrice, UnitsInStock,
'ESTADO' =(CASE WHEN P.UnitsInStock >@STOCK THEN 'EXCELENTE'
			WHEN UnitsInStock <@STOCK THEN 'BAJO' END)
FROM Products AS P
-----------------------------------------------------------
--SENTENCIA IF
DECLARE @IDCUST VARCHAR(10),@CANTIDAD INT
SET @IDCUST='TOMSP'

SELECT @CANTIDAD=COUNT(*) FROM Orders WHERE CustomerID=@IDCUST
 IF @CANTIDAD = 0 PRINT 'EL EMPLEADO ES INEFICIENTE'
   ELSE IF @CANTIDAD = 1 PRINT 'EL EMPLEADO ES REGULAR'
		ELSE PRINT 'EL EMPLEADO EXCELENTE'
--------------------------------------------------------------
--INNER JOIN

SELECT * FROM ORDERS
SELECT * FROM Customers

SELECT O.OrderID,C.CustomerID,C.CompanyName  FROM ORDERS  AS O INNER JOIN Customers AS C ON O.CustomerID=C.CustomerID
---------------------------------------------------------------------------------------------------------------------

-----OBTENER CLIENTES SIN PEDIDOS
SELECT C.CustomerID,C.CompanyName  FROM ORDERS  AS O FULL JOIN Customers AS C ON O.CustomerID = C.CustomerID WHERE O.OrderID IS NULL 
------------------------------------------------------------------------------------------------------------------------------------
Select OrderID,P.ProductID,P.ProductName 
From Products as P
INNER JOIN [Order Details] AS OD
ON P.ProductID =OD.ProductID
-----------------------------------------

--EJEMPLO 3: Se desea conocer los empleados que han atendido una orden
-- y en qué fecha lo hicieron, los registros se deben ordenar por el campo EmployeeID 
SELECT LastName,Employees.EmployeeID,OrderDate FROM Orders 
INNER JOIN Employees
ON ORDERS.EmployeeID =Employees.EmployeeID
ORDER BY Employees.EmployeeID 
----------------------------------------------------------

---LEFT JOIN
SELECT OrderID, C.CustomerID, CompanyName, OrderDate 
FROM Customers C LEFT JOIN Orders O ON C.CustomerID = O.CustomerID 
------------------------------------------------------------------

--RIGHT JOIN
SELECT OrderID, C.CustomerID, CompanyName, OrderDate FROM Customers C RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID 
------------------------------------------------------------------------------------------------------------------------

--FULL JOIN
SELECT OrderID, C.CustomerID, CompanyName, OrderDate FROM Customers C FULL JOIN Orders O ON C.CustomerID = O.CustomerID 
-----------------------------------------------------------------------------------------------------------------------
