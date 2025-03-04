USE Northwind

-----------------------------------------------------
--LÍ THUYẾT
-- MỘT DB là nơi chứa data ( bán hàng, thư viện , qlsv,...)
-- DATA được lưu dưới dạng TABLE, tách thành nhiều TABLE(nghệ thuật design db,NF)
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cx hiện thị dưới dạng table
--CÚ PHÁP CHUẨN : SELECT * FROM <TÊN-TABLE>
--                       * đại diện cho việc tui mún lấy all off columns 
--CÚ PHÁP MỞ RỘNG:
--                SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>
--                SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ
--                FROM <TÊN-TABLE>


-----------------------------------------------------

--1. Xem thông tin của tất cả các khách hàng đang giao dịch với mình
SELECT * FROM Customers
INSERT INTO Customers(CustomerID, CompanyName, ContactName) 
               VALUES('ALFKI', 'FPT University', 'Thanh Nguyen Khac') 
			   --bị chửi vì trùng PK

INSERT INTO Customers(CustomerID, CompanyName, ContactName) 
               VALUES('FPTU', 'FPT University', 'Thanh Nguyen Khac')
			   -- ngon lành cành đào
-- Data trả về có cell/ô có NULL, hiểu rằng chưa xđ value, chưa có , chưa biết
-- từ từ cập nhật sau. Ví dụ sinh viên kí tên vào danh sách thi,cột điểm ngay lúc
--kí tên gọi là NULL, mang trạng thái chưa xđ

--2.Xem thông tin nhân viên , xem hết các cột
SELECT * FROM Employees

--3.Xem các sản phẩm bán có trong kho
SELECT * FROM Products

--4.Mua hàng thì thông tin nằm ở table Order và OrderDetails
SELECT * FROM Orders --830 bill

--5.Xem thông tin công ty giao hàng
SELECT * FROM Shippers
INSERT INTO Shippers(CompanyName, Phone) VALUES('Fedex Vietnam', '(084)09...')
--6.Xem chi tiết mua hàng
SELECT * FROM Orders      --phần trên của bill siêu thị
SELECT * FROM [Order Details] --phần table kẻ giống lề những món hàng đã mua

--7.In ra thông tin khách hàng, chỉ gồm cột Id, ComName, ContacName, Country

SELECT CustomerID, CompanyName, ContactName, Country FROM Customers

--8.In ra thông tin của nhân viên, chỉ cần Id, Last, First, DOB
--Tên người tách thành Last & First: dành cho mục tiêu sort theo tiêu chí tên, họ
--In ra tên theo phong cách của từng quốc gia, tên theo quy ước của mỗi quốc gia

SELECT * FROM Employees

SELECT EmployeeID, LastName, FirstName, Title, BirthDate  From Employees

--9. In ra thông tin nhân viên , ghép tên cho đẹp/gộp cột, tính luôn tuổi giùm tui
SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title, BirthDate  From Employees

SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title,BirthDate, YEAR(BirthDate)  From Employees

SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title,BirthDate,
                                            YEAR(GETDATE())-YEAR(BirthDate) AS Age From Employees

--10. In ra thông tin chi tiết mua hàng
SELECT * FROM [Order Details]
SELECT *,UnitPrice * Quantity FROM [Order Details]
--CÔNG THỨC TÍNH TỔNG TIỀN PHẢ TRẢ TỪNG MÓN, CÓ TRỪ ĐI GIẢM GIÁ, PHẦN TRĂM
--SL * ĐG - TIỀN GIẢM GIÁ ==> PHẢI TRẢ
--SL * DG - SL * DG * DISCOUNT(%) ==> PHẢI TRẢ
--SL * DG (1 - DISCOUNT %) ==> TIỀN PHẢI TRẢ
SELECT *,UnitPrice * Quantity * ( 1 - Discount) AS SubTotal FROM [Order Details]








