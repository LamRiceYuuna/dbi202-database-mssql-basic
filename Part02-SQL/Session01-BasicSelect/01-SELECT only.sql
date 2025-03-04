USE Northwind -- Chọn để chơi với thùng chứa data nào đó 
	          -- tại 1 thời điểm chơi với 1 thùng chứa data
 SELECT * FROM Customers

 SELECT * FROM Employees

-----------------------------------------------------
--LÍ THUYẾT
--1.DBE cung cấp cậu lệnh SELECT dùng để
--    in ra màn hình 1 cái gì đó ~~ printf() sout()
--    in ra dữ liệu có trong table (hàng/cột)
--    dùng cho mục đích nào thì kết quả hiện thị luôn là 1 table 

-----------------------------------------------------

-- 1.Hôm nay ngày bao nhiêu ??
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

-- 2.Bây giờ là tháng mấy hỡi em?
SELECT MONTH(GETDATE()) AS [Bây giờ tháng mấy]

SELECT YEAR(GETDATE()) AS [Hiện nay là năm bao nhiêu]

-- 3. Trị tuyệt đối của -5 là mấy?

SELECT ABS(-5) AS [Trị tuyệt đối của -5 là mấy?]

--4. 5 + 5 là mấy?
SELECT 5 + 5 AS [5 + 5 là ..]

--5. In ra tên của mình
SELECT N'Nguyễn Bảo Lâm' AS [My full name is ]

SELECT N'Nguyễn' + N' Bảo Lâm' AS [My full name is]

--6. Tính tuổi
SELECT YEAR(GETDATE()) - 2002

--SELECT N'Nguyễn' + N' Bảo Lâm' +  (YEAR(GETDATE()) - 2002) + ' year old' lỗi vì lộn xộn kiểu data
SELECT N'Nguyễn' + N' Bảo Lâm' + ' '+ CONVERT(VARCHAR, YEAR(GETDATE()) - 2002) + ' year old' AS [My profile]

SELECT N'Nguyễn' + N' Bảo Lâm' + ' '+ CAST(YEAR(GETDATE()) - 2002 AS varchar) + ' year old' AS MyProfile

--7. Phép nhân 2 số
SELECT 10 * 10 AS [10 X 10 =]










