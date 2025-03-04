-- Mỗi giảng viên có thể tổ chức nhiều seminar/buổi phụ đạo khác nhau và 
 -- mỗi seminar/buổi phụ đạo 
 -- chỉ do một giảng viên phụ trách  
 -- Thông tin lưu trữ bao gồm: mã số giảng viên, tên giảng viên,
 -- email, phone, bộ môn (SE, CF, ITS, Incubator), 
 -- ngày giờ seminar/phụ đạo, loại hình tổ chức 
 -- (seminar, phụ đạo, workshop), chủ đề, tóm tắt nội dung, 
 -- phòng học (nếu tiến hành offline), online-link 
 -- (nếu tiến hành online), sĩ số dự kiến


 --Chiến lược: gom tất cả vào 1 bảng
 --Xem: đa trị , composite , lookup, lặp lại trên 1 nhóm cột 
 --tách thêm dòng tốt hơn thêm cột (khi cần thêm data)

 create DATABASE DBDESIGN_ACTIVITIES
 
 create table activity_V1
 (
	LectID char(8),
	LecName nvarchar(30), --composite, tách nếu mún sort
	Email varchar(50),
	Phone char(11),
	Major varchar(30),
	StartDate datetime, --ngày giờ bắt đầu
	ActType nvarchar(30), --workshop, seminar, phụ đạo
	Topic nvarchar(30),-- Gioi thiệu về Array List
	Intro nvarchar(250),
	Room nvarchar(50), --lưu hyperlink của Zoom , Meet, phòng
	Seats int

 )

 SELECT * FROM activity_V1
 insert into activity_V1 
	values('00000001', N'Hòa.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-03', 'Seminar', N'Nhập môn Machine Learning', N'......',
									N'Phòng seminar thư viện ĐH FPT HCM', 100);

insert into activity_V1 
	values('00000001', N'Hòa.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-03', 'seminar', N'Giới thiệu về YOLO V4', N'......',
									N'Phòng seminar thư viện ĐH FPT HCM', 100);


insert into activity_V1 
	values('00000001', N'Hòa.ĐNT', 'hoadnt@', '090x', 'CF', '2021-11-03 08:00:00', 'workshop', N'Giới thiệu về YOLO V4 (part 2)', N'......',
									N'Phòng seminar thư viện PUHCM', 100);

 SELECT * FROM activity_V1

 --ưu điểm & nhược điểm
 

 create table LECTURER_V2 
 (
	LectID char(8) primary key,
	LecName nvarchar(30), --composite, tách nếu mún sort
	Email varchar(50),
	Phone char(11),
	Major varchar(30)
 )

  create table activity_V2
 (
	SEQ int identity primary key,
	StartDate datetime, --ngày giờ bắt đầu
	ActType nvarchar(30), --workshop, seminar, phụ đạo , coi chứng gõ WORK SHOP
						-- mùi của lookup

	Topic nvarchar(30),-- Gioi thiệu về Array List
	Intro nvarchar(250),
	Room nvarchar(50), --lưu hyperlink của Zoom , Meet, phòng
	Seats int,
	LectID char(8) references LECTURER_V2 (LectID)

 )
 insert into LECTURER_V2 
	values('00000001', N'Hòa.ĐNT', 'hoadnt@', '090x', 'CF' );


 insert into activity_V2 
	values('2021-11-03 08:30:00', 'Seminar', N'Nhập môn Machine Learning', N'......',
									N'Phòng seminar thư viện ĐH FPT HCM', 100, '00000001');

insert into activity_V2 
	values('2021-11-03 14:30:00', 'seminar', N'Giới thiệu về YOLO V4', N'......',
									N'Phòng seminar thư viện ĐH FPT HCM', 100, '00000001');


insert into activity_V2 
	values('2021-11-03 08:00:00', 'workshop', N'Giới thiệu về YOLO V4 (part 2)', N'......',
									N'Phòng seminar thư viện PUHCM', 100, '00000001');

select * from LECTURER_V2
select * from activity_V2

 create table Major_V3
(
	Major varchar(30) primary key,
	MajorName varchar(35)
 )
 create table LECTURER_V3 
 (
	LectID char(8) primary key,
	LecName nvarchar(30), --composite, tách nếu mún sort
	Email varchar(50),
	Phone char(11),
	Major varchar(30) references Major_V3(Major)
 )



 create table ActiveType
 (
	ActType nvarchar(30) primary key	
 )

  create table activity_V3
 (
	SEQ int identity primary key,
	StartDate datetime, --ngày giờ bắt đầu
	ActType nvarchar(30) references ActiveType(ActType), --workshop, seminar, phụ đạo , coi chứng gõ WORK SHOP
						-- mùi của lookup

	Topic nvarchar(30),-- Gioi thiệu về Array List
	Intro nvarchar(250),
	Room nvarchar(50), --lưu hyperlink của Zoom , Meet, phòng
	Seats int,
	LectID char(8) references LECTURER_V3 (LectID)

 )
