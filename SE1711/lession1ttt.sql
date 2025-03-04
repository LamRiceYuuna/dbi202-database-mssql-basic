--Comment:
--Information: 
--Data
--DataBase: Kho dữ liệu có liên quan đến nhau hoặc đến 1 chủ đề nào đó.
--Tạo DataBase;

create database SE1711
--Sử dụng database:
use SE1711

--Xóa DB:
use master
go --Thực hiện lô lệnh (batch)
drop database SE1711

--Sửa DB:
alter database SE1711 modify name = DB_SE1711

--Sử dụng bảng (Table) để lưu trữ các loại dữ liệu khác nhau.
--Tạo bảng:
create table Product(
	id int,
	name nvarchar(30),
	price float,
	quantity int
)

--Them 1 cot chua ma thuong hieu
alter table Product add BrandId int

--Them cot cho bang
use DB_SE1711
alter table Brand add brandId int

--Sua kieu du lieu cho cot:
alter table Product alter column viewd bigint;

--Sua ten cot:
exec sp_rename 'Product.viewd', 'luotXem'; --thu tuc luu tru

--xoa cot
alter table Product drop column luotXem;

--xoa bang
drop table Brand

create table Brand(
	id int not null,
	name varchar(20),
)

--Primary Key (PK): Khoa chinh: Dam bao tinh tian ven du lieu
alter table Brand add constraint pk_id primary key(id)
alter table Product add constraint pk_id_brand primary key(id)
alter table Product alter column id int not null

--Foreign Key (FK): Khoa ngoai: Dam bao tinh toan ven tham chieu
alter table Product add constraint fk_brandid foreign key(brandId)
	references Brand(id);

--Insert (Chen) du lieu: Phai insert du lieu vao bang PK truoc, FK sau
insert Brand values
	(1, 'Dell'),
	(2, 'Apple'),
	(3, 'Samsung');
select	* from Brand;

insert Product values
	(1, 'Dell M3800', 23000000, 50, 1),
	(2, 'MacBook Pro 2022', 31000000, 67, 2)
select	* from Product;

--Rang buoc check: Dung de validate du lieu

use DB_SE1711
select
	* 
from
	Product

alter table Product add constraint ck_price check(price > 0)
insert Product values (3, 'Samsung 2022', 25000000, 100, 3)
	
--Rang buoc default: Dung de thiet lap gia tri mac dinh cho cot 
--tuong ung neu cot do khong duoc chen du lieu
insert Product(id, name) values (4, 'BPhone 4')
alter table Product add constraint df_quantity default(0) for quantity
insert Product(id, name) values (5, 'VSmart')


--Rang buoc Unique: Dung de dam bao rang cot tuong ung chi chua
--nhung gia tri duy nhat, khong trung lap
create table Student(
	id int not null,
	name nvarchar(30),
	mobile varchar(11),
	email varchar(30)
)

alter table Student add constraint pk_id_student primary key(id)
alter table Student add constraint un_mobile unique(mobile)
alter table Student add constraint un_email unique(email)


insert Student values 
	(1, 'LeeSin', '0919645226', 'heheh@gmail.com'),
	(2, 'Yasuo', '0919645225', 'hahaha@gmail.com')


--Câu lệnh SELECT :
--Lấy dữ liệu trên tất cả các cột : Sử dụng *

SELECT * FROM Product
SELECT Product.* FROM Product

--Lấy dữ liệu trên một số cột mong muốn:
SELECT id, name FROM Product

--Đặt bí danh cho cột khi hiển thị:
select id[Mã sản phẩm], name AS [Tên sản phẩm] FROM Product

--Lấy dữ liệu trên nhiều bảng:
SELECT * FROM Brand


--SELECT với JOIN: Lấy bản ghi liên quan đến các bảng với nhau
SELECT * FROM Product a JOIN Brand b ON a.Brandid = b.id
--a, b: các bí danh của các mảng
--Left join: lấy bản ghi liên quan đến các bảng + những bản ghi --
--của bảng bên trái kết nối.

SELECT * FROM Product LEFT JOIN Brand ON Product.Brandid = Brand.id
--Right join: lấy bản ghi liên quan đến các bảng + những bản ghi --
--của bảng bên phải kết nối.
INSERT Brand VALUES (4, 'VinSmart')
SELECT * FROM Product Right JOIN Brand ON Product.Brandid = Brand.id

