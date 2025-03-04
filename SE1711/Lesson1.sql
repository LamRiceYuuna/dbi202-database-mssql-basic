--Comment:
--Infomation:
--Data:
--DataBase:Kho lưu trữ dữ liệ có liên quan đến nhau hoặc đến 1 chủ đề nào đó.
--Tạo Database:

create database SE1711;
--Sử dụng database:
use SE1711;

--Xóa DB:
use master;
go --Thực hiện lô lệnh (batch)
drop database SE1711;
--Sửa DB:

alter database ĐB_SE1711 modify name=SE1711;

--Sử dụng bảng(Table) để lưu trữ các loai dữ liệu khác nhau.
--Tạo bảng:
create table Product(
	id int,
	NameProduct nvarchar(30),
	price float,
	quantity int

);

--Thêm 1 cột chứa mã thương hiệu:
alter table Product add BrandID int ;
alter table Product alter column BrandID int not null;
--Thêm cột cho bảng:
use SE1711
alter table Product add viewed int;

--Sửa kiểu dữ liệu cho cột:
alter table Product alter column viewed bigint;

--Sửa tên cột:
exec sp_rename 'Product.viewed', 'luotxem'; --Thủ tục lưu trữ

--Xóa cột:
alter table Product drop column luotxem;

--Xóa bảng:
drop table Product;

create table Brand(
	id int not null,
	NameBrand varchar(20),

);
--Primary Key(PK): Khóa chính: Đảm bảo tính toàn vẹn dữ liệu.
alter table Brand add constraint pk_id primary key (id);

alter table Product add constraint pk_id_Product primary key (id);

--Foreign Key(FK): Khóa ngoại: Đảm bảo tính toàn vẹn tham chiếu.
alter table Product add constraint fk_brandid foreign key(BrandID) references Brand(id);

--Insert (Chèn) dữ liệu: Phải insert dữ liệu vào bảng PK trước ,FK sau

insert Brand values
  (1, 'Dell'),
  (2, 'Apple'),
  (3, 'Samsung');
select * from Brand

insert Product values
  (1, 'Dell M3800', 23000000, 500, 1),
  (2, 'Apple MacBook Pro 2022', 31000000, 67, 2)

select * from Product

--Ràng buộc Check: Dùng để validate dữ liệu
SELECT * FROM Product
ALTER TABLE Product ADD CONSTRAINT ck_price CHECK ( price > 0)
INSERT Product values ( 3, 'Samsung 2022', 250000000, 100, 3);

--Ràng buộc Default: Dùng thiết lập giá trị mặc định cho cột tương ứng
--nếu cột đó không đc chèn dữ liệu
insert Product(id, NameProduct,BrandID) values (4, 'BPhone 4')

ALTER TABLE Product ADD CONSTRAINT df_quantity default(0) for quantity

insert Product(id, NameProduct,) values (5, 'vSmart')

--Ràng buộc Unique: Dùng để đảm bảo rằng cột tương ứng chỉ chứa những 
--giá trị duy nhất, không trùng lặp.

create table Student (
	id int not null,
	name nvarchar(30),
	mobile varchar(11),
	email varchar(30)
	);
ALTER TABLE Student ADD CONSTRAINT pk_id_student primary key(id);
ALTER TABLE Student ADD CONSTRAINT un_moblie unique(mobile);
ALTER TABLE tudent ADD CONSTRAINT un_email unique(email)
INSERT Student VALUES
		(1, 'Alex', '0987654321', 'alex@gmail.com'),
		(2, 'Victoria', '0987654321', 'alex@gmail.ocm'

