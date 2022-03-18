USE AdventureWorks2017

GO

--1. crear una Consulta para encontrar empleados que tienen m�s vacaciones disponibles que el promedio, en la tabla HumanResources.Employee.

 SELECT * FROM HumanResources.Employee

 SELECT JobTitle AS Empleados, VacationHours AS HorasVacaciones
 FROM HumanResources.Employee 
 WHERE VacationHours > 25
 
--2. Se Quiere saber cu�l de los empleados tienen m�s horas de vacaciones que el promedio para su puesto de trabajo. 
--Tabla HumanResources.Employee.

 SELECT MAX (VacationHours) 
 FROM HumanResources.Employee 
 
--3. Conocer qu� empleados ten�an sus PAY RATES modificadas en 2010, tablas HumanResources.Employee y HumanResources.EmployeePayHistory

 SELECT * FROM HumanResources.Employee

 SELECT HireDate AS Varios_Emplados_CON_Pay_Rates
 FROM HumanResources.Employee 
 WHERE HireDate like '%2010%'

 SELECT * FROM HumanResources.EmployeePayHistory

 SELECT Rate AS Un_Emplados_CON_Pay_Rates
 FROM HumanResources.EmployeePayHistory 
 WHERE ModifiedDate like '%2010%'

--4. Obtener la Suma de las ventas hechas por cada empleado, y agrupadas por a�o. (SalesPersonQuotaHistory y Person.Person)

  SELECT p.FirstName AS Nombres, SUM(SalesQuota) AS Total_Vendidos,
  YEAR(QuotaDate) AS a�o
  FROM Sales.SalesPersonQuotaHistory qh
  INNER JOIN Person.Person p
  ON qh.BusinessEntityID = p.BusinessEntityID
  GROUP BY p.BusinessEntityID, YEAR(QuotaDate), p.FirstName
  ORDER BY p.BusinessEntityID
 
--5. Obtener el producto m�s vendido. (Production.Product y Sales.SalesOrderDetail).

  SELECT top 1 p.ProductID, p.Name AS Producto, COUNT(s.ProductID) AS Veces_Vendidos
  FROM Production.Product p
  INNER JOIN Sales.SalesOrderDetail s
  ON p.ProductID = s.ProductID
  GROUP BY s.ProductID, p.Name, p.ProductID
  ORDER BY COUNT(s.ProductID) DESC

--6. Obtener los empleados que son del estado de Gironde. (Person.Person, Person.BusinessEntityAddress, Person.Address, Person.StateProvince)

  SELECT p.*,ps.Name FROM HumanResources.Employee he
  INNER JOIN Person.Person p
  ON p.BusinessEntityID = he.BusinessEntityID
  INNER JOIN Person.BusinessEntityAddress pb 
  ON pb.BusinessEntityID = p.BusinessEntityID
  INNER JOIN Person.Address pa
  ON pa.AddressID = pb.AddressID
  INNER JOIN Person.StateProvince ps
  ON ps.StateProvinceID = pa.StateProvinceID
  and ps.Name = 'Gironde'