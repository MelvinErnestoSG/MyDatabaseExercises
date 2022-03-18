--CLASE 6
--Ejercicio 4

--En el siguiente procedimiento se calcula el total de ventas de los pedidos que están almacenados en la tabla Order Details 

create proc Proc_Total
as
	select OrderID, sum(convert(money,(unitprice*Quantity*(1-discount)/100))*100)
	as Total
	  from [Order Details]
	    group by OrderID

--ejecutar
exec Proc_Total 
-------------------------------
--ejercicio 5
--Ahora vamos a alterar o modificar el procedimiento 
--para que reciba como parámetro de entrada una orden o pedido especifico 
create proc Proc_TotalID
@ID int
as
	select OrderID, sum(convert(money,(unitprice*Quantity*(1-discount)/100))*100)
	as Total
	  from [Order Details]
	where OrderID=@ID
	    group by OrderID

exec Proc_TotalID 10248
-----------------------------------
--ejercicio 6
--Se puede modificar el procedimiento de la siguiente manera,
-- en donde se muestra un mensaje indicando que no existe esa orden 
create proc Proc_TotalIDMensaje
@ID int
as
	declare @total int 
	select @total = COUNT(orderid) from [Order Details] where OrderID=@id
	  if @total >=1 
	    begin
			select OrderID, sum(convert(money,(unitprice*Quantity*(1-discount)/100))*100) as Total
			  from [Order Details]
				where OrderID=@ID
				    group by OrderID		
		end
		  else
			begin
				print 'El numero de orden no existe, y su codigo es:  '+convert(varchar(10),@id)
			end
------------------------------------------
	exec Proc_TotalIDMensaje 10000
