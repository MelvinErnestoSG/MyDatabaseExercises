--Procedimientos almacenados (usando DB AdventureWorks2017)

USE AdventureWorks2017  

GO  

ALTER PROCEDURE HumanResources.uspGetEmployeesTest2   
    @LastName nvarchar(50),   
    @FirstName nvarchar(50)   
AS   

    SET NOCOUNT ON;  
    SELECT FirstName, LastName, Department  
    FROM HumanResources.vEmployeeDepartmentHistory  
    WHERE FirstName = @FirstName AND LastName = @LastName  
    AND EndDate IS NULL 
GO  

EXECUTE HumanResources.uspGetEmployeesTest2 N'Ackerman', N'Pilar'
-- Or  

EXEC HumanResources.uspGetEmployeesTest2 @LastName = N'Ackerman', @FirstName = N'Pilar'
GO  
-- Or  

EXECUTE HumanResources.uspGetEmployeesTest2 @FirstName = N'Pilar', @LastName = N'Ackerman'  
GO  
