CREATE DATABASE DBDESIGN_ONETABLE
--Create dùng để tạo cấu trúc lưu trữ/dàn khung/ thùng chứa dùng lưu trữ data/info
--tương đương việc xây phòng chứa đồ -database
--			mua tủ để trong phòng - TABLE
--1 DB CHỨA NHIỀU TABLE - 1 PHÒNG CHỨA NHIỀU TỦ
--						- 1 NHÀ CÓ NHIỀU PHÒNG

--TẠO RA CẤU TRÚC LƯU TRỮ - CHƯA NÓI DATA BỎ VÀO - DDL(PHÂN NHÁNH CỦA SQL)
USE DBDESIGN_ONETABLE

--Tạo table lưu trữ hồ sơ sinh viên : mã số (phân biệt các sv vs nhau), tên, dob,địa chỉ
--1 SV ~~ 1 OBJECT ~~ 1 ENTITY
--1 TABLE DÙNG ĐỂ LƯU TRỮ NHIỀU ENTITY

CREATE TABLE StudentV1
(
	StudentID char(8),
	LastName nvarchar(40), --tại sao ko gộp full name
	FirstName nvarchar(10),--n : lưu kí tự Unicode tiếng việt
	DOB datetime,
	Address nvarchar(50)

)
--SQL Sever | Oracle (Oracle/Java) | DB(IBM) | MySQL| PostgeSQL| SQLite |MS Access

--THAO TÁC TRÊN DATA/MÓN ĐỒ TRONG TỦ/TRONG TABLE -DML/DQL(dành riêng cho select)
SELECT * FROM StudentV1

--Đưa data vào table/mua đồ quần áo bỏ vào tủ

