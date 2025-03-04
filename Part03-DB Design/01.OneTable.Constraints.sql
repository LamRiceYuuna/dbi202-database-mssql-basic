--PHẦN NÀY THÍ NGHIỆM VỀ CÁC LOẠI RẰNG BUỘC 
-- CONSTRAINTS --QUY TẮC GÀI TRÊN DATA

--1.RÀNG BUỘC PRIMARY KEY
--tạm thời chấp nhận Pk là 1 cột(tương lai có thể là nhiều cột) mà giá trị
-- của nó trên mọi dòng/mọi cell của cột này ko trùng lại, mục đích dùng để
--WHERE ra đc 1 dòng duy nhất
--VALUES CỦA KEY CÓ THỂ ĐƯỢC TẠO RA THEO 2 CÁCH
--CÁCH 1 : TỰ NHẬP = TAY, DB ENGINE SẼ TỰ KIỂM TRA GIÙM MÌNH CÓ TRÙNG HAY KO??
--		NẾU TRÙNG DB ENGINE TỰ BÀO VI PHẠM OK CONSTRANIT - HỌC RỒI UI/UX

--CÁCH 2:ÉO CẬN NHẬP = TAY CÁI VALUE CỦA PK, MÁY /DB ENGINE TỰ GENERATE CHO
--  MÌNH 1 CON SỐ KO TRÙNG LẠI!!! CON SỐ TỰ TĂNG, CON SỐ HEXA...

--THỰC HÀNH
--thiết kế table lưu thông tin đăng kí event nào đó(giống đk qua Google Form)
--tt cần lưu trữ: số thứ tự đk, tên full name, email, ngày giờ đk. sđt ,..
 --*Phân tích :
 --ngày giờ đki: ko bắt nhập, default
 --số thứ tự : nhập vào là bậy r!! tự gán chứ!!
 --email, phone: ko cho trùng heng, 1 email 1 lần đk
 --...... 
 USE DBDESIGN_ONETABLE
 /*CREATE TABLE Registration
 (
	SEQ int PRIMARY KEY,--Phải tự nhập số thứ tự, vớ vẩn
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),--CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegDate date DEFAULT GETDATE(),--CONSTRAINT DEFAULT

 )*/
 DROP TABLE Registration
  CREATE TABLE Registration
 (
	SEQ int PRIMARY KEY IDENTITY,--Phải tự nhập số thứ tự, vớ vẩn
								--mặc định đi từ 1, nhảy ++ cho người sau
								--ghi rõ IDENTITY(1, 1)
								--IDENTITY(1, 5) từ 1, 6, 11, 16...
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),--CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegDate datetime DEFAULT GETDATE(),--CONSTRAINT DEFAULT

 )
 --Đăng kí event
 INSERT INTO Registration VALUES(N'AN', N'Nguyễn', 'an@.....', '090x')--báo lỗi ko map được các cột rõ ràng

 INSERT INTO Registration VALUES(N'AN', N'Nguyễn', 'an@.....', '090x', null)
 
  INSERT INTO Registration(LastName, FirstName, Email, Phone) 
  VALUES(N'Bình', N'Lê', 'binh@.....', '091x')

 SELECT * FROM Registration

 --Xóa 1 dòng có auto generated key, thì table sẽ lủng số ,DB ENGINE ko lắp chỗ lủng
 --1 2 3 4 5 6 , xóa 3 đi , còn 1 2 4 5 6, đk tiếp tính từ 7





