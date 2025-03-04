--1.Done
--2.
CREATE DATABASE DBLab4
USE DBLab4
--3.
CREATE TABLE Customers
(
	MaKhach int NOT NULL,
	Ten nvarchar(30),
	SoDienThoai varchar(7),
)
ALTER TABLE Customers ADD CONSTRAINT PK_MaKhach PRIMARY KEY(MaKhach)

CREATE TABLE Items
(
	MaHang int NOT NULL,
	Ten nvarchar(15),
	SoLuong int,
	DonGia int,
)
ALTER TABLE Items ADD CONSTRAINT PK_MaHang PRIMARY KEY(MaHang)

CREATE TABLE CustomerItem
(
	MaKhach int NOT NULL,
	MaHang int NOT NULL,
	SoLuongMua int,
)
ALTER TABLE CustomerItem ADD 
			CONSTRAINT PK_MaKhach_MaHang PRIMARY KEY(MaKhach, MaHang),
			CONSTRAINT FK_MaKhach FOREIGN KEY(MaKhach) REFERENCES Customers(MaKhach),
			CONSTRAINT FK_MaHang FOREIGN KEY(MaHang) REFERENCES Items(MaHang)

--4.
INSERT Items VALUES 
	(1, 'Tu Lanh', 5, 3500),
	(2, 'Ti vi', 2, 3000),
	(3, 'Dieu hoa', 1, 8000),
	(4, 'Quat da', 5, 1700),
	(5, 'May giat', 3, 5000)

--5.
INSERT Customers VALUES 
	(1, 'Dinh Truong Son', '1234567'),
	(2, 'Mai Thanh Minh', '1357999'),
	(3, 'Nguyen Hong Ha', '2468888');

INSERT CustomerItem VALUES
	(1, 1, 4),
	(1, 5, 1),
	(2, 2 ,1),
	(3, 3, 1),
	(3, 1, 1)

--6.
SELECT SUM(i.DonGia * c.SoLuongMua) AS [Tổng tiền thu được] FROM Items i JOIN CustomerItem c
		 ON i.MaHang = c.MaHang

--7.
SELECT TOP(1) WITH TIES c.Ten, SUM(i.DonGia * ci.SoLuongMua) AS [Tổng tiền mua] FROM Customers c JOIN CustomerItem ci
		ON c.MaKhach = ci.MaKhach JOIN Items i ON ci.MaHang = i.MaHang
		GROUP BY c.Ten, c.MaKhach
		ORDER BY [Tổng tiền mua] DESC

--8
IF(EXISTS(SELECT * FROM Customers c JOIN CustomerItem ci
		ON c.MaKhach = ci.MaKhach JOIN Items i ON ci.MaHang = i.MaHang
		WHERE SoDienThoai = '2468888' and i.Ten = 'Tu Lanh'))
BEGIN
	PRINT N'Có mua';
END;
ELSE
BEGIN
	PRINT N'Không mua'

END;
		
--9.
--Tổng số lượng hàng hóa còn lại:
--Tổng ban đầu:
DECLARE @TongBanDau int;
SET @TongBanDau =(SELECT SUM(SoLuong) FROM Items)
--Tổng số đã bán:
DECLARE @TongDaBan int;
SET @TongDaBan =(SELECT SUM(SoLuongMua) FROM CustomerItem)
--Tổng số tiền còn lại:
--Tổng tiền ban đầu:
DECLARE @TongTienChiBanDau int;
SET @TongTienChiBanDau =(SELECT SUM(DonGia * SoLuong) FROM Items)
--Tổng tiền thu về:
DECLARE @TongTienThuVe int;
SET @TongTienThuVe =(SELECT SUM(DonGia * SoLuongMua) FROM Items i JOIN CustomerItem ci ON i.MaHang = ci.MaHang)
SELECT(@TongBanDau - @TongDaBan) AS [Số hàng còn trong kho] , (@TongTienChiBanDau - @TongTienThuVe) AS [Số Tiền còn lại];

--10.
SELECT TOP(3) WITH TIES i.Ten, SUM(ci.SoLuongMua) AS [Số lượng bán] FROM Items i JOIN CustomerItem ci ON i.MaHang = ci.MaHang
		GROUP BY i.Ten
		ORDER BY [Số lượng bán] DESC
		
--11.
SELECT * FROM Items WHERE MaHang NOT IN(SELECT MaHang FROM CustomerItem)

--12.
SELECT c.Ten,COUNT(ci.MaKhach) AS [Số Mặt Hàng Đã Mua] from Customers c join CustomerItem ci 
on c.MaKhach=ci.MaKhach
group by c.Ten 
having count(ci.MaKhach) > 1

--13.

SELECT  c.Ten[Tên khách hàng],i.Ten[Mặt Hàng],ci.SoLuongMua AS [Số Lượng Mua] from Customers c join CustomerItem ci 
on c.MaKhach = ci.MaKhach join Items i on ci.MaHang = i.MaHang
where SoLuongMua > 1

--14.
SELECT c.MaKhach , c.Ten, SUM(i.DonGia * ci.SoLuongMua)[Tổng tiền mua hàng] ,Level = case
		WHEN SUM(i.DonGia * ci.SoLuongMua) < 5000 then 'Level1'
		WHEN SUM(i.DonGia * ci.SoLuongMua) < 10000 then 'Level2'
		ELSE 'V.I.P'
		END
		FROM Customers c JOIN CustomerItem ci 
		ON c.MaKhach = ci.MaKhach JOIN Items i ON i.MaHang = ci.MaHang
		GROUP BY c.Ten, c.MaKhach


select Product.*, [Phân loại] = case 
	when price > 0 and price < 10000000 then N'Bình dân'
	when price >= 10000000 and price < 25000000 then N'Trung Cấp'
	else N'Cao cấp'
	end
	from Product