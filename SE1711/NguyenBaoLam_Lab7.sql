--1.Done
--2.
CREATE DATABASE DBLab7
USE DBLab7
--3.
CREATE TABLE Customer
(
	CustomerID int not null,
	Name varchar(30),
	Birth date,
	Gender bit
)
ALTER TABLE Customer ADD CONSTRAINT PK_CustomerID PRIMARY KEY(CustomerID)

insert Customer values
	(1,'Jonny Owen', '10/10/1980', 1),
	(2,'Christina Tiny', '03/10/1989', 0),
	(3,'Garry Kelley', '03/16/1990', null),
	(4,'Tammy Beckham', '05/17/1980', 0),
	(5,'David Phantom', '12/30/1987', 1);
	
SELECT * FROM Customer

CREATE TABLE Product
(
	ProductID int not null,
	Name varchar(30),
	Pdesc text,
	Pimage varchar(200),
	Pstatus bit
)
ALTER TABLE Product ADD CONSTRAINT PK_ProductID PRIMARY KEY(ProductID)

insert Product values 
	(1, 'Nokia N90', 'Mobile Nokia', 'image1.jpg', 1),
	(2, 'HP DV6000', 'Laptop', 'image2.jpg', null),
	(3, 'HP DV2000', 'Laptop', 'image3.jpg', 1),
	(4, 'SamSung G488', 'Mobile SamSung', 'image4.jpg', 0),
	(5, 'LCD Plasma', 'TV LCD', 'image5.jpg', 0);

SELECT * FROM Product	

CREATE TABLE Comment
(
	ComID int not null identity(1, 1),
	ProductID int,
	CustomerID int,
	Date datetime,
	Title varchar(200),
	Content text,
	Status bit
)

ALTER TABLE Comment ADD 
		CONSTRAINT PK_ComID PRIMARY KEY(ComID),
		CONSTRAINT FK_ProductID FOREIGN KEY(ProductID) REFERENCES Product(ProductID),
		CONSTRAINT FK_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
		CONSTRAINT DF_Date DEFAULT (GETDATE()) FOR Date
	
INSERT Comment(ProductID, CustomerID, Date, Title, Content, Status) values
	(1, 1, '03/15/09', 'Hot product', null, 1),
	(2, 2, '03/14/09', 'Hot price', 'Very much', 0),
	(3, 2, '03/20/09', 'Cheapest', 'Unlimited', 0),
	(4, 2, '04/16/09', 'Sale off', '50%', 1);

SELECT * FROM Comment

ALTER TABLE Product ADD CONSTRAINT Un_Pimage UNIQUE(Pimage);

--4.
SELECT * FROM Product
	WHERE Pstatus IS NULL OR Pstatus = 0

--5.
SELECT * FROM Product 
	WHERE ProductID NOT IN(SELECT ProductID FROM Comment)

--6.

SELECT TOP(1) WITH TIES Name, COUNT(a.CustomerID)[Số lượng bình luận]
	From Customer a JOIN Comment b ON a.CustomerID = b.CustomerID
	GROUP BY Name, a.CustomerID
	ORDER BY COUNT(a.CustomerID) DESC

--7.
CREATE VIEW vwFull_Information AS
SELECT ComID, a.Name AS [Customer Name], c.Name AS [Product Name], Date,Title, Content, Status = case Status
	WHEN 1 THEN 'Accept'
	WHEN 0 THEN 'Not Accept'
	END
	FROM Customer a JOIN Comment b ON a.CustomerID = b.CustomerID
	join Product c ON c.ProductID = b.ProductID

SELECT * FROM vwFull_Information

--8.
CREATE VIEW vwCustomerList AS
SELECT CustomerID, Name, Birth, Gender = case Gender
	WHEN 1 THEN 'Male'
	WHEN 0 THEN 'Female'
	else 'Unknow'
	end,
	Status = case 
	when DATEDIFF(YY,Birth,GETDATE()) >= 30 THEN 'Old'
	else 'Young'
	end
	FROM Customer;

SELECT * FROM vwCustomerList

--9.
ALTER VIEW vwCustomerList with schemabinding  AS
SELECT CustomerID, Name, Birth, Gender = case Gender
	WHEN 1 THEN 'Male'
	WHEN 0 THEN 'Female'
	else 'Unknow'
	end
	FROM dbo.Customer;

SELECT * FROM vwCustomerList

CREATE UNIQUE CLUSTERED INDEX uci_vwCustomerList
	ON vwCustomerList(Name)

SELECT * FROM vwCustomerList

--10.

create proc spStudent(@Name varchar(30)) as
begin
	if(exists(select * from Customer where Name like '%' +@Name+'%'))
	begin
		select * from Customer a join Comment b on a.CustomerID=b.CustomerID
			where Name like '%' +@Name+'%'
	end;
	else if(@Name='*')
	begin
		select * from Comment
	end;
	else
	begin
		print'Not found infomation about key word: '+ @Name;
	end;
end;
go

exec spStudent 'abcd'
exec spStudent '*'
exec spStudent 'Jonny'

--11.
create trigger tgUpdateProduct on Product instead of update as
begin
	alter table Comment drop constraint FK_ProductID;
	update Product set ProductID=(select ProductID from inserted)
	where ProductID = (select ProductID from deleted)
	update Comment set ProductID=(select ProductID from inserted)
	where ProductID = (select ProductID from deleted)
	alter table Comment add constraint FK_ProductID foreign key(ProductID) references Product(ProductID)
end;

select * from Product
select * from Comment
update Product set ProductID = 32 where ProductID = 3

--12.
create proc spDropOut(@Name varchar(30)) as
begin
	if(exists(select* from Customer where Name = @Name))
	begin
		delete from Comment where CustomerID in(select CustomerID from Customer where Name=@Name)
		delete from Customer where Name= @Name
	end;
	else 
	begin
		print 'Not found customer has name: '+ @Name;
	end;
end;

select * from Customer
select * from Comment
exec spDropOut 'abcd'
exec spDropOut 'Jonny Owen'

