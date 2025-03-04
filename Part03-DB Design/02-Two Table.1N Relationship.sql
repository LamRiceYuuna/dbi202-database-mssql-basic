CREATE DATABASE DBDEISN_ONEMANY
USE DBDEISN_ONEMANY

--TABLE 1 TẠO TRƯỚC, TABLE N TẠO SAU
CREATE TABLE MajorV1
(
	MajorID char(2) PRIMARY KEY, --mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)
--Chèn data - mua quần áo bỏ vào tủ
INSERT INTO MajorV1 VALUES('SE', N'Kĩ thuật phần mềm' )
INSERT INTO MajorV1 VALUES('IA', N'An toàn thông tin' )

SELECT * FROM MajorV1

DROP TABLE StudentV1
CREATE TABLE StudentV1
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	MajorID char(2)--tên cột khóa ngoại/tham chiếu ko cần trùng bên 1 -key
			   --Nhưng bắt buộc trùng 100% kiểu dữ liệu, cần tham chiếu
			   --Data hoy
	--PRIMARY KEY(StudentID)--tự db engine đặt tên cho rb

	CONSTRAINT PK_STUDENTV1 PRIMARY KEY (StudentID)
)

--Chèn data sinh viên
SELECT * FROM MajorV1
SELECT * FROM StudentV1
INSERT INTO StudentV1 VALUES ('SE1',N'Nguyễn', N'AN',NULL, NULL, 'SE')


--THIẾT KẾ TRÊN SAI VÌ ... KO CÓ THAM CHIẾU GIỮA MAJORID CỦA STUDENT  VS MAJOR PHÍA TRÊN

INSERT INTO StudentV1 VALUES ('SE2',N'Nguyễn', N'AN',NULL, NULL, 'AH')

DROP TABLE MajorV2
CREATE TABLE MajorV2
(
	MajorID char(2) PRIMARY KEY, --mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)
DROP TABlE StudentV2
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	--C1--MajorID char(2) REFERENCES MajorV2(MajorID)
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID)
	--tớ chọn chuyên ngành ở trên kia kìa, xin tham chiếu trên kia
)
INSERT INTO MajorV2 VALUES('SE', N'Kĩ thuật phần mềm' )
INSERT INTO MajorV2 VALUES('IA', N'An toàn thông tin' )

INSERT INTO StudentV2 VALUES ('SE1',N'Nguyễn', N'AN',NULL, NULL, 'SE')
INSERT INTO StudentV2 VALUES ('SE2',N'Nguyễn', N'AN',NULL, NULL, 'AH')
INSERT INTO StudentV2 VALUES ('SE2',N'Nguyễn', N'AN',NULL, NULL, 'gd')


SELECT * FROM StudentV2
--KO ĐC XÓA TABLE 1 NẾU NÓ ĐANG ĐC THAM CHIẾU BỞI THẰNG KHÁC
--Nếu có mối quan hệ 1-N, xóa N trước rồi xóa 1 sau

--------------------------------------------------------------
--Thêm kĩ thuật viết khóa ngoại
CREATE TABLE MajorV3
(
	MajorID char(2) PRIMARY KEY, --mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)
DROP TABLE StudentV3
/*CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	MajorID char(2),
	CONSTRAINT FK_StudentV3_MajorV3 
			FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
)*/



--TA CÓ QUYỀN GỠ RB ĐÃ THIẾT LẬP!!!
ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3

--BỔ SUNG LẠI 1 RÀNG BUỘC KHÁC
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)

SELECT * FROM MajorV3 --rỗng
SELECT * FROM StudentV3 --RỖNG

--INSERT LÀ CHẾT, DO THAM CHIẾU KO TỒN TẠI
INSERT INTO StudentV3 VALUES ('SE1',N'Nguyễn', N'AN',NULL, NULL, 'SE')

INSERT INTO MajorV3 VALUES('SE', N'Kĩ thuật phần mềm' )

INSERT INTO MajorV3 VALUES('AH', N'Ahihi Đồ Ngốk' )

