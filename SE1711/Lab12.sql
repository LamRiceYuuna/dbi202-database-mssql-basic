Create database BANHANG
use BANHANG


Create table NhaCungCap 
(
	MaNhaCC nvarchar(10) primary key,
	TenNhaCC nvarchar(40),
	DiaChi nvarchar(60),
	Phone nvarchar(24),
	Fax nvarchar(24),
	HomePage ntext
)

insert into NhaCungCap values
	(N'BAN', N'Cong ty Ban mai', N'64 Hang Bun', N'048286745', null, 'www.binhminh.com'),
	(N'OCE', N'Cong ty Ocean', N'26 Tran Quy Cap', N'048924712', null, 'www.ocean.com'),
	(N'RDO', N'Cong ty Rang Dong', N'97 Hoang Hoa Tham', N'048923711', null, 'www.rdong.com')

select *  from NhaCungCap

Create table KhachHang 
(
	MaKH nvarchar(10) primary key,
	TenKH nvarchar(30),
	DiaChi ntext,
	Phone nvarchar(24),
	Email nvarchar(30),
)

insert into KhachHang values
	(N'01', N'Hoa Binh', 'Ha Noi', N'0913567222', N'hb@fpt.vn'),
	(N'02', N'Quang Long', 'Ha Noi', N'048123445', N'qlong@Yahoo.com'),
	(N'03', N'Nguyen Tuan', 'Hai Phong', N'098467231', N'Tuan@yahoo.com')

select * from KhachHang

create table NhanVien
(
	MaNV nvarchar(10) primary key,
	HoTen nvarchar(20),
	ChucDanh nvarchar(30),
	NgaySinh smalldatetime,
	NgayNhanViec smalldatetime,
	DiaChi nvarchar(50),
	Phone nvarchar(20),
	Photo image,
	GhiChu ntext,
)

insert into NhanVien values
	(N'01', N'Lan Huong', N'Ban hang', '11-23-1980', '1-15-2004', N'Hoa Binh', N'0912349865', '<Binary>', NULL),
	(N'02', N'Bich Hue', N'Tiep thi', '12-31-1979', '1-22-2001', N'Quang Binh', N'098768324', '<Binary>', NULL),
	(N'03', N'Tung Chi', N'Ban hang', '8-9-1986', '1-14-2005', N'Hai Phong', N'098568253', '<Binary>', NULL),
	(N'04', N'Kien Cuong', N'Thu kho', '9-19-1979', '1-22-2003', N'Ha Noi', N'0912367299', '<Binary>', NULL)

select * from NhanVien

Create table LoaiSanPham
(
	MaLoaiSP nvarchar(10) primary key,
	TenLoaiSP nvarchar(15),
	MoTa ntext
)

insert into LoaiSanPham values
	(N'DL', N'Dien lanh', null),
	(N'DT', N'Dien tu', null),
	(N'MP', N'Hang my pham', null),
	(N'TD', N'Hang tieu dung', null)

select * from LoaiSanPham

create table SanPham
(
	MaSP nvarchar(10) primary key,
	TenSP nvarchar(40),
	MaNhaCC nvarchar(10) references NhaCungCap(MaNhaCC),
	MaLoaiSP nvarchar(10) references LoaiSanPham(MaLoaiSP),
	DVT nvarchar(20),
	DonGia smallint,
	SoLuong smallint,
	SoLuongTT smallint,
	Discontinued bit
)

insert into SanPham values
	(N'001', N'Vo tuyen', N'BAN', N'DT', N'Chiec', 4000, 25, 5, 0),
	(N'002', N'Radio', N'BAN', N'DT', N'Chiec', 200, 150, 20, 0),
	(N'003', N'CD player', N'BAN', N'DT', N'Chiec', 2000, 45, 10, 0),
	(N'004', N'Tu lanh', N'RDO', N'DL', N'Chiec', 6000, 22, 5, 0),
	(N'005', N'May lam kem', N'RDO', N'DL', N'Chiec', 7000, 19, 4, 0),	
	(N'007', N'May dieu hoa', N'RDO', N'DL', N'Chiec', 9000, 38, 7, 0),
	(N'008', N'Xa phong thom', N'OCE', N'TD', N'Banh', 6, 200, 50, 0),
	(N'009', N'Duong', N'OCE', N'TD', N'Kg', 9, 550, 50, 0),
	(N'010', N'Sua', N'OCE', N'TD', N'Hop', 120, 80, 20, 0),
	(N'011', N'Mi miliket', N'OCE', N'TD', N'Thung', 200, 56, 8, 0)

select * from SanPham

create table HoaDon
(
	MaHD nvarchar(10) primary key,
	MaKH nvarchar(10) references KhachHang(MaKH),
	MaNV nvarchar(10) references NhanVien(MaNV),
	NgayLapHD smalldatetime,
	NgayNhanHang smalldatetime,
	Tien int,
	Thue real,
	TongSoTien int,
)

