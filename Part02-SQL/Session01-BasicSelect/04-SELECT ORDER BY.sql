﻿USE Northwind
--LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG:
--Ta muốn sắp xếp dữ liệu/sort theo tiêu chí nào đó, thường là tăng dần - ASCENDING/ASC
--                                                             giảm dần - DESCENDING/DESC
--mặc định ko nói gì cả thì sort theo tăng dần
-- A < B < C
-- 1 < 2 < 3
-- Ta có thể sort trên nhiều cột, logic này từ từ tính
-- SELECT ... FROM <TÊN-TABLE> ORDER BY TÊN-CỘT-MUỐN-SORT <KIỂU-SORT>

-----------------------------------------------------
--1.In ra danh sách nhân viên
SELECT * FROM Employees

--2. In ra danh sách nv tăng dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate ASC
SELECT * FROM Employees ORDER BY BirthDate --MẶC ĐỊNH LÀ TĂNG DẦN 

--3. In ra danh sách nv giảm dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate DESC

--4.Tính tiền chi tiết mua hàng
SELECT * FROM [Order Details]

SELECT *,UnitPrice * Quantity * (1 - Discount) AS SubTotal FROM [Order Details]

--5.Tính tiền chi tiết mua hàng, sắp xếp giảm dần theo số tiền
SELECT * FROM [Order Details]

SELECT *,UnitPrice * Quantity * (1 - Discount) AS SubTotal FROM [Order Details]
            ORDER BY SubTotal DESC

--6.In ra danh sách nhân viên giảm dần theo tuổi
SELECT * FROM Employees
SELECT EmployeeID, FirstName, LastName,YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees 
           ORDER BY Age DESC
