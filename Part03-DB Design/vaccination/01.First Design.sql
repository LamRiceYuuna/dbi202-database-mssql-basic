--THIẾT KẾ ĐẦU TIÊN: GOM TẤT CẢ TRONG 1 TABLE
--Đặc điểm chính là cột, value đđ chính là cell
--Thông tin chích ngừa bao gồm: tên: An Nguyễn , cccd: 123456789, 

create database DBDESIGN_VACCINATION
use DBDESIGN_VACCINATION

create table VaccinationV1
(
	ID char(11) primary key,
	LastName nvarchar(30),
	FirstName nvarchar(10), --sort heng, FullName là sort họ đó
	Phone varchar(11) not null unique, -- constraint , cấm trùng nhưng không phải PK
									 --key ứng viên, candidate key 
	InjectionInfo nvarchar(255)								 

)

--cách thiết kế này lưu trữ các mũi chích của mình đc không? --Được
select * from VaccinationV1

insert into VaccinationV1 values('00000000001', N'Nguyễn', N'An', '090X',N'AZ Ngày 28.9.2021 ĐH FPT | AZ Ngày 28.10.2021 BV LÊ VĂN THỊNH, Q,TĐ ')

--PHÂN TÍCH:
--ƯU: DỄ LƯU TRỮ, SELECT , CÓ NGAY, đa trị tốt trong vụ này!!
--NHƯỢC: THỐNG KÊ ÉO ĐƯỢC, ÍT NHẤT ĐI CẮT CHUỖI, CĂNG!!!, BỊ CĂNG DO ĐA TRỊ

--SOLUTION:CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LIỆU (? MŨI , AZ BAO NHIÊU NGƯỜI..)
--TÁCH CỘT , TÁCH BẢNG

create table VaccinationV2
(
	ID char(11) primary key,
	LastName nvarchar(30),
	FirstName nvarchar(10), --sort heng, FullName là sort họ đó
	Phone varchar(11) not null unique, -- constraint , cấm trùng nhưng không phải PK
									 --key ứng viên, candidate key 
	Dose1 nvarchar(100),--AZ, Astra, Astra .... 25.9.2021, DH FPT --COMPOSITE (phức hợp)
	Dose2 nvarchar(100) --AZ, AZ,.....

)
--Phân tích:
--*Ưu : gọn gàng, select gọn gàng
--*Nhược: NULL!!!, THÊM MŨI NHẮC 3,4 HÀNG NĂM THÌ SAO ??
--			CHỈ VÌ VÀI NGƯỜI , MÀ TA PHẢI CHỪA CHỖ NULL
-- THỐNG KÊ !!! CỘT COMPOSITE CHƯA CHO MÌNH ĐC THỐNG KÊ




--Multi-valued: một cell chứa nhiều info độc lập bình đẳng về ngữ nghĩa
--						Ví dụ: 1/1 LL, Q.1, TP.HCM;1/1 Man Thiện,TP.TĐ
--									thường trú          tạm trú
--				Gói compo, nhiều đồ trong 1 cell
--				đọc : có 2 địa chỉ	

--COMPOSITE VALUE CELL: Một value duy nhất, mỗi value này lại gom nhiều miếng nhỏ hơn
--										mỗi miếng nhỏ hơn, mỗi miếng lại có 1 vai trò riêng
--										gom chung lại thành 1 thứ khác
--									Address: 1/1 Man Thiện , P.5, TP.HCM
--									FullName : Hoàng Ngọc  Trinh -> cả tên gọi đầy đủ
--											   first  last  midd


--Vì số lần chích còn có thể gia tăng cho từng người mũi 2, mũi nhắc, mũi thường niên
--ai chính nhiều thì nhiều dòng

create table PersonV3
(
	ID char(11) primary key,
	LastName nvarchar(30),
	FirstName nvarchar(10), --sort heng, FullName là sort họ đó
	Phone varchar(11) not null unique, -- constraint , cấm trùng nhưng không phải PK
									 --key ứng viên, candidate key 

)
--Composite gộm n info vào trong 1 cell, dễ, nhanh là ưu điểm, nhập 1 chuỗi dài là xong
--Nhược: éo thống kê tốt, éo sort đc 
--   FullName sort làm sao đc
--COMPOSITE SẼ TÁCH CỘT, vì mình đã cố trước đó gom n thứ khác nhau để làm ra 1 thứ khác
--		tách cột sẽ trả lại đúng ngữ nghĩa cho từng thằng	


create table VaccinationV3
(
	Dose nvarchar(100),
	PersonID char(11) references PersonV3(ID),
	
)
--Phân tích : 	
--*ưu: chích thêm nhát lào thêm dòng nhát đó , chấp 10 mũi luôn, ko ảnh hưởng người chưa chính
--*nhược: thống kê vẫn éo được
--composite tách thành cột cột cột, trả lại đúng ý nghĩa cho từng biến nhỏ
--mieensg nhỏ


create table PersonV4
(
	ID char(11) primary key,
	LastName nvarchar(30),
	FirstName nvarchar(10), --sort heng, FullName là sort họ đó
	Phone varchar(11) not null unique, -- constraint , cấm trùng nhưng không phải PK
									 --key ứng viên, candidate key 

)

create table VaccinationV4
(
	--Dose nvarchar(100),
	--tách cột hoy
	Dose int, --liều chích số 1 
	InjDate datetime,
	Vaccine nvarchar(50),
	Lot nvarchar(20),
	[Location] nvarchar(20),
	PersonID char(11) references PersonV4(ID),	
)

insert into PersonV4 values('00000000001', N'Nguyễn', N'An','090x')
insert into PersonV4 values('00000000002', N'Lê', N'Bình','091x')
SELECT * FROM PersonV4

insert into VaccinationV4 
	values(1, GETDATE(), 'AZ', NULL, NULL, '00000000001')

select * from VaccinationV4

--in ra xanh vàng cho mỗi người
SELECT * FROM PersonV4 p left join VaccinationV4 v
		on p.ID = v.PersonID

SELECT p.ID,p.FirstName,COUNT(*) as 'No Doses' FROM PersonV4 p left join VaccinationV4 v
		on p.ID = v.PersonID
		group by p.ID,p.FirstName --chết mẹ count(*)
								 --bình có 1 dòng kha khá null

SELECT p.ID,p.FirstName,COUNT(v.Dose) as 'No Doses' FROM PersonV4 p left join VaccinationV4 v
		on p.ID = v.PersonID
		group by p.ID,p.FirstName

--ĂN TIỀN XANH ĐỎ
SELECT p.ID,p.FirstName, IIf(COUNT(v.Dose) = 0, 'NOOP', 
							IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN'))
						AS STATUS
FROM PersonV4 p left join VaccinationV4 v
		on p.ID = v.PersonID
		group by p.ID,p.FirstName


insert into VaccinationV4 
	values(2, GETDATE(), 'AZ', NULL, NULL, '00000000001')

