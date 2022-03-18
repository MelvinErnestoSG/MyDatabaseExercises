--CLASE NO. 1
--SENTENCIA INSERT

Create DATABASE EjemploBD2

use EjemploBD2

--Categoria
create table Categoria
(
CodigoCategoria int primary key,
Descripcion varchar(20),
)

--Producto
create table Producto
(
CodigoProducto int not null,
NombreProducto varchar(20),
Precio decimal(18,2),
CodigoCategoria int
CONSTRAINT PK_Producto PRIMARY KEY (CodigoProducto)
CONSTRAINT fk_Categoria FOREIGN KEY  (CodigoCategoria) references categoria (CodigoCategoria)	
)

Go

-----------------------------------------
--Ejemplo 1
insert into Categoria Values (1,'Comidas')

-------------------------------------------------------------------------
--ejemplo 2
Insert into Categoria (CodigoCategoria,Descripcion) Values (2,'Bebidas')
Insert into Categoria (Descripcion,CodigoCategoria) Values ('Arroz',3)

--------------------------------------------------------------------------
--Ejemplo 3
Insert into Categoria (CodigoCategoria,Descripcion) Values (4,'Refrescos') 
Insert into Categoria (CodigoCategoria,Descripcion) Values (5,'Frutas')
Insert into Categoria (CodigoCategoria,Descripcion) Values (6,'Vegetales')

Select * from Categoria

---------------------------
--ejemplo 4
insert into Producto Values	
(1, 'Soda Coca Cola', 1.25,1),
(2, 'Carne bistec',3.50,2),
(3, 'Camarones pequeños',1.15,6),
(4, 'Harina blanca',0.75,3),
(5, 'Te verde',1.0,1),
(6, 'Lomo de aguja',4.50,2),
(7, 'Soda de naranja',1.25,1),
(8, 'Chiles verdes',0.25,4),
(9, 'Tomates',0.2,4),
(10, 'Manzana verde',0.25,5)

select * from Producto

insert into Producto Values	
(11, 'Mango', 1.25,7)
---------------------------------------------------
--sentencia Update 
--ejemplo 5

select * from Producto

update Producto set Precio=10 where CodigoProducto=1

--ejemplo 6
update Producto set Precio=20 where CodigoCategoria=2 or CodigoProducto=1

--ejemplo 7
update Producto set Precio=30 where CodigoCategoria=2 AND CodigoProducto=2

--------DELETE---------
 --EJEMPLO 7
 DELETE FROM Producto WHERE CodigoCategoria=1

 ---ON DELETE CASCADE Y ON DELETE UPDATE CASCADE
 --ELIMINAR LA RELACION ENTRE TABLAS
 ALTER TABLE PRODUCTO
 drop CONSTRAINT fk_Categoria
---------------------------------------------------------------------

  ALTER TABLE PRODUCTO
 ADD CONSTRAINT FK_CATEGORIA
 FOREIGN KEY  (CodigoCategoria) References categoria (CodigoCategoria)
 on DELETE cascade
 on update cascade

 ---------------------------------------------------------------------
 select * from Categoria
 select * from Producto

 DELETE FROM Categoria WHERE CodigoCategoria=2

