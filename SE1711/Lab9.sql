--1.
create database RangDong
use RangDong

create table Sach
(
	MaSach int not null identity primary key,
	TenSach varchar(30),
	TacGia varchar(20),
	NhaXB varchar(15),
	ChuDe varchar(20), 
	DonGia int,
	TrongKho int
)

insert Sach(TenSach, TacGia, NhaXB, ChuDe, DonGia, TrongKho) values
	('Hoang hon tren song', 'Gia Phong', 'Van hoa', 'Tinh yeu', 120, 11),
	('Cay lua nuoc', 'Le May', 'KHKT', 'Khoa hoc', 30, 24),
	('Tam ly truoc mua thi', 'Hai Dang', 'Giao duc', 'Tam ly', 42, 32);

select * from Sach

create table KhachHang
(
	MaKH int not null identity primary key,
	TenKH varchar(20),
	DiaChi varchar(30),
	Quan varchar(20),
	DienThoai varchar(11),
	NguoiGT varchar(20)
)

insert KhachHang(TenKH, DiaChi, Quan, DienThoai, NguoiGT) values
	('Le Cong', '22 Hang Buom', 'HoanKiem', '098123654', 'Hoang Kim'),
	('Van Nghe', '19 Lo Duc', 'HoanKiem', null, null ),
	('Tran Thong', '19 Doi Can', 'Ba Dinh', null, null ),
	('Hoang Tin', '38 Linh Lam', 'Hoang Mai', null, null );

select * from KhachHang


create table SachBan
(
	SoHD int not null identity primary key,
	MaKH int foreign key references KhachHang(MaKH),
	MaSach int foreign key references Sach(MaSach),
	NgayMua date,
	DonGia int,
	SoLuong int
)

insert SachBan(MaKH, MaSach, NgayMua, DonGia, SoLuong) values 
	(1, 2, '11/22/2006', 30, 5),
	(1, 3, '07/15/2006', 23, 4),
	(2, 1, '05/24/2006', 32, 7),
	(3, 1, '11/15/2006', 27, 9);

select * from SachBan