--FULL join: lấy bản ghi liên quan đến các bảng + những bản ghi --
--của bảng bên trái kết nối + của bảng bên phải kết nối.
INSERT Brand VALUES (4, 'VinSmart')
SELECT * FROM Product FULL JOIN Brand ON Product.Brandid = Brand.id

--SELECT VS DISTINCT : TRÁNH HIỂN THỊ DỮ LIỆU GIỐNG NHAU.
INSERT Product(id, name, Brandid) values (6, 'SamSung J10', 3)
SELECT distinct Brandid from Product

--SELECT vs WHERE: SELECT CÓ ĐK.
--Đưa ra điều kiện kiểm tra not null: is not null
--Đưa ra đk ktra null: is null
SELECT * FROM Product WHERE Brandid is not null and price is not null
SELECT * FROM Product WHERE price > 30000000

--Các phép toán so sánh: <, >, >=,<=, = ,!=, (<>)
--Phép toán logic : and , or, not

SELECT * FROM Product WHERE NOT (price >= 25000000 AND price <= 35000000)
SELECT * FROM Product WHERE  price NOT BETWEEN 25000000 AND 35000000
SELECT * FROM Product WHERE price = 25000000 OR price = 31000000
SELECT * FROM Product WHERE price NOT IN ( 25000000 , 31000000)

--Like và Not Like : Tìm kiếm dữ liệu dạng chuỗi
SELECT * FROM Product WHERE name like '%S%';
--% :chuỗi bất kỳ (bao gồm cả chuỗi rỗng)
SELECT * FROM Product WHERE name like '[DM]%'
--[]: Là  1 ký tự bất kì trong nó. [abc]<=> a hoặc b hoặc c

--Tìm những sản phẩm có tên bắt đầu bẳng D hoặc M
SELECT * FROM Product WHERE name like '[^DM]%'
--[^]:Là 1 ký tự bất kỳ nhưng không phải là ký tự nào trong nó.
--vd:[^abc] <=> 1 ký tự bất kỳ nhưng không phải là a,b,c 

--Hãy lấy những sản phẩm trong đó tên kết thức là 4 ký tự liền nhau 
SELECT * FROM Product WHERE name like '% ____'

--_:(gạch dưới) : Tương đương với 1 ký tự bất kì nào.

--Order By: Dùng để sắp xếp tập kết quả theo trật tự tăng/giảm
SELECT * FROM Product ORDER BY name DESC --asc : tăng dần, desc: giảm dần

--	Tìm kiếm và sắp xếp tập kết quả tăng dần theo BrandID , giảm dần theo quantity
SELECT * FROM Product WHERE name LIKE '%S%' ORDER BY Brandid asc ,quantity desc
--Lưu ý Order by phải nằm sau where
--Update dữ liệu
SELECT * FROM Product;
SELECT * FROM Brand
INSERT Brand VALUES(5, 'BPhone');
UPDATE Product SET quantity = 20 WHERE ID = 4
UPDATE Product SET price = 9000000, brandId = 5 WHERE id = 4
--CÁC HÀM THỐNG KÊ, TẬP HỢP:
--SUM(): Tính tổng.
SELECT SUM(quantity) AS [Tổng hàng trong kho] FROM Product
--AVG(): Tính trung bình cộng.
SELECT AVG (price) AS [Giá trung bình] FROM Product
--COUNT() : Đếm số bản ghi có được trong kết quả.
SELECT COUNT(*) FROM Product
SELECT COUNT(price) FROM Product
--MAX(): Tìm MAX
SELECT MAX(price) FROM Product
--MIN(): Tìm MIN
SELECT MIN(price) FROM Product

USE SE1711

SELECT * FROM Product;
SELECT * FROM Brand;
update Product set quantity = 40 where id = 6
--Hãy hiển thị thương hiệu + tổng số sản phẩm của thương hiệu đó
--Sử dụng group by để nhóm tập kết quả
SELECT a.name ,b.name, sum(b.quantity) AS [Tổng sp thương hiệu] from Brand a join Product b
			on a.id = b.BrandId
			group by a.name , b.name
		
--Hàm convert :Dùng để chuyển đổi kiểu dữ liệu  trong quá trình truy vấn.
SELECT id, name, CONVERT(numeric(4, 2), quantity) from Product
--numeric(n,m): kiểu số chính xác, n là số lượng chữ số muốn hiển thị
--(bao gồm cả phần nguyên và thập phân), m là độ chính xác.)
--Hàm cast có tác dụng tương tự hàm Convert
SELECT id, name, CAST(quantity as numeric(5,2)) from Product

