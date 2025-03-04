--1.Done
--2.
create database DBLab8
use DBLab8
--3.
create table Food
(
	fID int not null,
	Name nvarchar(30),
	Price money
)
alter table Food add constraint pk_fID primary key(fID);

insert Food values
	(1, N'Gà hấp xì dầu', 27000),
	(2, N'Sườn nõn sốt chanh', 33000),
	(3, N'Bò xào hành tỏi', 23000),
	(4, N'Cá thu sốt', 31000);

select * from Food

create table FoodStuff
(
	sID int not null,
	Name nvarchar(30),
	Type int,
)
alter table FoodStuff add constraint pk_sID primary key(sID);

insert FoodStuff values
	(1, N'Thịt gà', 1),
	(2, N'Thịt lợn', 1),
	(3, N'Thịt bò', 1),
	(4, N'Cá thu', 1),
	(5, N'Hành', 2),
	(6, N'Tỏi', 2),
	(7, N'Cà chua', 2),
	(8, N'Xì dầu', 2),
	(9, N'Chanh', 2),
	(10, N'Hạt tiêu', 2);

select * from FoodStuff

create table FoodDetail
(
	fID int not null,
	sID int not null
)

alter table FoodDetail add  
	constraint pk_fID_sID primary key(fID, sID),
	constraint fk_fID foreign key(fID) references Food(fID),
	constraint fk_sID foreign key(sID) references FoodStuff(sID);

insert FoodDetail values
	(1, 1),
	(1, 8),
	(2, 2),
	(2, 9),
	(2, 7),
	(2, 5),
	(3, 3),
	(3, 5),
	(3, 6),
	(4, 4),
	(4, 7);

select * from FoodDetail

--4.
select a.Name as [Món ăn], c.Name as [Thực phẩm] 
	from Food a join FoodDetail b on a.fID=B.fID
	join FoodStuff c on c.sID = b.sID
	order by a.Name

--5.
select * from FoodStuff where sID  not in (select sID from FoodDetail); 

--6.
select Name from FoodStuff a join FoodDetail b on a.sID=b.sID
		group by Name
		having COUNT(a.sID) > 1 

--7.
select top(1) with ties Name from Food a join FoodDetail b on a.fID=b.fID
		group by Name
		order by COUNT(a.fID) DESC 

--8.
select Name, Type = case Type
	when 1 then N'Thực phẩm chính'
	else N'Gia vị'
	end
	from FoodStuff

--9.

create view vw_FoodList as
	select top(99.99) percent * from Food 
	order by Price desc

select * from vw_FoodList

--10.
update Food set Price*=1.1
select * from Food
update Food set Price/=1.1
select * from Food

--11.
create proc sp_FoodChoice(@Price money) as
begin
	select * from Food where Price<@Price
end

exec sp_FoodChoice 27000

--12.
alter proc sp_FoodChoice(@Name nvarchar(30), @Type nvarchar(10)) as
begin
	if(@Type=N'Rẻ')
		select a.Name, Price from Food a join FoodDetail b on a.fID=b.fID
		join FoodStuff c on c.sID = b.sID
		where c.Name like '%'+@Name+'%' and Price < 30000;
	else if(@Type='Đắt')
		select a.Name, Price from Food a join FoodDetail b on a.fID=b.fID
		join FoodStuff c on c.sID = b.sID
		where c.Name like '%'+@Name+'%' and Price >= 30000;
	else if(@Type='*')
		select a.Name, Price from Food a join FoodDetail b on a.fID=b.fID
		join FoodStuff c on c.sID = b.sID
		where c.Name like '%'+@Name+'%'		
end;

exec sp_FoodChoice N'Thịt',N'*'

--13.
create trigger tg_NoUpdatePrice on Food for update as
begin
	if(exists(select * from inserted
				where Price >= 40000))
	begin
		print N'Giá phải nhỏ hơn 40000'
		rollback;
	end;
end;

update Food set Price=41000

--14.
create trigger tg_delFood on Food instead of delete as
begin
	delete from FoodDetail where fID in (select fID from deleted)
	delete from Food where fID in (select fID from deleted)
	print N'Đã xóa dữ liệu thành công'
end;
	
select * from Food a join FoodDetail b on a.fID=b.fID
delete from Food where fID=3