insert into HoaDon values
	(N'01', N'02', N'01', '12-14-2007', '12-15-2007', 0, 0.05, 0),
	(N'02', N'01', N'01', '1-19-2006', '2-15-2006', 0, 0.05, 0),
	(N'03', N'02', N'02', '10-30-2006', '1-1-2006', 0, 0.1, 0)

select * from HoaDon


create table HoaDonChiTiet 
(
	MaHD nvarchar(10) references HoaDon(MaHD),
	MaSP nvarchar(10) references SanPham(MaSP),
	DonGia int,
	SoLuong smallint,
	GiamGia real,
	ThanhTien int,
)

insert into HoaDonChiTiet values
	(N'03', N'003', 2000, 3, 0.02, 0),
	(N'03', N'007', 9000, 2, 0.01, 0),
	(N'03', N'011', 200, 10, 0, 0),
	(N'02', N'010', 120, 11, 0.04, 0),
	(N'02', N'002', 200, 2, 0.01, 0),
	(N'01', N'004', 6000, 1, 0.05, 0),
	(N'01', N'009', 9, 15, 0.04, 0)

select * from HoaDonChiTiet

--1.
update HoaDonChiTiet set ThanhTien = DonGia*SoLuong*(1-GiamGia);

select * from HoaDonChiTiet

--2.

select * from HoaDon
update HoaDon set Tien = 25700 where MaHD = '01'
update HoaDon set Tien = 1663 where MaHD = '02'
update HoaDon set Tien = 5829 where MaHD = '03'

update HoaDon set TongSoTien = Tien*(1+Thue)

--3.
select b.TenLoaiSP AS [Loại hàng],a.MaSP as [Mã hàng], a.TenSP as [Tên hàng] from SanPham a right join LoaiSanPham b 
			on a.MaLoaiSP = b.MaLoaiSP
			order by a.TenSP asc

--4.
select a.MaSP, a.TenSP , b.SoLuong  from SanPham a right join HoaDonChiTiet b
		on a.MaSP = b.MaSP

--5.
select a.MaSP, a.TenSP , b.ThanhTien from SanPham a right join HoaDonChiTiet b
		on a.MaSP = b.MaSP

--6.
select b.MaHD, b.MaSP, a.TenSP, b.DonGia, b.SoLuong, b.GiamGia, b.ThanhTien from SanPham a right join HoaDonChiTiet b
		on a.MaSP = b.MaSP
		where b.GiamGia > 0.01 and b.ThanhTien < 10000

--7.
select   b.MaKH,a.TenKH,a.Phone ,COUNT(b.MaHD) as [số hóa đơn] from KhachHang a right join HoaDon b on a.MaKH = b.MaKH
			group by b.MaKH,a.TenKH,a.Phone,b.NgayLapHD
			having b.NgayLapHD >= '3-1-1997' AND b.NgayLapHD <= '3-31-1997'
			order by a.TenKH asc

--8.

--Liệt kê danh sách các mặt hàng đã bán theo từng mặt hàng
select a.MaLoaiSP, a.TenLoaiSP , b.TenSP  from LoaiSanPham a right join SanPham b on a.MaLoaiSP = b.MaLoaiSP
								right join HoaDonChiTiet c on c.MaSP = b.MaSP
								right join HoaDon d on d.MaHD = c.MaHD
								order by a.MaLoaiSP
								
--Với mỗi loại hàng tính tổng số mặt hàng đã bán, tổng số tiền 
select a.MaLoaiSP, a.TenLoaiSP , SUM(c.SoLuong) [Số lượng đã bán] , SUM(c.ThanhTien) [Tổng tiền] from LoaiSanPham a right join SanPham b on a.MaLoaiSP = b.MaLoaiSP
								right join HoaDonChiTiet c on c.MaSP = b.MaSP
								right join HoaDon d on d.MaHD = c.MaHD
								group by a.MaLoaiSP,a.TenLoaiSP

 --Tổng sl và tổng tiền
select SUM(c.SoLuong) AS [Tổng số lượng đã bán],SUM(d.TongSoTien) as [Tổng tiền]  from LoaiSanPham a right join SanPham b on a.MaLoaiSP = b.MaLoaiSP
								right join HoaDonChiTiet c on c.MaSP = b.MaSP
								right join HoaDon d on d.MaHD = c.MaHD

--9.


select a.MaKH, a.TenKH , SUM(TongSoTien) [Tổng tiền đã mua]  from KhachHang a full join HoaDon b on a.MaKH = b.MaKH
				group by a.MaKH, a.TenKH, b.NgayLapHD
				having b.NgayLapHD >= '11-1-2006' and b.NgayLapHD <= '11-30-2006'

--10.

select a.MaNV, a.HoTen , SUM(b.TongSoTien) [Tổng tiền đã bán] from NhanVien a full join HoaDon b on a.MaNV = b.MaNV 
			group by a.MaNV, a.HoTen, b.NgayLapHD
			having b.NgayLapHD >= '11-1-2006' and b.NgayLapHD <= '11-30-2006'
				


								
								

		