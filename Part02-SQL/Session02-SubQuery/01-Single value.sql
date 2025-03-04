USE Northwind

--LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
--SELECT * FROM<TABLE> WHERE...

--WHERE CỘT = VALUE NÀO ĐÓ
--WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g. '____'
--WHERE CỘT BETWEEN RANGE (AND)..
--WHERE CỘT IN (TẬP HỢP GIÁ TRỊ ĐƯỢC LIỆT KÊ)

--MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 VALUE/CELL
--MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 TẬP GIÁ TRỊ/CELL
--TẬP KẾT QUẢ NÀY ĐỒNG NHẤT (CÁC GIÁ TRỊ KHÁC NHAU CỦA 1 BIẾN)

--*****
--WHERE CỘT = VALUE NÀO ĐÓ - đã học. e,g YEAR(DOB) = 2003
--          = THAY VALUE NÀY  = 1 CÂU SQL KHÁC MIỄN TRẢ VỀ 1 CELL
--KĨ THUẬT VIẾT SQL THEO KIỂU HỎI GIÁN TIẾP, LỒNG NHAU, TRONG
--CÂU SQL CHỨA CÂU SQL KHÁC



------------------------------------------------
--THỰC HÀNH
--1.In ra danh sách nhân viên
SELECT * FROM Employees
SELECT FirstName FROM Employees WHERE EmployeeID = 1 --1 cell
SELECT FirstName FROM Employees --1 tập giá trị/1 cột/phép chiếu

--2. Liệt kê các nhân viên ở London
SELECT * FROM Employees WHERE City = 'London'--4

--3. Liệt kê các nhân viên cùng quê với King Robert
SELECT * FROM Employees WHERE FirstName = 'Robert'
SELECT City FROM Employees WHERE FirstName = 'Robert'--1 value London

--đáp án câu 3
SELECT * FROM Employees 
        WHERE City = (
		              SELECT City FROM Employees WHERE LastName = 'King' AND FirstName = 'Robert'
					  )
--câu này 9.9 điểm , trong kết quả còn Robert bị dư, tìm cùng quê R 
--không cần nói lại Robert
SELECT * FROM Employees 
        WHERE City = (
		              SELECT City FROM Employees WHERE LastName = 'King' AND FirstName = 'Robert'
					  )
					AND FirstName <> 'Robert'--3
--4.Liệt kê các đơn hàng
SELECT * FROM Orders ORDER BY Freight DESC
--4.1. Liệt kê tất cả các đơn hàng trọng lượng lớn hơn 252kg
SELECT * FROM Orders WHERE Freight >= 252
--4.2. Liệt kê tất cả các đơn hàng trọng lượng lớn hơn = trọng lượng đơn hàng 10555
SELECT * FROM Orders 
         WHERE Freight >= (
                         SELECT Freight FROM Orders WHERE OrderID = 10555
						  )--47
                   AND OrderID != 10555
--BTVN:
--1. Liệt kê danh sách các công ty vận chuyển hàng
SELECT * FROM Shippers --4
--2. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có mã số 1

SELECT * FROM Orders WHERE ShipVia = 1--249
--3.Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có 
--tên Speedy Express
SELECT * FROM Orders 
         WHERE ShipVia = (
         SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'            
						)--249
--4..Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có 
--tên Speedy Express và trọng lượng  từ 50-100
SELECT * FROM Orders 
         WHERE ShipVia = (
         SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'            
						) AND Freight BETWEEN 50 AND 100 --50

--5.Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix
SELECT * FROM Categories
SELECT * FROM Products 
         WHERE CategoryID = (
		      SELECT CategoryID FROM Products WHERE ProductName = 'Filo Mix'
			      ) --7



--6.Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet
--TRẺ HƠN NGHĨA LÀ NĂM SINH > JANET
SELECT * FROM Employees 
          WHERE BirthDate > (
		        SELECT BirthDate FROM Employees WHERE FirstName = 'Janet')
				--1