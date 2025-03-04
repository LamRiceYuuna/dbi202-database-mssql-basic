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
CREATE TABLE PhoneBookV3_2 (
	Nick nvarchar(30),--ngoài cột này bị lặp lại, mình còn cần thêm cột
					 --Full name, tên cty, chức vụ
	--.....CompanyName....
	HomePhone char(11),-- chỉ 1 số phone thôi, CẦN GIẢI NGHĨA THÊM PHONE NÀY LÀ SỐ GÌ
	PhoneType nvarchar(20) --090x   Home, 091x Work

)
------------------------------------------------------------------
--Tách bảng
--Khốn nạn thông tin bị phân mảnh, nằm nhiều nơi, phải join rồi
--Nhập data coi trừng bị vênh, xóa data coi chừng lạc trôi
--Phân mảnh phải có lúc tái nhập(JOIN) JOIN TRÊN CỘT NÀO??
--FK xuất hiện!!!
--hok thích chơi fk được không ?? được và k đc
-- nếu chỉ cần join éo cần fk, cột = value , khớp là join, ghép ngang
--nếu kèm thêm xóa, sửa , thêm thì chết mẹ, lộn xộn ko nhất quán
CREATE TABLE PersonV4_1
(
	Nick nvarchar(30),--ngoài cột này bị lặp lại, mình còn cần thêm cột
					 --Full name, tên cty, chức vụ
	--.....CompanyName....
	Title nvarchar(30),
	Company nvarchar(40)
	)
CREATE TABLE PhoneBookV4_1 (

	HomePhone char(11),
	PhoneType nvarchar(20),
	Nick nvarchar(30) -- éo cần fk, chỉ cần join vẫn ok

)
select * from PersonV4_1
SELECT * FROM PhoneBookV4_1

INSERT INTO PersonV4_1 VALUES (N'hoang nt', 'Lecturer', 'FPTU HCMC')
INSERT INTO PersonV4_1 VALUES (N'annguyen', 'Student', 'FPTU HCMC')
INSERT INTO PersonV4_1 VALUES (N'binhle', 'Student', 'FPTU HL')


INSERT INTO PhoneBookV4_1 VALUES ('098x', 'Home', N'hoang nt')
--AN có 2 số phone làm sao để lưu??
INSERT INTO PhoneBookV4_1 VALUES ('090x' , 'Cell', N'annguyen')
INSERT INTO PhoneBookV4_1 VALUES ('091x', 'Home', N'annguyen')


--Bình có 3 số phone, làm sao lưu?? M ko thấy t để độ rộng của phone là 50 à

INSERT INTO PhoneBookV4_1 VALUES ( '090x ', 'Work', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES ('091x ', 'Cell', N'binhle')
INSERT INTO PhoneBookV4_1	 VALUES ('092x ', 'Cell', N'binhle')

--PHÂN TÍCH:	
--*Ưu điểm
--count ngon, group by theo nick, theo loại phone
--where theo loại phone ngon luôn
--Redundancy trên info của nick/full/cty/email/ năm sinh....giải quyết xong ở bảng Person
--Nhược điểm
--Tính không nhất quán (inconsistency) của loại Phone có người gõ : Cell, CELL, cell éo sợ vì cùng là 1
--															 gõ thêm :Di động,DĐ cả đám này đều là 1 theo logic
--														     máy hiểu là khác nhau

--query liệt kê các số di động của tất cả mọi người , toang khi where
--vì éo biết được có bn loại chữ biểu diễn chung cho Di động
INSERT INTO PhoneBookV4_1	 VALUES ('093x ', 'Mobile', N'binhle')
INSERT INTO PhoneBookV4_1	 VALUES ('094x ', 'Sugar Daddy', N'binhle')

--SQL.Liệt kê các số di dộng của bình lê
SELECT * FROM PhoneBookV4_1 
			WHERE PhoneType = 'Cell' OR PhoneType = 'CELL' OR PhoneType = 'DĐ'
SELECT * FROM PhoneBookV4_1 
			WHERE PhoneType IN('Cell', 'CELL', 'DĐ')
		--Máy tính in cái tập hợp đến bh người ta còn gõ đc những từ khác 
		--cùng biểu diễn đc cho khái niệm di động

--QUY TẮC THÊM: có những loại data biết trước là nhiều , nhưng hữu hạn cái value để nhập
--VD: Tỉnh thành nhiều, chỉ 63, quốc gia nhiều 230, châu lục 6,Trường THPT 500
--Có nên cho người ta gõ tay hay không , vì sẽ gây không nhất quán!!!
--Tốt nhất cho chọn, chọn từ cái có sẵn	, sẵn, sẵn tức là từ table khác

--Không cho gõ lung tung, gõ trong cái đã có - Dính đến 2 thứ, đến table khác(đã nói ở trên)
--							FK để đảm bảo chọn đúng trong đó thoy