--Thao tác với ngày tháng, thời gian
--Kiểu ngày tháng : date
--Kiểu ngày tháng, thời gian: date time(8 byte), smalldatetime(4 Byte)
--Date Part ( Phần thời gian):
-----------------------
--Hour(HH)
--Minute(MI)
--Second(SS)
--MinSecond(MS)
--Ngày trong năm: DY
--Day (DD): ngày trong tháng
--Week (WK)
--WeekDay(WD): ngày trong tuần
--Month(MM): Tháng
--Quarter(QQ): Quý
--Year(YY, YYYY): Năm
--------------------
--Lấy ngày tháng, thời gian hiện tại:
SELECT GETDATE()[Current time]
--DateAdd(): Thêm DatePart vào thời gian tương ứng.
SELECT DATEADD(HOUR,15, GETDATE())
--DateDiff(): Lấy phần thời gian khác biệt giữa 2 mốc thời gian tương ứng
SELECT DATEDIFF(QQ, '1999-9-18',GETDATE())
--Lưu ý: Dữ liệu về ngày tháng năm phải được đặt trong nháy đơn, và
--mặc định chỉ đc là 1 trong 2 dạng:'yyyy-mm-dd ' or 'mm-dd-yyyy'
--DateName():Hiển thị DatePart theo dạng chuỗi.
SELECT DATENAME(MONTH, GETDATE())
--DatePart(): Lấy phần thời gian của mốc thời gian tương ứng
SELECT DATEPART(QQ,GETDATE())
--Hãy hiển thị thời gian hiện tại và thời gian hiện tại + 3000p?
SELECT GETDATE(), DATEADD(MI, 3000, GETDATE())
--Hãy tính xem kể từ khi đc sinh ra bạn đã sống được bn  phút?
SELECT DATEDIFF(MI,'2002-2-3', GETDATE())



SELECT a.name ,b.name, sum(b.quantity) AS [Tổng sp thương hiệu] from Brand a join Product b
			on a.id = b.BrandId
			group by a.name , b.name

--Hãy hiển thị thương hiệu kèm tổng số lượng sl trong kho của thương hiệu đó vs yêu câu số lg >50
SELECT a.name,sum(b.quantity) AS [Số lượng trong kho] FROM Brand a JOIN Product b
		ON a.id =b .BrandId
		group by a.name
		having sum(b.quantity) > 50
	
--Having : chứa các điều kiện trong đó có hàm aggregate (thống kê tập hợp).
--Having phải đc đặt sau Group By
--Truy vấn con(subquery): Trong câu lệnh truy vấn này có chứa câu lệnh truy vấn khác.

SELECT * FROM Product WHERE price = (select max(price) from Product)


update Product SET BrandId = 4 WHERE ID = 5

INSERT Brand VALUES(5, 'BKAV')
INSERT Product VALUES(4, 'BPhone4', 9000000, 20, 5)
INSERT Product VALUES(7, 'Vertu99', 90000000, 20, 6)
DELETE FROM Brand WHERE id =5 
select * from Product
SELECT * FROM Brand
DELETE FROM Product WHERE id =7 
UPDATE Product SET BrandId = 5 WHERE id = 4
INSERT Brand VALUES(4, 'VinSmart')
INSERT Brand VALUES(5, 'FPTPhone')
--Hãy hiển thị những thương hiệu chưa có sản phẩm 

SELECT * FROM Brand a FULL JOIN Product b
		ON a.id =b .BrandId

SELECT a.name FROM Brand a FULL JOIN Product b
		ON a.id =b .BrandId
		WHERE b.id is null
		
SELECT * FROM Brand WHERE id not in(select BrandId from Product)
--Một số hàm thao tác chuỗi:
--Left(): Lấy một số ký tự bên trái chuỗi.
SELECT LEFT('SE1711', 2)
--Right(): Lấy một số ký tự bên trái phải.
SELECT RIGHT('SE1711', 3)
--Len():Trả về độ dài chuỗi
SELECT LEN('SE1711')
--Reverse(): Đảo ngược trật tự 
Select REVERSE('SQL Sever')
--Replicate(): Lặp chuỗi.
SELECT REPLICATE('ABC', 5)
--Concat(): Nối chuỗi
SELECT CONCAT('SQL', 'Server', '2012')
--Replace(): Thay thế chuỗi
SELECT REPLACE('sql Server', 'sql', 'SQL')

