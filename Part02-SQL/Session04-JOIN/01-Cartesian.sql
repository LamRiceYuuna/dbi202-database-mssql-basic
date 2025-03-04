CREATE DATABASE Cartesian
--DB ~~ KHO ~~ TỦ ~~ THÙNG CHỨA DATA BÊN TRONG
--DATA BÊN TRONG CẤT DƯỚI DẠNG KỆ NGĂN - TABLE
USE Cartesian
CREATE TABLE EnDict (
	Nmbr int,
	EnDesc varchar(30)

)
--DROP TABLE EnDict  --DDL
--Từ điển tiếng anh số đếm
--1. One
--2. Two

SELECT * FROM EnDict   --DML Data Manipulation Language
INSERT INTO EnDict VALUES(1, 'One') --DML
INSERT INTO EnDict VALUES(2, 'Two')
INSERT INTO EnDict VALUES(3, 'Three')

--PHẦN NÀY THÊM CHO OUTER JOIN 
INSERT INTO EnDict VALUES(4, 'Four')
DELETE FROM EnDict WHERE EnDesc = 'Four'
CREATE TABLE VnDict (
	Nmbr int,
	VnDesc nvarchar(30) --nvarchar() String lưu tiếng việt
						--varchar() String lưu tiếng anh

)
INSERT INTO VnDict VALUES(1, N'Một') --DML
INSERT INTO VnDict VALUES(2, N'Hai')
INSERT INTO VnDict VALUES(3, N'Ba')
--PHẦN NÀY THÊM CHO OUTER JOIN 
INSERT INTO VnDict VALUES(5, N'Năm')

SELECT * FROM VnDict
SELECT * FROM EnDict
--BÔI ĐEN CẢ 2 LỆNH NÀY CHẠY, THÌ NÓ KO PHẢI LÀ JOIN, NÓ LÀ 2 CÂU RIÊNG BIỆT CHẠY
--CÙNG LÚC , CHO 2 TẬP KẾT QUẢ RIÊNG BIỆT!!
--JOIN LÀ GỘP CHUNG THÀNH 1 BẢNG TẠM TRONG RAM, KO ẢNH HƯỞNG DỮ LIỆU GỐC CỦA MỖI TABLE
--JOIN LÀ SELECT CÙNG LÚC NHIỀU TABLE
--CÚ PHÁP THỨ NHẤT
SELECT * FROM VnDict, EnDict --sin table mới, tạm thời lúc chạy hoi
							--số cột = tổng 2 bên
							--số dòng = tích 2 bên
SELECT * FROM VnDict, EnDict ORDER BY EnDesc
SELECT * FROM VnDict, EnDict ORDER BY Nmbr
--GHÉP TABLE, JOIN BỊ TRÙNG TÊN CỘT, DÙNG ALIAS(AS),ĐẶT TÊN GIẢ ĐỂ THAM CHIẾU
--									CHỈ ĐỊNH CỘT THUỘC TABLE TRÁNH NHẦM

SELECT * FROM VnDict, EnDict ORDER BY VnDict.Nmbr--tham chiếu cột qua tên table

SELECT * FROM VnDict vn, EnDict en ORDER BY en.Nmbr --đặt tên ngắn/giả cho table
													--tham chiếu cho các cột
SELECT vn.Nmbr, vn.VnDesc, en.EnDesc FROM VnDict vn, EnDict en ORDER BY en.Nmbr 

SELECT vn.*, en.EnDesc FROM VnDict vn, EnDict en ORDER BY en.Nmbr 

--CÚ PHÁP THỨ 2 --CHUẨN 
SELECT vn.*, en.* FROM VnDict vn CROSS JOIN EnDict en ORDER BY en.Nmbr 

--TUI BIẾT RẰNG CÓ CẶP GHÉP SÀI ĐƯỢC , VÌ CÓ TƯƠNG HỢP CELL NÀO ĐÓ, HERE Nmbr
SELECT * FROM VnDict vn , EnDict en 
		WHERE vn.Nmbr = en.Nmbr --rút từ 3 x3 = 9 thành 3
				--GHÉP CÓ CHỌN LỌC KHI TIM TƯƠNG QUAN CỘT/CELL ĐỂ GHÉP
				-->INNER JOIN/OUTER
				--EQUI JOIN
				--ĐA PHẦN GHÉP THEO TOÁN TỬ =
				--CÒN CÓ THỂ GHÉP THEO > >= < <= = !=


