USE Northwind

--LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
--SELECT * FROM<TABLE> WHERE...

--WHERE CỘT = VALUE NÀO ĐÓ
--WHERE CỘT IN (MỘT TẬP HỢP NÀO ĐÓ)
--VD: City IN ('London', 'Berlin', 'Newyork') --thay bẳng OR OR OR
--                                              City = 'London' OR City=''...OR
--NẾU CÓ 1 CÂU SQL MÀ TRẢ VỀ 1 CỘT , NHIỀU DÒNG
--MỘT CỘT VÀ NHIỀU DÒNG TA CÓ THỂ XEM NÓ TƯƠNG ĐƯƠNG MỘT TẬP HỢP
--SELECT CITY FROM EMPLOYEES, BẠN ĐƯỢC 1 LOẠT CÁC THÀNH PHỐ
--TA CÓ THỂ NHÉT/LỒNG CÂU 1 CỘT/NHIỀU DÒNG VÀO TRONG MỆNH ĐỀ IN TRONG CÂU SQL BÊN NGOÀI
--*CÚ PHÁP:
--WHERE CỘT IN(MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU -TẬP HỢP)
-----------------------------------------------------------------------------------


--THỰC HÀNH
--1.Liệt kê các nhóm hàng
SELECT * FROM Categories

--2.In ra các món hàng/mặt hàng thuộc nhóm 1, 6, 8 
SELECT * FROM Products WHERE CategoryID IN (1, 6, 8)--30

SELECT * FROM Products WHERE CategoryID = 1 OR CategoryID = 6 OR CategoryID = 8--30
--3.In ra các món hàng thuộc nhóm bia/rượu, thịt, và hải sản

SELECT * FROM Products WHERE CategoryID IN (
              SELECT CategoryID FROM Categories WHERE CategoryName IN ('Beverages', 'Meat/Poultry', 'Seafood')
			                                 )--30


--4.Nhân viên quê London phụ trách những đơn hàng nào
SELECT * FROM Orders WHERE EmployeeID IN (
					SELECT EmployeeID FROM Employees WHERE City = 'London'	 					
										)--224

--5.Các nhà cung cấp đến từ Mĩ cung cấp những mặt hàng nào ? 		 								
SELECT * FROM Suppliers	
SELECT * FROM Orders 
    WHERE OrderID IN (SELECT OrderID FROM [Order Details] 
	WHERE ProductID IN (SELECT ProductID FROM Products
	WHERE SupplierID IN ( SELECT SupplierID FROM Suppliers
	WHERE Country = 'USA')))-244
		
--6.Các nhà cung cấp đến từ Mĩ cung cấp những nhóm hàng nào ? 
SELECT * FROM Categories
	WHERE CategoryID IN (SELECT CategoryID FROM Products
	WHERE ProductID IN (SELECT ProductID FROM Products
	WHERE SupplierID IN ( SELECT SupplierID FROM Suppliers
	WHERE Country = 'USA')))--4

--7.Các đơn hàng vận chuyển tới thành phố Sao Paulo được vận chuyển bởi những hãng nào?
SELECT * FROM Orders
SELECT * FROM Shippers WHERE ShipperID IN (
         SELECT ShipVia FROM Orders WHERE ShipCity = 'Sao Paulo'
		                                   )--3


--8.Khách hàng đến từ thành phố Berlin , London, Madrid có những đơn hàng nào
SELECT * FROM Orders WHERE CustomerID IN (
		SELECT CustomerID FROM Customers WHERE City IN ('Berlin', 'London', 'Madrid')
										)--60