----------------------------------------------------
--Exists và Not Exists: Dùng để kiểm tra xem có bản ghi nào thỏa mãn
--điều kiện đề ra hay không, nếu có thì trả về true, ngược lại trả về False
--Đối số của hàm exists() là một câu lệnh select
use SE1711
if(exists(select * from Product where quantity is null))
begin
	print N'Tìm thấy'
end
else
begin
	print N'Không tìm thấy'
end;
--Mệnh đề TOP : Dùng để lấy một số bản ghi đầu tiên của tập kệt quả
SELECT TOP(1) * FROM Product
--TOP with percent: Dùng để lấy một số bản ghi đầu tiên theo tỷ lệ %
--của tập kết quả. Mỗi bản ghi sẽ có tỷ lệ % tương ứng là 100/ tổng
--số bản ghi.
SELECT TOP(10) percent * FROM Product

--Mệnh đề TOP: Dùng để lấy mốt số bản ghi đầu tiên của tập kết quả.
select top(1) * from Product

--TOP với Percent: Dùng để lấy một số bản ghi đầu tiên theo tỷ lệ % của tập kết quả.
--Mỗi bản ghi sẽ có tỷ lệ % tương ứng là 100 / tổng số bản ghi.
select top(16.7) percent * from Product

--TOP với with TIES: Dùng để lấy thêm những bản ghi có giá trị ở cột
--bằng với giá trị của bản ghi cuối ứng với cột đó trong top bản ghi đầu tiên.
--Lưu ý: WITH TIES phải đi kèm với order by.
select top(3) with ties * from Product order by brandId
select top(3) * from Product order by brandId
select * from Product order by brandId

--Case-When: 
--Cú pháp kiểm tra giá trị cột
select * from Product
alter table Product add status bit
update Product set status = 1 where id in(1, 2)
update Product set status = 0 where id in(3, 4)

select Product.*, [Tình trạng] = case status
	when 1 then N'Còn hàng'
	when 0 then N'Hết hàng'
	else 'Unknown'
	end
	from Product

--Kiểm tra điều kiện: 
select * from Product 
update Product set price = 7000000 where id = 4
update Product set price = 3700000 where id = 5
update Product set price = 2800000 where id = 6

select Product.*, [Phân loại] = case 
	when price > 0 and price < 10000000 then N'Bình dân'
	when price >= 10000000 and price < 25000000 then N'Trung Cấp'
	else N'Cao cấp'
	end
	from Product

--Hãy hiển thị Tất cả thông tin về sản phẩm + thương hiệu, sau đó hiển thị 
--tình trạng về số lượng sản phẩm trong kho: nếu số lượng = 0 hoặc null thì
--báo 'hết hàng', nếu số lượng > 0 và < 50 thì báo 'còn ít'
--nếu số lượng >= 50 và < 100 'còn nhiều', các trường hợp còn lại thì báo 'còn rất nhiều'

--================================================
SELECT * FROM Product
INSERT Product(id, name) VALUES (7, 'Sony 2022')
DELETE FROM Product WHERE id = 7

--Chỉ mục (Index) :Tăng tốc độ tìm kiếm và truy xuất dữ liệu.
--Index được cấu trúc theo cây nhị phân.
--Clustered Index áp dụng cho cột/các cột mang dữ liệu duy nhất ( thường là các mã)

--Non-Clustered Index áp dụng cho bảng chứa 1 lượng dữ liệu nhỏ

--** Tạo Clustered Index:
--PK chính là 1 Clustered Index
--Cú pháp:
--Create Clustered Index tên_index on tên_bảng(cột/ tập_ cột)
CREATE CLUSTERED INDEX CI_PRODUCT_ID ON Product(id);

CREATE CLUSTERED INDEX CI_BRAND_ID ON Brand(id);

--*Tạo Non-Clustered Index : 1 bảng có thể có nhiều
--Cú pháp:
--create [nonclustered] index tên_index on tên_bảng (cột / tập_ cột);
CREATE INDEX NCI_PRODUCY_NAME ON Product(name);
CREATE NONCLUSTERED INDEX NCI_PRODUCT_PRICE ON Product(price);
--Unique Non-clustered Index: Áp dụng cho cột/ tập cột mang những giá trị duy nhất
Create UNIQUE INDEX unci_brand_name on Brand(name)

