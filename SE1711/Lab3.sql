--1.Done
--2.
CREATE DATABASE DBLab3
USE DBLab3
--3.
--B1:
CREATE TABLE Customer 
(
	cID int NOT NULL,
	cName varchar(25),
	cAge tinyint,
	cGender bit
)

CREATE TABLE Orders
(
	oID int NOT NULL,
	cID int,
	oDate date
)

CREATE TABLE Product
(
	pID int NOT NULL,
	pName varchar(25),
	pPrice int
)

CREATE TABLE OrderDetail
(
	oID int,
	pID int,
	odQTY int
)
--B2:
--PK:
ALTER TABLE Customer ADD CONSTRAINT PK_cID PRIMARY KEY(cID)
ALTER TABLE Orders ADD CONSTRAINT PK_oID PRIMARY KEY(oID)
ALTER TABLE Product ADD CONSTRAINT PK_pID PRIMARY KEY(pID)
--FK:
ALTER TABLE Orders ADD CONSTRAINT FK_cID_Customer FOREIGN KEY(cID) REFERENCES Customer(cID)
ALTER TABLE OrderDetail ADD CONSTRAINT FK_oID_Orders FOREIGN KEY(oID) REFERENCES Orders(oID)
ALTER TABLE OrderDetail ADD CONSTRAINT FK_pID_Product FOREIGN KEY(pID) REFERENCES Product(pID)

--B3:
INSERT INTO Customer VALUES (1, 'Elisa Cuthbert', 26, 0)
INSERT INTO Customer VALUES (2, 'Cristiano Ronaldo', 23, 1)
INSERT INTO Customer VALUES (3, 'Gemma Atkinson', 24, 0)
INSERT INTO Customer VALUES (4, 'Maria Sharapova', 22, NULL)


INSERT INTO Orders VALUES (1, 1, '2008-3-21')
INSERT INTO Orders VALUES (2, 2, '2008-3-23')
INSERT INTO Orders VALUES (3, 1, '2008-3-16')

INSERT INTO Product VALUES (1, 'Washing Machine', 3)
INSERT INTO Product VALUES (2, 'Fridge', 5)
INSERT INTO Product VALUES (3, 'Air Conditioner', 7)
INSERT INTO Product VALUES (4, 'Electric Fan', 1)
INSERT INTO Product VALUES (5, 'Electric Cooker', 2)

INSERT INTO OrderDetail VALUES (1, 1, 3)
INSERT INTO OrderDetail VALUES (1, 3, 7)
INSERT INTO OrderDetail VALUES (1, 4, 2)
INSERT INTO OrderDetail VALUES (2, 1, 1)
INSERT INTO OrderDetail VALUES (3, 1, 8)
INSERT INTO OrderDetail VALUES (2, 5, 4)
INSERT INTO OrderDetail VALUES (2, 3, 3)

SELECT * FROM Customer
SELECT * FROM Orders
SELECT * FROM Product
SELECT * FROM OrderDetail

--4.
SELECT o.oID, o.cID, od.pID, o.oDate, od.odQTY FROM Orders o FULL JOIN OrderDetail od
		 ON o.oID = od.oID
		 ORDER BY o.oDate

--5.
SELECT c.cName, LEFT(c.cName, 1) AS [Kí tự đầu tiên của tên] FROM Customer c

--6.
SELECT TOP(1) WITH TIES * FROM Product 
		  ORDER BY pPrice DESC

--7.
SELECT TOP(1) WITH TIES * FROM Product 
		  ORDER BY pPrice 

--8.
SELECT CONCAT ('Price of ',CONVERT(varchar, pName), ' is ', CONVERT(int, pPrice)) AS [Mẫu iu cầu]  FROM Product

--9.

SELECT TOP(3) WITH TIES *  INTO Top3Product FROM Product
		 ORDER BY pPrice DESC

SELECT * FROM Top3Product

--10.
SELECT * FROM Customer WHERE cName LIKE '_______________'

--11.
SELECT * FROM Product WHERE pName LIKE '%Electric%'

--12.
SELECT DATEADD(MINUTE, 5000, GETDATE())

--13.
ALTER TABLE Orders DROP CONSTRAINT FK_cID_Customer 
ALTER TABLE OrderDetail DROP CONSTRAINT FK_oID_Orders 
ALTER TABLE OrderDetail DROP CONSTRAINT FK_pID_Product 

--14.
ALTER TABLE Customer DROP CONSTRAINT PK_cID 
ALTER TABLE Orders DROP CONSTRAINT PK_oID 
ALTER TABLE Product DROP CONSTRAINT PK_pID 

--15.
DROP TABLE Customer 
DROP TABLE Orders 
DROP TABLE Product
DROP TABLE OrderDetail 

--16.
DROP DATABASE DBLab3