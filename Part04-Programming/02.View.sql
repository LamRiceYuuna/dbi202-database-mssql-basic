--Khi có nhiều câu lệnh SQL phức tạp, hay ta cần viết đi viết lại nhiều
--lần 1 câu select nào đó, ta đặt cho câu lệnh SQL select này 1 cái tên
--sau này mún xài lại câu SQL select này chỉ gọi tên ra là đc

--1 câu lệnh select ~~ 1 table được trả về khi chạy
--1 câu lệnh select ---- đặt cho nó 1 cái tên --- 1 table đc trả về khi chạy
--Nếu ta mún nhìn table này, chạy lại lệnh select này
--Ta chỉ việc select * from cái tên-đã đặt


use Northwind

select * from Employees

--liệt kê các nhân viên ở LonDon
select * from Employees where City = 'LonDon' 

--Coi câu này là 1 table, cho nó 1 cái tên, sau này muốn xem lại data
--select cái tên
GO
create view VW_LondonEmployees 
AS 
select * from Employees where City = 'LonDon' 
GO

--Xài view, coi mày là table, vì sau lưng mày là 1 câu sql chống lưng
select * from VW_LondonEmployees
select * from [Category Sales for 1997]

