CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK


CREATE TABLE PhoneBookV2_
(
	Nick nvarchar(30),
	--Phone varchar(50) -- cấm gộp nhiều số phone trong 1 cell
	Phone1 char(11),-- chỉ 1 số phone thôi
	Phone2 char(11),
	Phone3 char(11), -- éo biết cột nào là loại nào, 1 2 3 vô hồn 
)

CREATE TABLE PhoneBookV2
(
	Nick nvarchar(30),
	--Phone varchar(50) -- cấm gộp nhiều số phone trong 1 cell
	HomePhone char(11),-- chỉ 1 số phone thôi
	WorkPhone char(11),
	CellPhone char(11), 
)
--mở rộng table theo chiều ngang -- thêm cột!!!


SELECT * FROM PhoneBookV2
INSERT INTO PhoneBookV2 VALUES (N'hoang nt',NULL ,NULL, '090x')
--AN có 2 số phone làm sao để lưu??
INSERT INTO PhoneBookV2 VALUES (N'annguyen', '090x', '091x', NULL)

--Bình có 3 số phone, làm sao lưu?? M ko thấy t để độ rộng của phone là 50 à

INSERT INTO PhoneBookV2 VALUES (N'binhle', '090x ', '091x' , '092x')

--*****phân tích:
-->>>>Ưu điểm: SELECT PHONE LÀ RA ĐC TẤT CẢ CÁC SỐ DI ĐỘNG 
--1.SQL: Cho tôi biết số di động của mọi người
SELECT p.Nick, p.CellPhone FROM PhoneBookV2 p

SELECT p.Nick,p.HomePhone ,p.CellPhone FROM PhoneBookV2 p
	WHERE p.Nick = 'binhle'


-->>Nhược điểm : 
--Thông kế số lượng điện thoại mỗi người đang xài, mấy sim?? ko trả  lời đc
-->Data bị null nhiều, phí không gian lưu trữ
-->Người có 4 PHONE, 5Phone thì sao
-->SOLUTION:thêm cột , trừ hao về người có nhiều phone
--   những người còn lại bị null càng nhiều
-->Phí vì chỉ vì 1 vài người đặc biệt nhiều phone mà tất cả ae khác đều đc xem chung là nhiều phone, phí ko gian lưu trữ
-->Giả sử vẫn quyết tâm theo cột, nở cột ra , thì giá phải trả sửa code lập trinhf
-->Sau này, vì tên cột mới đc thêm vô khi nâng cấp app, sửa câu query

--Triết lý thiết kế: Cố gắng giữ nguyên cái tủ, chỉ thêm đồ	,
--					 Không thêm cột của table, chỉ cần thêm dòng nếu có biến động số lượng



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