--LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG LỆNH SELECT:
--KHI BẠN CẦN LỌC DỮ LIỆU TRONG 1 ĐOẠN CHO TRƯỚC , THAY VÌ DÙNG >=...AND <= , TA CÓ THỂ
--THAY THẾ BẰNG MỆNH ĐỀ BETWEEN, IN
--*CÚ PHÁP : CỘT BETWEEN VALUE-1 AND VALUE-2
--                       >>>>>>>> BETWEEN THAY THẾ CHO 2 MỆNH ĐỀ >= <= AND

--*CÚ PHÁP : CỘT IN (MỘT TẬP CÁC GIÁ TRỊ ĐC LIỆT KÊ CÁCH NHAU DẤU PHẨY) 
--           >>>>>>IN THAY THẾ CHO 1 LOẠT MỆNH ĐỀ OR





USE Northwind

-----------------------------------------------------
--1.Danh sách nhân viên sinh trong đoạn [1960 1970]
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 
                          ORDER BY BirthDate DESC --4

SELECT * FROM Employees WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970
                          ORDER BY BirthDate DESC --4

--2.Liệt kê các đơn hàng có trọng lượng từ 100 ..500
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 500 --174

--3.Liệt kê đơn hàng gửi tới Anh , Pháp, Mĩ
SELECT * FROM Orders WHERE ShipCountry = 'USA' OR ShipCountry = 'France' 
                                               OR ShipCountry = 'UK' --255

SELECT * FROM Orders WHERE ShipCountry IN ('USA', 'France', 'UK') --255

--4.Liệt kê đơn hàng KHÔNG gửi tới Anh , Pháp, Mĩ
SELECT * FROM Orders WHERE NOT(ShipCountry = 'USA' OR ShipCountry = 'France' 
                                               OR ShipCountry = 'UK')
SELECT * FROM Orders WHERE ShipCountry NOT IN('USA', 'France', 'UK')

--5.Liệt kê các đơn hàng trong năng 1996 ngoại trừ tháng 6,7,8,9
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1996 
                      AND MONTH(OrderDate) NOT IN (6, 7, 8, 9)
--LƯU Ý IN: KHI TA LIỆT KÊ ĐƯỢC CÁC TẬP GIÁ TRỊ THÌ MỚI CHƠI VS IN
--KHOẢNG SỐ THỰC THÌ KHÔNG LÀM ĐƯỢC

--6.Liệt kê các đơn hàng có trọng lượng từ 100 ..110
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 110 ORDER BY Freight DESC
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 110 ORDER BY Freight DESC

