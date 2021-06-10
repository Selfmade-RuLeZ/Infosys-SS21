CREATE DATABASE mydb
GO
USE mydb
GO
CREATE TABLE Products (ID int, ProductName nvarchar(max))
GO
INSERT INTO Products (ID, ProductName) VALUES(1, "testname")
INSERT INTO Products (ID, ProductName) VALUES(2, "test")
GO
select * from Products
GO
