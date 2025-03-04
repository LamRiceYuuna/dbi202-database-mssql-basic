CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK


CREATE TABLE PhoneBookV3_1
(
	Nick nvarchar(30),
	HomePhone char(11),-- chỉ 1 số phone thôi

)
--mở rộng table theo chiều dọc, ai có nhiều sim thì thêm dòng!!!


SELECT * FROM PhoneBookV3_1
INSERT INTO PhoneBookV3_1 VALUES (N'hoang nt', '098x')
--AN có 2 số phone làm sao để lưu??
INSERT INTO PhoneBookV3_1 VALUES (N'annguyen', '090x')
INSERT INTO PhoneBookV3_1 VALUES (N'annguyen', '091x')


--Bình có 3 số phone, làm sao lưu?? M ko thấy t để độ rộng của phone là 50 à

INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '090x ')
INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '091x ')
INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '092x ')


--*****phân tích:
-->>>>Ưu điểm: SELECT PHONE LÀ RA ĐC TẤT CẢ CÁC SỐ DI ĐỘNG 
--Thông kế số lượng điện thoại mỗi người đang xài, mấy sim?? ngon
--Không bị null muốn thêm bn phone cho ai thêm thì thêm!!! 
SELECT Nick, COUNT(*) AS [No Phones] FROM PhoneBookV3_1
		GROUP BY Nick

SELECT p.Nick, p.CellPhone FROM PhoneBookV2 p

SELECT p.Nick,p.HomePhone ,p.CellPhone FROM PhoneBookV2 p
	WHERE p.Nick = 'binhle'


-->>Nhược điểm : 
--> Ko biết số phone X nào đó thuộc loại nào?!!!
--Cho tui biết số để bàn, ở nhà của anh binhle???
--In cho tui số di động của mọi người
--Vi phạm PK , redundancy, hoangnt lặp lại nhiều lần làm j khi hoangnt mới lưu nick
--Fullname, title, tên cty, email, ....


--Thông kế số lượng điện thoại mỗi người đang xài, mấy sim?? ko trả  lời đc
--Triết lý thiết kế: Cố gắng giữ nguyên cái tủ, chỉ thêm đồ	,
--					 Không thêm cột của table, chỉ cần thêm dòng nếu có biến động số lượng

--Để tránh redundancy, PK --> Tách bảng, phần lặp lại ra một chỗ khác

INSERT INTO PhoneBookV1 VALUES (N'binhle', '090x | 091x | 092x')
INSERT INTO PhoneBookV1 VALUES (N'cuongvo', '090x , 091x , 092x')
INSERT INTO PhoneBookV1 VALUES (N'dungpham', '090x-091x - 092x')
-->>>Tiêu chí cắt chuỗi - DELIMITER DẤU PHÂN CÁCH KO NHẤT QUÁN

-->>> quy ược ngầm về nhập dấu phân cách


--đếm xem mỗi người có bn số phone !!! COUNT() quá quen
--dấu phân cách khó khăn cho cắt để count!!!


--KHÓ KHĂN XẢY RA KHI TA GOM NHIỀU VALUE CÙNG KIỂU, NGỮ NGHĨA VÀO
--TRONG 1 COLUMN(cột Phone lưu nhiều số phone cách nhau dấu cách)
--gây khó khăn cho nhập dữ liệu (ko nhất quán dấu cách), khi select
--count() thống kê theo tiêu chí (in số phone ở nhà)
--update thêm phone mới, xóa số cũ,

--1 CELL MÀ CHỨA NHIỀU VALUE CÙNG KIỂU, ĐC GỌI LÀ CỘT ĐA TRỊ 
--MULTIVALUED COLUMN -> TIỀM ẨN NHIỀU KHÓ KHĂN TRONG VIỆC XỬ LÍ DATA

--Nếu 1 table có cột đa trị , người ta nói rằng éo đạt chuẩn 1 
--Level thiết kế chán quá - 1ST NORMALIZATION FORM

--CHUẨN 1 , CHẤT LƯỢNG THIẾT KẾ TÍNH TỪ 1, 2, 3 , ...

--THIẾT KẾ KÉM THÌ PHẢI NÂNG CẤP, KO CHƠI ĐA TRỊ NỮA!!!
--KO CHƠI GOM VALUE TRONG 1 CELL

--2 CHIẾN LƯỢC FIX
--CHIỀU NGANG(thêm cột), CHIỀU DỌC(thêm dòng!!!!)****

-->THIẾT KẾ PHIÊN BẢN 3-- PHIÊN BẢN NGON BẮT ĐẦU, AI NHIỀU PHONE THÌ NHIỀU DÒNG, NHIỀU CELL THEO CHIỀU DỌC	 THÊM DÒNG
--> COUNT NGON LÀNH LUÔN, TRẢ LỜI NGAY BAO NHIÊU SIM, BAO NHIÊU SÓNG
--
----------------------------------------------
--TA CẦN GIẢI QUYẾT PHONE NÀY THUỘC LOẠI NÀO???
CREATE TABLE PhoneBookV3_2
(
	Nick nvarchar(30),
	HomePhone char(11),-- chỉ 1 số phone thôi, CẦN GIẢI NGHĨA THÊM PHONE NÀY LÀ SỐ GÌ
	PhoneType nvarchar(20) --090x   Home, 091x Work

)

SELECT * FROM PhoneBookV3_2
INSERT INTO PhoneBookV3_2 VALUES (N'hoang nt', '098x', 'Home')
--AN có 2 số phone làm sao để lưu??
INSERT INTO PhoneBookV3_2 VALUES (N'annguyen', '090x' , 'Cell')
INSERT INTO PhoneBookV3_2 VALUES (N'annguyen', '091x', 'Home')


--Bình có 3 số phone, làm sao lưu?? M ko thấy t để độ rộng của phone là 50 à

INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '090x ', 'Work')
INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '091x ', 'Cell')
INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '092x ', 'Cell')

--PHÂN TÍCH:
--*Ưu điểm
--count ngon, group by theo nick, theo loại phone
--where theo loại phone ngon luôn
SELECT * FROM PhoneBookV3_2 WHERE   PhoneType = 'Cell'
--Nhược điểm
--Redundancy trên info của nick/full/cty/email/ năm sinh....


--Một khi bị trùng lặp info, redundancy,  chỉ có 1 solution
--Không cho trùng, tức là xh 1 lần, tức là ra bảng khác -> DECOMPOSITION PHÂN RÃ