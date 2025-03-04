--TRIGGER
--TRIGGER LÀ MỘT HÀM VOID, KO NHẬN THAM SỐ , KO TRẢ VỀ
--NÓ LÀM NHIỆM VỤ GÁC CỔNG 1 TABLE NÀO ĐÓ, NẾU CÓ SỰ THAY ĐỔI DATA TRONG TABLE
--NÓ SẼ TỰ ĐỘNG ĐƯỢC THỰC THI, CHẠY
--DÙNG ĐỂ KIỂM TRA/HAY ĐẢM BẢO TÍNH TOÀN VẸN/NHẤT QUÁN/CONSISTENCY CỦA DỮ LIỆU
--Hoặc dùng để kiểm tra các ràng buộc mà SQL ko đủ cung cấp
--Chỉ tự gọi liên quan đến table nào đó và liên quan đến 3 lệnh :INSERT, UPDATE, DELETE
--Gắn chặt vs 1 table , nhưng ko cấm code của nó  can thiệp table khác
--1 table ko ép phải có trigger
create table [Event]
(
	ID int identity primary key,
	Name nvarchar(30) not null,

) 
select * from Event

GO
create trigger TR_CheckInsertionOnEvent ON Event 
for INSERT
AS
BEGIN
	PRINT 'You have just inserted a record in Event table'
END

GO


exec PR_InsertEvent N'Blockchain & game' --Kiểm tra xem có thông báo không khi insert an Event 

select * from Event

--phá hôi: ko cho insert vào table event

GO
create trigger TR_ForbidInsertionOnEvent ON Event 
for INSERT
AS
BEGIN
	PRINT 'You have just inserted a record in Event table .Sorry'
	ROLLBACK -- cấm, undo những gì đã xảy ra khi insert
END

GO

exec PR_InsertEvent N'Thổi nến và Tài chính 4.0'
drop trigger TR_ForbidInsertionOnEvent
drop trigger TR_CheckInsertionOnEvent

select * from Event

--Kiểm tra ko cho quá 5 records/events
--SQL có thể đếm, quyết định đếm xong làm gì tiếp --> lập trình!!-> Trigger chặn ko cho vào
GO
Create trigger TR_CheckInsertionLimitationEvent On Event 
FOR INSERT
AS
BEGIN
	--kiểm tra xem có quá 5 record ko trong table event?
	--if số sự kiện > 5 thì rollback
	--phải đếm số sự kiện đang có
	--lấy đc số sự kiện để if , tức là khai báo biến
	--nhớ lệnh count(*) trong select trả về 1 table, ko trả về 1 biến, ta phải...
	declare @noEvents int
	select @noEvents = count(*) from Event
	if @noEvents > 5
	BEGIN
		print 'To much events, No more 5 events!!!'
		rollback
	END
	
END
GO

--Liên quan đến 1 table , có 2 loại trigger cơ bản :
--trước khi dữ liệu đưa vào table, lúc này dữ liệu mới vào inserted(before)

--Chặn sau khi đã vào inserted và đồng thời vào table rồi(after)

select * from Event
exec PR_InsertEvent N'Thổi nến và Tài chính 4.0'
--lưu ý chi chơi trigger : 
--DB ENGINE sẽ tự tạo ra 2 table "ảo" lúc runtime liên quan đếnn trigger

--câu lênh insert vào table -> DB.E tạo ra 1 table ảo tên là INSERTED
--chứa record vừa đưa vào từ câu lệnh insert

--câu lênh delete from table -> DB.E tạo ra 1 table ảo tên là DELETED
--chứa record vừa bị xóa!!!

--câu lệnh update event set name = 'Đổi tên sự kiện'->DB.E sẽ chơi trò tạo ra 2 table ảo
--INSERTED chứa values mới đưa vào
--DELETED chứa values cũ / bị ghi đè

go

--chèn thêm dòng vào table
exec PR_InsertEvent N'Bí quyết sống sót học lab LAB211'


