create database DBDESIGN_VNLOCATIONS

use DBDESIGN_VNLOCATIONS
--Thiết kế  csdl lưu đc thông tin phường/xã, quận/huyện, tỉnh/thành phố
--Chính là 1 phần của địa chỉ đc tách ra do nhu cầu thống kê
--nó là 1 phần của Composite field
--|SEQ|Dose|InjDate|Vaccine(PK LK)|Lot |Địa chỉ chích - composite|
--|SEQ|Dose|InjDate|Vaccine(PK LK)|Lot |Số nhà|Phường-Quận-Tỉnh|

--Xét riêng phường -quận- tỉnh rõ ràng 3 cột lookup

create table Locations
(
	province nvarchar(30),
	district nvarchar(30),
	ward nvarchar(30)
)
select * from Locations

--PHÂN TÍCH TABLE
--1.TRÙNG LẶP CUM INFO TỈNH- QUẬN
--2. LOOKUP TRÊN PROVINCE, DISTRICT (WARD)
--3.Sự phụ thuộc logic giữa tỉnh và district (ward)
--   FUNCTIONAL DEPENDENCY -FD - PHỤ THUỘC HÀM
--CÓ 1 CÁI ÁNH XẠ, MỐI QUAN HỆ GIỮA A VÀ B, PROVINCE VS DISTRICT
--Cứ chọn TP.HCM ->Q1,Q2,Q3,..
--			ĐN   -> BH,LBT,LK,...
-- Y = F(X) = X^2 , CỨ CHỌN F(2) -> 4

--TÁCH LOOKUP VÌ DỄ NHẤT
--ra 1 table, phần còn lại fk sang lookup

--vaccination(liều chích, tên vaccine)
								--	FK sang Vaccine(tên-vaccine) 


-- chỉ lookup 63 tỉnh thành	

create table Provice
(
	PName nvarchar(30)
)
select * from Provice
select * from Locations -- 10581 dòng ứng với 10851 xã/phường khác nhau
						--nhưng chỉ có 63 tỉnh thành lặp lại
select distinct province from Locations --giống cục thống kê
--dùng nó để insert sang tale lookup 

--C1:
insert into Provice values(N'Thành phố Cần Thơ')
insert into Provice values(N'Tỉnh Vĩnh Long')

DELETE FROM Provice

--c2:
insert into Provice values(N'Thành phố Cần Thơ'),(N'Tỉnh Vĩnh Long')

--C3:Tuyệt chiêu insert thứ 3 --coppy paste đã học cho 10k dòng

--C4:Tuyệt chiêu insert thứ 4: ta xài kiểu sub-query trong lệnh insert into
insert into Provice select distinct province from Locations
select * from Provice
delete Provice
select COUNT(*) from Locations --10581 xã phường
select COUNT(distinct province) from Locations

--tạo table lookup quận/huyện

create table District
(
	DName nvarchar(30)
)
--có bn quận ở vn ?
select COUNT(distinct district) from Locations--683 dòng, 683 quận khác nhau
--rất cẩn thận khi chơi vớ quận/huyện
--tiền giang, vĩnh long, trà vinh, đều có huyện"châu thành"
--bảng district chỉ có  1 châu thành , lát hồi!!
--PK của District ko thể là tên của quận đc!!!

--chèn vào table quận
insert into District select distinct district from Locations
select * from District


--PROVINCE và District có sự phụ thuộc lẫn nhau từ thằng này suy ra đc thằng kìa
--Nhìn quận có thể đoán T/P (chiều này ko chắc an toàn)
		--Nhìn Châu Thành , sao đoán đc tỉnh??? ST, TV, VL
		--			
--Nhìn T/P đoán ra quận (Hợp lí về suy luận)
		-- VL --> MANG THÍT, VL, CHÂU THÀNH
		-- ST --> ............., CHÂU THÀNH
--FD NÊN ĐỌC LÀ CITY --> DISTRICT
--Table chứa các FD kiểu phụ thuộc ngang giữa các cột --> suy nghĩ tách bảng
-- Tách thằng vế trái & phải, ra table khác!!!, tách xong thì phải FK cho thằng còn lại


--Sau khi tách ta có trong tay 3 table
--PROVINCE( PName)
--District ( Dname , PName(FK lên trên))
--WARD (WName phường lào , quận lào DName(FK lên trên))

--giải pháp "dở" cho huyện châu thành của tỉnh miền tay !!! ta sẽ làm sau
--dùng nature key. key tự nhiên --dùng tên của tỉnh, huyện làm key
--dùng key tự gán, tự tăng, key thay thế, key giả (surrogate key/artificial key)
drop table Provice
drop table District

create table Province
(
	PName nvarchar(30) PRIMARY KEY
)
insert into Province select distinct province from Locations
select * from Province
District

create table District
(
	DName nvarchar(30) not null,--hok có 2 châu thành của 3 tỉnh miền tây
	--Quận nào vậy

	--và thuộc tỉnh/TP nào vậy
	PName nvarchar(30) not null references Province(PName)
					--tham chiếu để ko nhập tỉnh lung tung , tỉnh ahihi
	Primary key(DName, PName)
)						


insert into District select distinct district,province
			from Locations --699 quận, có rất nhiều Châu Thành có  tỉnh miền Tây

select * from District

--Hỏi thử: TPHCM có những Quận huyện nào ???

select DName from District where PName = N'Thành phố Hồ Chí Minh'
select DName from District where PName = N'Tỉnh Long An'
select DName from District where PName = N'Tỉnh Bắc Giang'


--THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG , CÓ 10581 DÒNG
--ỨNG VỚI VÔ SỐ LẶP LẠI CÁC QUẬN , FK
--xã có trùng tên hem???
create table Ward
(
	WName nvarchar(30),
	-- xã phường ơi, bạn ở quận nào??
	DName nvarchar(30) --references District(DName)
)	
select * from Locations -- 10581 xã phường, liệu rằng có trùng??

select COUNT(distinct ward) from Locations --7884 đếm trùng xã đếm 1 lần, trùng đến 3000 tên phường

select ward from Locations order by ward

insert into Ward  select Ward,district from Locations
select  * from Ward

--cho tôi xem các phường của quận q1 TPHCM
SELECT * FROM Ward WHERE DName = N'Quận 1'
SELECT * FROM Ward WHERE DName = N'Huyện Hiệp Hòa'

--Huyện Châu Thành của Tiền Giang có những xã nào?? 23 xã
select w.WName, w.DName, d.PName from Ward w inner join District d 
		on w.DName = d.DName
		where d.DName = N'Huyện Châu Thành' 
		AND d.PName = N'Tỉnh Tiền Giang' 

SELECT * FROM Ward ORDER BY DName

--Huyện Ba Tri của Bến Tre có những xã nào?? 23 xã
select w.WName, w.DName, d.PName from Ward w inner join District d 
		on w.DName = d.DName
		where d.DName = N'Huyện Ba Tri' 
		AND d.PName = N'Tỉnh Bến Tre' 
