USE Northwind

--LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
--SELECT * FROM<TABLE> WHERE...
--WHERE CỘT TOÁN TỬ SO SÁNH VỚI -VALUE-CẦN-LỌC
--      CỘT > >= < <= = != VALUE
--						   DÙNG CÂU SUB-QUERY TÙY NGỮ CẢNH
--		CỘT				 =(SUB CHỈ CÓ 1 VALUE)
--		CỘT				 IN(SUB CHỈ 1 CỘT NHƯNG NHIỀU VALUE)

--		CỘT				 > >= < <= ALL(tất cả) (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--								   ANY(bất kì) (1 CÂU SUB 1 CỘT NHIỀU VALUE)

------------------------------------------------------------------------

--THỰC HÀNH
--tạo 1 table có 1 cột tên là Numbr
CREATE TABLE Num
(

	Numbr int



)
SELECT * FROM Num
INSERT INTO Num values (1)
INSERT INTO Num values (1)
INSERT INTO Num values (2)
INSERT INTO Num values (9)
INSERT INTO Num values (5)
INSERT INTO Num values (100)
INSERT INTO Num values (101)

--1. In ra những số > 5
SELECT * FROM Num WHERE Numbr > 5

--2. In ra số lớn nhất
--SỐ LỚN NHẤT TRONG 1 ĐÁM ĐC ĐỊNH NGHĨA : M LỚN HƠN HẾT CẢ ĐÁM ĐÓ
--LỚN HƠN TẤT CẢ NGOẠI TRỪ CHÍNH MÌNH -> MÌNH LÀ MAX CỦA ĐÁM
SELECT * FROM  Num WHERE Numbr = 101 --lầy lội
SELECT * FROM  Num WHERE Numbr >= ALL (SELECT Numbr FROM Num)

--3.Số nhỏ nhất là số lào?
SELECT * FROM  Num WHERE Numbr <= ALL (SELECT Numbr FROM Num)

SELECT * FROM  Num WHERE Numbr > ALL (SELECT Numbr FROM Num)--rỗng

--4.Nhân viên lào lớn tuổi nhất
--Tuổi lớn nhất năm sinh nhỏ nhất
SELECT * FROM Employees WHERE BirthDate <=  ALL (SELECT BirthDate FROM Employees)


--5.Đơn hàng nào có trọng lượng nặng nhất
SELECT * FROM Orders WHERE Freight >= ALL (SELECT Freight FROM Orders)