EXEC sp_helpindex 'Product'

--*Xóa index
Drop index  Product.CI_PRODUCT_ID, Product.NCI_PRODUCT_PRICE, Product.NCI_PRODUCY_NAME

--------------------------------------------------
--VIEW (Khung nhìn) : Là một dạng bảng ảo, trong đó các cột và các hàng được lấy từ những bảng vật lý và VIEW khác.
--View chỉ sử dụng đc cho câu lệnh select ( phần thân của View chỉ chứa được câu lệnh select).
--Ưu điểm : Tăng tính bảo mật, có thể tùy chỉnh việc hiển thị dữ liệu,có thể lấy dữ liệu và xem trên nhiều bảng và View khác.
--* View hệ thống ( System View) :Được tạo sắn để chứa những dữ liệu dạng metadata. Các view này được đặt trong thư mục
--System Views

--*Tạo View:
--Create view tên_view AS 
	--Câu lệnh SELECT;

create view vw1 as
	select * from Product

--*Xem dữ liệu của View:
select * from vw1 WHERE quantity is not null

--*Insert dữ liệu vào View:
INSERT vw1(id, name) values (7, 'View');
select * from vw1
select * from Product
update vw1 set Status = 0 where id = 7;

--*Delete dữ liệu trong View:
delete from vw1 where id = 7;

--* Xem định nghĩa View:
exec sp_helptext 'vw1'

select OBJECT_DEFINITION(OBJECT_ID('vw1'))

exec sp_depends 'vw1'

--* Các tùy chọn khi tạo/sửa view:
--With encryption: Mã hóa không phép xem định nghĩa và  những thông tin 
-- liên quan đến view.
alter view vw1 with encryption as
	select * from Product

--With check option: Áp dụng khi câu lệnh select của view có chứa mệnh đề where.
--Khi đó tùy chọn này sẽ áp đặt các điều kiện ở phần where cho các thao tác insert và update

alter view vw1 with encryption as
	select * from Product where quantity > 0
	with check option;
	
select * from vw1
--insert vw1(id, name) values(8, 'View1')
update vw1 set quantity = 120 where id = 3
--with schemabinding: Áp dụng ràng buộc rằng những cột của những bảng tham gia vào việc tạo view
--không được phép sửa tên , sửa kiểu dữ liệu
--Lưu ý:Không được dùng * trong câu lệnh select , phải nói rõ chủ sở hữu của các bảng ( mặc đinh là dbo).

alter view vw1 with encryption, schemabinding as
	select id, name, price, quantity, BrandId from Product where quantity > 0
	with check option;

alter table Product alter column price int;

--* Tạo index cho View: Chỉ được phép tạo Unique Clustered Index cho View
--Lưu ý : View phải được thiết lập tùy chọn with schemabinding thì mới tạo được index

create unique clustered index uci_vw1_id on vw1(id)

--Sắp xếp trên View
alter view vw1 with encryption, schemabinding as
	select top(99.99) percent id, name, price, quantity, BrandId from Product where quantity > 0
	order by price desc
	with check option;

select * from vw1

--Xóa View:
Drop View vw1
--------------------------------------------------------------
--Identity : Áp dụng cho cột mang giá trị số, tự động điền giá trị 
--vào cột tương ứng, giá trị sẽ thường sẽ tăng dần, giá trị của cột tương ứng
--luôn khác nhau; mặc định ta không được chèn dữ liệu vào cột identity
--Cú pháp : identity(n,m)
--n: là giá trị bắt đầu , m là bước nhảy.
--identity(2, 3) => 2, 5, 8, 11, 14, ....
--identity: 1,2,3,4,5,6,...<=> identity(1, 1)
--thường cột áp dụng là cột chứa mã
--Mỗi bảng chỉ có 1 cột chứa identity.

CREATE TABLE Course(
	id int not null identity,
	name nvarchar(30),
	status bit,

);
ALTER TABLE Course ADD CONSTRAINT pk_id_course PRIMARY KEY(id)
insert Course (name, status) values('Java', 1),('SQL Server', 1);
delete from Course where id = 2;
select * from Course
insert Course(name, status) values('HTML5', 1), ('CSS3', 1);
--Cột định đặt identity phải là cột not null.
--------------------------------