INSERT INTO StudentV1 VALUES ('SE123456', N'Nguyễn', N'An','2003-1-1', N'...TP.Hồ Chí Minh' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN

--MỘT SỐ CỘT CHƯA THÈM NHẬP INFO, ĐƯỢC QUYỀN BỎ TRỐNG NẾU CỘT CHO PHÉP TRỐNG VALUE
--DEFAULT KHI ĐÓNG CÁI TỦ/MUA TỦ/THIẾT KẾ, MẶC ĐỊNH NULL
INSERT INTO StudentV1 VALUES ('SE123457', N'Lê', N'Bình','2003-2-1', NULL ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN
--Tên thành phố là chữ NULL, WHERE = 'NULL' OKIE VÌ NÓ LÀ DATA
--NULL Ở CÂU TRÊN WHERE ADDRESS IS NULL
INSERT INTO StudentV1 VALUES ('SE123458', N'Võ', N'Cường','2003-3-1', N'NULL' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN

--Tui chỉ muốn lưu vài info , ko đủ số cột , miễn cột còn lại cho phép bỏ trống
INSERT INTO StudentV1(StudentID, LastName, FirstName) 
			VALUES ('SE123459', N'Trần', N'Dũng') 

INSERT INTO StudentV1( LastName, FirstName, StudentID) 
			VALUES ( N'Phạm', N'Em', 'SE123460') 


INSERT INTO StudentV1( LastName, FirstName, StudentID) 
			VALUES ( NULL, NULL, NULL) --Siêu nguy hiểm , sv toàn info bỏ trống
										--Gài cách đưa data vào các cột sao cho hợp lí
										--CONSTRAINT TRÊN DATA / CELL/ COLUMN
SELECT * FROM StudentV1

--CÚ NGUY HIỂM NÀY CÓ LỚN HƠN!!!!
--TRÙNG MÃ SỐ KO CHẤP NHẬN ĐƯỢC , KO XĐ ĐC 1 SV--GÀI RÀNG BUỘC QUAN TRỌNG NÀY
											 --CỘT MÀ VALUE CẤM TRÙNG TRÊN MỌI CELL	CÙNG CỘT
											 --Dùng làm chìa khóa /key để tìm ra/mở ra/xđ duy nhất 1 info
											 --1 dòng / 1 sv, 1entity /1 Object
											 --CỘT NÀY ĐC GỌI LÀ PRIMARY KEY
INSERT INTO StudentV1( LastName, FirstName, StudentID) 
			VALUES ( N'Đỗ', N'Giang', 'SE123460') 


SELECT * FROM StudentV1 WHERE StudentID = 'SE123460'

--Gài thêm cách đưa data vào table để ko có những hiện tượng bất thường, 1 dòng trống trơn, key trùng
--key null- default thiết kế cho phép null tất cả
--gài- CONSTRAINTS
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY,--Bao hàm luôn  NOT NULL -- bắt buộc đưa data, cấm trùng 
	LastName nvarchar(40) NOT NULL, --tại sao ko gộp full name
	FirstName nvarchar(10) NOT NULL,--n : lưu kí tự Unicode tiếng việt(* đỏ) registration/sign-up
	DOB datetime,
	Address nvarchar(50)

)

INSERT INTO StudentV2 VALUES ('SE123456', N'Nguyễn', N'An','2003-1-1', N'...TP.Hồ Chí Minh' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN

SELECT * FROM StudentV2
--thử coi qua mặt được không??
INSERT INTO StudentV2( StudentID,LastName, FirstName) 
			VALUES ( NULL, NULL, NULL) --gẫy

INSERT INTO StudentV2( StudentID,LastName, FirstName) 
			VALUES ( 'AHIHI', NULL, NULL) --gẫy

--Coi có được trùng mã số sinh viên hay không
INSERT INTO StudentV2 VALUES ('SE123456', N'Nguyễn', N'An','2003-1-1', N'...TP.Hồ Chí Minh' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN
--thử tiếp PK
INSERT INTO StudentV2 VALUES ('GD123456', N'Nguyễn', N'An','2003-1-1', N'...TP.Hồ Chí Minh' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN

INSERT INTO StudentV2 VALUES ('SE123457', N'Lê', N'Bình','2003-2-1', NULL ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN

INSERT INTO StudentV2 VALUES ('SE123458', N'Võ', N'Cường',NULL, NULL ) --OKIE

INSERT INTO StudentV2(StudentID, LastName, FirstName) 
			VALUES ('SE123459', N'Trần', N'Dũng') 

INSERT INTO StudentV2(StudentID, LastName, FirstName) 
			VALUES (NULL, NULL, NULL, NULL, NULL) --gãy 3 chỗ null


CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY,--Bao hàm luôn  NOT NULL -- bắt buộc đưa data, cấm trùng 
	LastName nvarchar(40) NOT NULL, --tại sao ko gộp full name
	FirstName nvarchar(10) NOT NULL,--n : lưu kí tự Unicode tiếng việt(* đỏ) registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL -- Thừa chữ null, do default là vậy

)

CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL,--Bao hàm luôn  NOT NULL -- bắt buộc đưa data, cấm trùng 
	LastName nvarchar(40) NOT NULL, --tại sao ko gộp full name
	FirstName nvarchar(10) NOT NULL,--n : lưu kí tự Unicode tiếng việt(* đỏ) registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- Thừa chữ null, do default là vậy
	PRIMARY KEY(StudentID)
)
INSERT INTO StudentV4 VALUES ('SE123456', N'Nguyễn', N'An','2003-1-1', N'...TP.Hồ Chí Minh' ) --Đưa hết vào các cột, SV FULL KO CHE THÔNG TIN
SELECT * FROM StudentV4

--GENERATED TỪ ERD TRONG TOOL THIẾT KẾ
CREATE TABLE Studentv5 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  PRIMARY KEY (StudentID));

--POWER DESIGNER VS VISUAL PARADIGM
-- Đức -SAP
----------------------------------------------------
--Học thêm về cái CONSTRAINTS - TRONG ĐÓ PK CONSTRAINT
--Ràng buộc là cách ta/db design ép cell nào đó/cột nào đó value phải ntn
--Đặt ra quy tắc/rule cho việc nhập data
--Vì có nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soát ta có quyền 
--Đặt tên cho các quy tắc ,constraint name
--Ví dụ:Má ở nhà đặt quy tắc/nội quy cho mình
--Rule #1: Vào SG học thật tốt nha con. Tốt: điểm tb >= 8.0 && ko rớt môn nào
--                && và 9 học kì ra trường && ko đổi chuyên ngành

--Rule #2:Tối đi chơi về nhà sớm. Sớm : trong tối cùng ngày, trước 10h khuya

--Rule #3:???
--Tên rb/quy tắc             nội dung/cái data đc gài vào
--PK_ ???					  PRIMARY KEY
--Mặc đinh các DB engine nó tự đặt tên các RB nó thấy khi bạn
--gõ lệnh DDL 
--DB En cho mình cơ chế tự đặt tên RB

CREATE TABLE StudentV6
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	--PRIMARY KEY(StudentID)--tự db engine đặt tên cho rb
	CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID)
)

--Dân PRO ĐÔI KHI CÒN LÀM CÁCH SAU, NGƯỜI TA RB KHÓA CHÍNH , KHÓA NGOẠI
--RA HẲN CẤU TRÚC TABLE, TỨC LÀ CREATE TABLE CHỈ CHỨA CẤU TRÚC - CỘT - DOMAIN
--TẠO TABLE XONG RỒI CHỈNH SỬA TABLE - SỬA CÁI TỦ CHỨ , KO PHẢI DATA TRONG TỦ

DROP TABLE StudentV7
CREATE TABLE StudentV7
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	--PRIMARY KEY(StudentID)--tự db engine đặt tên cho rb
	--CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)
)

ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)


--XÓA 1 RB ĐƯỢC KO, CHO ADD THÌ CHO DROP
ALTER TABLE StudentV7 DROP CONSTRAINT PK_STUDENTV7 

ALTER TABLE StudentV2 DROP CONSTRAINT PK__StudentV__32C52A7947032F60

