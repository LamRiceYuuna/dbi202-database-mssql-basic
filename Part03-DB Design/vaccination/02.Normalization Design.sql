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


----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------
--Phân tích:
--Vì cột Vaccine cho phép gõ các giá trị tên VC một cách tự do -> inconnsistency
--AZ, Astra, AstraZeneca, Astra Zeneca
-->>> có mùi của dropdown, có mùi của combo box >>> Lookup table
-- ko cho gõ mà cho chọn từ danh sách có sẵn ...
--tham chiếu từ danh sách có sẵn
--Vaccine phải tách thành table Cha, table 1, và đám con đám N
--phải references về

create table PersonV5
(
	ID char(11) primary key,
	LastName nvarchar(30),
	FirstName nvarchar(10), --sort heng, FullName là sort họ đó
	Phone varchar(11) not null unique, -- constraint , cấm trùng nhưng không phải PK
									 --key ứng viên, candidate key 

)

insert into PersonV5 values('00000000001', N'Nguyễn', N'An','090x')
insert into PersonV5 values('00000000002', N'Lê', N'Bình','091x')

create table VaccineV5
(
	VaccineName varchar(30) primary key
	--hãng sx, địa chỉ hãng, thông tin lâm sàng...
)
select * from VaccineV5

--primary key mà là varchar() làm giảm hiệu năng về thực thi câu query
--chạy chậm. thường người ta sẽ chọn pk là con số là tốt nhất, tốt nhì là char
--sẽ giảng riêng 1 buổi về primary key (PK, FK, CK, SPK, NK, SRK-AK)

insert into VaccineV5 values('AstraZeneca')
insert into VaccineV5 values('Pfizer')
insert into VaccineV5 values('Verocell')
insert into VaccineV5 values('Moderna')

create table VaccinationV5
(	
	
	SEQ int identity primary key,--cứ tăng mãi mãi đi , 2 tỷ 1 mấy lần chích
	Dose int, --liều chích số 1 , 2 có thể lặp lại cho mỗi người , ko thể là PK
	InjDate datetime,
	Vaccine   varchar(30) references VaccineV5(VaccineName),--tên vaccine k cho gõ tự do, phải tham chiếu
	Lot nvarchar(20),
	[Location] nvarchar(20), -- nơi chích bản chất là COMPOSITE, tách thành cột city, quận , huyện
								--lại là lookup nếu muốn, thống kê tiện từng đơn vị
	PersonID char(11) references PersonV5(ID),	
)

--Chốt hạ : đa trị, hay composite dựa trên nhu cầu thống kê
--			nếu có của dữ liệu lưu trữ!!
--			gom bảng --> tim đa trị, tim composite, tìm lookup sau đó tách theo yêu cầu!!

insert into VaccinationV5 
	values(1, GETDATE(), 'AstraZeneca', NULL, NULL, '00000000001')

insert into VaccinationV5 
	values(2, '2021-12-20', 'AstraZeneca', NULL, NULL, '00000000001')
insert into VaccinationV5 
	values(3, '2021-12-20', 'az', NULL, NULL, '00000000001') --thất bại vì 
--ko có loại vaccine gõ tay AZ
--SEQ tăng mẹ nó thành số 3 và bị thất bại!!!
insert into VaccinationV5 
	values(1, '2021-12-20', 'Verocell', NULL, NULL, '00000000002')

SELECT * FROM VaccineV5
SELECT * FROM PersonV5
SELECT * FROM VaccinationV5
--thông kê đc những gì

--1. Có bn mũi AZ đã đc chích (chích bn nhát, ko care người)
--Output:loại vaccine, tổng số mũi đã chích
--2. Ngày x có bn mũi đã dc chích
--Output: ngày , tổng số mũi đã chích
--3. Thống kê số mũi chích của mỗi cá nhân
--Output:cccd, tên (full), di động, số mũi đã chích(0,1,2,3)
--4.In ra thông tin chích của mỗi cá nhân
--Output:cccd, tên (full),  di động,số mũi đã chích(0,1,2,3), màu sắc
--5.Có bn công dân đã chích ít nhất 1 mũi

--6.Những cd nào chưa chích mũi nào cả?
--Output :cccd, tên
--7.Công dân có CCCD X đã chích những mũi nào 
--Output: CCCD, Tên, thông tin chích(in gộp + chuỗi, tái nhập composite)

--8.Thống kế số mũi vaccine đã chích của mỗi loại vaccine
select b.VaccineName,COUNT(a.Dose) [Số mũi đã chích] 
	from VaccinationV5 a right join VaccineV5 b on a.Vaccine=b.VaccineName
	--where date chích là thống kê theo ngày
	--quận huyện nữa là thống kê theo ngày , quận
		group by b.VaccineName

		