--Thủ tục lưu trữ (Stored Procedure - SP): Dùng để thực hiện một công việc cụ thể.

--Cú pháp:
--Create proc | procedure tên_sp ([danh_sách_tham_số]) AS
--begin
--		Khối lệnh SQL
--end;
--Vd1: Tạo SP để lấy các sp có giá > 20000000??

Select * from Product
CREATE PROC sp_view_product as
begin
	select * from Product where price > 20000000;

end;
--Thực thi SP

exec sp_view_product

--Ví dụ 2: tạo 1 sp để tìm những sp có giá trong khoảng mong muốn?
CREATE PROC sp_search_product_by_price(@min float, @max float) as
begin
	SELECT * FROM Product WHERE price > @min and price < @max

end;

exec sp_search_product_by_price 10000000, 30000000;

--Sửa SP: Sử dụng câu lệnh alter proc
alter PROC sp_search_product_by_price(@min float, @max float) as
begin
	SELECT * FROM Product WHERE price > @min and price < @max 
		and status = 1;
end;
exec sp_search_product_by_price 10000000, 30000000;

--Xem đinh nghĩa SP:
exec sp_helptext 'sp_search_product_by_price'

--Xóa SP: sử dụng câu lệnh Drop proc
Drop proc sp_search_product_by_price
---------------------------------------------------------------------------
--Trigger : Tự động đc kích hoạt khi có hành động tương ứng được thực hiện
--3 hành động tương ứng có thể dùng để cài đặt Trigger: Insert, Update, Delete
--=> Trigger DML(Data Manipulation Language).
--=>3 loại Trigger DML: Trigger Insert,Trigger Update , Trigger Delete
--*Bảng Inserted và bảng Deleted: Tự động được tạo ra khi trigger tương ứng được kích
--hoạt , và tự động được hủy đi sau khi ta thực hiện xong trigger.
--Bảng Inserted: được tạo ra khi hành động insert hoặc hành động update khi được thực thi:
--Bảng Inserted sẽ lưu những bản ghi mà được chèn vào bảng từ hành động Insert.
--Bảng Inserted sẽ lưu những bản ghi mà được sửa mới từ hành động update
--Bản Deleted: Được tạo ra khi hành động delete hoặc update đc thực thi
--Bảng Deleted sẽ lưu những bản ghi mà được xóa khỏi bảng
--Bảng Deleted sẽ lưu lại những bản ghi được thay thế từ hành động update

--*Tạo trigger Insert: Được kích hoạt  khi hành động insert được thực hiện
select * from Product
--Tạo trigger để check xem những bản ghi được chèn vào bảng có giá < 0 hay ko
--nếu có thì đưa ra thông báo và không cho thực hiện insert nữa?
create trigger tg_insert_check_price on Product for insert as
begin
	if(exists(select*from inserted where price < 0))
	begin
		print N'Giá không đc < 0'
		rollback tran;--thu hồi giao dịch
	end;
end;
select * from Product
alter table Product drop constraint ck_price
insert Product(id,name,price) values(7, 'Product1', 3200000)

--*Tạo trigger Delete : Được kích hoạt khi hành động delete được thực thi
--Tạo trigger để check nếu số lượng bản ghi bị xóa > 1 thì sẽ đưa ra thông báo và ngăn ko cho xóa nữa
drop trigger tg_delete_product
create trigger tg_delete_product on Product for delete as
begin
	if((select COUNT(*) from deleted) > 1)
	begin
		print N'Bạn chỉ được xóa 1 bản ghi 1 lần'
		rollback tran;
	end;
end;

select * from Product
insert Product(id, name, price) values(8, 'Product 2', 22000000);

delete from Product where id in(7, 8)
--Hãy tạo 1 trigger để thực hiện : khi xóa 1 bản ghi khỏi bảng Product thì sẽ xóa những bản ghi
--khác có id > id của bản ghi bị xóa, nếu không có bản ghi nào bị xóa thêm thì đưa ra thông báo,
--ngược lại sẽ thông báo xóa thành công
drop trigger tg_delete_productV1
create trigger tg_delete_productV1 on Product instead of delete as
begin
	if((select COUNT(*) from deleted) = 1)
	begin
		delete from Product where id >= (select id from deleted)
		print 'Xóa thành công'
	end;
	else
	begin
		print N'Không tồn tại bản ghi theo yêu câu để xóa'
	end;
end;

select * from Product
delete from Product where id = 6