--Hàm: 1 nhóm câu lệnh đặt 1 tên,nhóm lệnh này làm 1 việc gì đó ,để re-use
--Trong lập trình có 2 loại hàm
--Hàm căn bậc 2, lấy căn


--Trong lập trình có 2 loại hàm:
--HÀM VOID : KO TRẢ VỀ 1 GIÁ TRỊ NÀO CẢ
--Hàm có trả về 1 giá trị (chỉ 1) : lệnh return 

--R.DBMS (CSDL DỰA TRÊN RELATION/TABLE) ta có 2 loại hàm y chang
--STORE PROCEDURE~~~ VOID
--FUNCTION ~~~ RETURN

--C: void f(int *a, int* b) {

--}
--gọi hàm f();
--int x= 10, y = 11;
--int x,y;
--f(&x, &y) khi trong hàm f mà làm gì với x,y thì x ở bên ngoài bị ảnh
--hưởng luôn
--hàm thay đổi 2 giá trị x, y ở bên ngoài, void mà lại đưa data ra
--ngoài qua con trỏ , truyền tham chiếu pass by reference

--Viết hàm in ra câu chào!!!
create database DBDESIGN_PROGRAMMING
use DBDESIGN_PROGRAMMING

go
create procedure PR_Hello_1
AS
	PRINT N'Xin chào - Welcome to my own first procedure'

go

--Dùng procedure --là hàm void , gọi tên em là đủ
go
PR_Hello_1
dbo.PR_Hello_1

EXECUTE PR_Hello_1 -- Tui mún thực thi , chạy thủ tục/nhóm lệnh đã đặt tên


EXEC PR_Hello_1
go

--C2:
go
create proc PR_Hello
AS
	PRINT N'Xin chào - Welcome to my own 2nd procedure'

go
EXEC PR_Hello
----------------------------------------------------------

--Hàm , phải trả về giá trị !!! qua lệnh return

go

create FUNCTION	FN_Hello() 
RETURNS nvarchar(50)
AS
BEGIN
	RETURN N'Xin chào - Welcome to my own first function!'
END
go

--Lưu ý - y chang bên lập trình , hàm trả về giá trị thì được quyền dùng trong 
--các câu lệnh khác
-- gọi hàm mà ko kèm thêm gì khác, đừng hỏi tại sao màn hình ko thấy gì!!!
--nhiệm vụ của hàm về giá trị , in éo phải là việc của hàm, việc khác cũng thế
--in xem hàm xử lí ra sao, thì phải kèm lệnh in và lệnh gọi hàm
--sqr(4); --> ko kết quả khi chạy
--Math.sqrt(4); --> ko kết quả khi chạy
--sout(Math.sqrt(4));--> có kết quả khi chạy
print dbo.FN_Hello() --bắt buộc phải có dbo.tên hàm
select dbo.FN_Hello()-- hàm là dùng để xử lí và trả về kết quả, phải dùng kq trong lệnh nào đó


---------------------------------------------------------------------------------------------
--Viết HÀM - PROC ĐỔI TỪ ĐỘ C SANG ĐỘ F , F = C * 1.8 + 32
--Tham số/ đầu vàng /argument
go
create proc PR_C2F 
(@CDegree float)
as
begin
	DECLARE @FDegree float = @CDegree *1.8 +32
	print @FDegree
	
end
go
--Xài , vì có tham số, cần truyền vào
exec PR_C2F @CDegree = 37
exec PR_C2F 37

-------------------------------------------------------------------------
go
create function FN_C2F(@cDegree float)
returns float
as
begin
	DECLARE @FDegree float = @CDegree *1.8 +32
	return @FDegree
end
go
--sử dụng hàm , hàm là phải viết kèm vs lệnh khác
print dbo.FN_C2F (37)
print N'37 độ C là ' + cast(dbo.FN_C2F(37) as nvarchar(10)) + N' độ F'

--PROCEDURE LÀM ĐƯỢC NHIỀU VIỆC KHÁC:
--VIẾT 1 PROCEDURE IN RA DANH SÁCH CÁC NHÂN VIÊN QUÊ Ở ĐÂU ĐÓ, ĐÂU ĐÓ ĐƯA VÀO PROC

--VIEW : IN RA AI Ở LonDon
--VIEW : IN RA AI Ở KIRDLAND,....
--Mỗi view là 1 select và là 1 table để reuse
--PROCEDURE IN RA KẾT NHƯ VIEW, KO REUSE LẠI (Chỉ in ra) nhưng nhận được tham số
use Northwind
go
create proc PR_EmployeeListByCity
(@city nvarchar(30)) 
as
	select * from Employees where City = @city

go

exec PR_EmployeeListByCity 'LonDon'
exec PR_EmployeeListByCity 'Redmond' 

--Ứng dụng thêm của proc , viết insert data 

use DBDESIGN_PROGRAMMING

create table [Event]
(
	ID int identity primary key,
	Name nvarchar(30) not null,

) 


insert into [Event] values(N'Lời nói dối chân thật')
select * from Event
go
create proc PR_InsertEvent 
@name nvarchar(30)
as
	insert into [Event] values(@name)

go

--chèn thêm dòng vào table
exec PR_InsertEvent N'Bí quyết dùng source ở FE'
exec PR_InsertEvent N'Hồ Sen chờ ai'

select * from Event