INSERT INTO StudentV3 VALUES ('AH1',N'Lê', N'Vui Vẻ',NULL, NULL, 'AH')


--Thao tác mạnh tay trên data /món đồ quần áo trong tủ
--DML(UPDATE & DELETE)
DELETE FROM StudentV3--CỰC KÌ NGUY HIỂM KHI THIẾU WHERE, XÓA HẾT DATA

DELETE FROM StudentV3 WHERE StudentID ='AH1'

DELETE FROM MajorV3 WHERE MajorID ='AH'

--Gài thêm hành xử khi xóa, sửa data ở ràng buộc khóa ngoại/dình khóa
--chính luôn
--hiệu ứng domino, sụp đổ dây chuyền, 1 xóa , n đi sạch >>> CASCADE DELETE,
								--	1 SỬA , N BỊ SỬA THEO>>> CASCADE UPDATE
--NGAY LÚC DESIGN TALBE/ CREATE TABLE ĐÃ PHẢI TÍNH VỤ NÀY
--VẪN CÓ THỂ SỬA SAU NÀY KHI CÓ DATA , CÓ THỂ CÓ TROUBLE
--CUM LỆNH: CREATE/ALTER/DROP

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
--XÓA RB KHÓA NGOẠI BỊ THIẾU , VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XÓA SỬA DATA
SELECT * FROM MajorV3 --rỗng
SELECT * FROM StudentV3
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
						FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
						ON DELETE CASCADE
						ON UPDATE CASCADE

--update DML, mạnh mẽ, sửa data dang có
UPDATE MajorV3 SET MajorID = 'AK'--Cẩn thận nếu ko có where , toàn bộ table sẽ bị ảnh hưởng
								--trừ update cột key
								
UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

--Sụp đổ , xóa 1 , N đi sạch
--xóa chuyên ngành AHIHI xem sao???còn sv nào hk ko?

DELETE FROM MajorV3 WHERE MajorID = 'AK'--SV AH1 LÊN đường luôn

--CÒN 2 CÁI GÀI NỮA LIÊN QUAN ĐẾN TÍNH ĐỒNG BỘ NHẤT QUÁN DATA/CONSISTENCY
--SET NULL VÀ DEFAULT
--KHI 1 XÓA N về null
--khi 1 xóa n về default

SELECT * FROM MajorV3 --rỗng
SELECT * FROM StudentV3
--**chốt hạ: 
--Xóa bên 1 tức là biến mất bên 1, ko lẽ sụp đổ cả đám bên N,
--ko hay, nên chọn đưa bên N về NULL, 
--UPDATE bên 1, bên 1 vẫn con giữ dòng/row, bên N nên đồng bộ theo, ăn theo, cascade
ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
--XÓA RB KHÓA NGOẠI BỊ THIẾU , VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XÓA SỬA DATA
ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
						FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
						ON DELETE SET NULL--XÓA CHO MỒ CÔI, BƠ VƠ, NULL, TỪ TỪ TÍNH
						ON UPDATE CASCADE --SỬA ẢNH HƯỞNG DAY CHUYỀN

--CHO SINH VIÊN CHUYÊN NGÀNH VỀ HỌC SE luôn
UPDATE StudentV3 SET MajorID = 'SE'--TOÀNG TOÀN TRƯỜNG HK SE
UPDATE StudentV3 SET MajorID = 'SE'
					WHERE StudentID = 'AH1' --ĐÚNG

UPDATE StudentV3 SET MajorID = 'SE'
					WHERE MajorID is NULL

CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	MajorID char(2) DEFAULT 'SE',
	CONSTRAINT FK_StudentV3_MajorV3 
			FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
			ON DELETE SET DEFAULT 
			ON UPDATE CASCADE
)
--ALTER TABLE STUDENTV3 ADD CONSTRAINT..Ở TRÊN DONE
--CHO SV KO CHỌN CHUYÊN NGÀNH HỌC , HẮN HỌC J???
INSERT INTO StudentV3(StudentID, FirstName, LastName) VALUES ('SE2',N'Phạm', N'Bình')
DELETE FROM MajorV3 WHERE MajorID = 'AH'