USE Northwind
--LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG:
--Mệnh đề WHERE : dùng làm bộ lọc/filter/nhặt ra những dữ liệu ta cần theo 1 tiêu chí nào đó
--VÍ DỤ: Lọc ra những sv có quê ở Bình Dương
--       Lọc ra những sv quê ở Tiền Giang và điểm tb >= 8

--CỨ PHÁP DÙNG BỘ LỌC
--SELECT * (cột bạn muốn in ra) FROM <TÊN-TABLE> WHERE <ĐIỀU KIỆN LỌC>
--ĐIỀU KIỆN LỌC: TÌM TỪNG DÒNG, VỚI CÁI-CỘT CÓ GIÁ TRỊ CẦN LỌC
--               LỌC THEO TÊN CỘT VS VALUE THẾ NÀO, LẤY TÊN CỘT, XEM VALUE TRONG CELL
--               CÓ THỎA ĐIỀU KIỆN LỌC HAY KHÔNG??
--ĐỂ VIỆT ĐK LỌC TA CẦN:
--> tên cột
--value của cột (cell)
--toán tử (operator) > >= < <= =(một dấu bằng hoy, ko giống C Java), !=, <> (!= hoặc <> cùng ý ngĩa)
-- có nhiều đk đi kèm nhau, dùng thêm logic operators, AND, OR, NOT (~~J,C :&& || !)
--VÍ DỤ: WHERE City = N'Bình Dương'
--       WHERE City = N'Tiền Giang' AND Gpa >= 8

--LỌC LIÊN QUAN ĐẾN GIÁ TRỊ/VALUE/CELL CHỨA GÌ, TA PHẢI QUAN TÂM
--Số: nguyên/thực, ghi số ra như truyền thống 5, 10, 3.14,9.8
--Chuỗi/kí tự:'A','Ahihi'
--Ngày tháng: '2003 -01-01....'

-----------------------------------------------------
--THỰC HÀNH
--1. In ra danh sách các khách hàng
SELECT * FROM Customers --92 rows

--2.In ra danh sách khách hàng đến từ Ý
SELECT * FROM Customers WHERE Country = 'Italy'--3

--3.In ra danh sách khách hàng đến từ Mĩ
SELECT * FROM Customers WHERE Country = 'USA' --13

--4. In ra những khách hàng đến từ Mĩ ,Ý
--Đời thường có thể nói: những k/h đến từ Mĩ và Ý, Ý hoặc Mĩ
--SELECT * FROM Customers WHERE Country = 'USA' OR 'Italy' --ERROR, thiếu toán tử so sánh

SELECT * FROM Customers WHERE Country = 'USA' OR Country ='Italy' --hiểu nghĩa  logic , hơn hiểu nghĩa tiếng việt

--sort theo Ý, Mĩ để gom cùng cụm cho dễ theo dõi
SELECT * FROM Customers WHERE Country = 'USA' OR Country ='Italy' ORDER BY Country

--5.In ra khách hàng đến từ thủ đô của nước Đức

SELECT * FROM Customers WHERE City = 'Berlin' AND Country = 'Germany' --1

--6.In ra các thông tin của nhân viên
SELECT * FROM Employees

--7.In ra thông tin nhân viên có năm sinh từ 1960 trở lại gần đây/đổ lại
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 --4

--8.In ra thông tin nhân viên có tuổi từ 60 trở lên
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= 60

--9.Những nhân viên nào ở Luân Đôn
SELECT * FROM Employees WHERE City = 'London' --4/9

--10. Những ai không ở Luân Đôn
SELECT * FROM Employees WHERE City != 'London' --5/9
SELECT * FROM Employees WHERE City <> 'London'

--vi diệu
--ĐẢO MỆNH ĐỀ!!!!
SELECT * FROM Employees WHERE NOT(City = 'London')
--SELECT * FROM Employees WHERE !(City = 'London')--SAI CÚ PHÁP, ĐẢO MỆNH ĐỀ, PHÉP SS THÌ DÙNG NOT

--11.In ra hồ sơ của nhân viên có mã số là 1
-- đi vào ngân hàng giao dịch, hoặc đưa số stk, kèm cmnd, filter theo cmnd
SELECT * FROM Employees WHERE EmployeeID = 1 -- kiểu số, ko có '', chơi như lập trình
-- WHERE MÀ CÓ WHERE KEY CHỈ CÓ 1 DÒNG TRẢ VỀ, DISTINCT LÀ VÔ NGHĨA
SELECT DISTINCT EmployeeID, City FROM Employees WHERE EmployeeID = 1 ORDER BY EmployeeID

--11. CÔNG THỨC FULL KO CHE CỦA SELECT
--SELECT ...       FROM ...        WHERE .... GROUP BY... HAVING....ORDER BY
--        DISTINCT       1,N TABLE
--      HÀM()
--       NESTED QUERY/SUB QUERY

--12. Xem thông tin của bên Đơn hàng
SELECT * FROM Orders --830

--13.Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng
SELECT * FROM Orders ORDER BY Freight DESC

--14.Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng > 500
SELECT * FROM Orders WHERE Freight >= 500 ORDER BY Freight DESC --13

--15.Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng 100 cho đến 500
SELECT * FROM Orders WHERE  Freight >= 100 AND Freight <= 500 ORDER BY ShipVia,Freight DESC -- 174

--16.Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng 100 cho đến 500
--và ship  bởi công ty giao vận số 1
SELECT * FROM Orders WHERE  Freight >= 100 AND Freight <= 500 AND ShipVia = 1 ORDER BY Freight DESC --52/174/830

--17.Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng 100 cho đến 500
--và ship  bởi công ty giao vận số 1 và không ship tới LonDon
--Rất cẩn thận khi trong mệnh đề WHERE lain có AND OR trộn vs nhau, ta phải xài thêm ()
--để phân tách thứ tự FILTER ... (SS AND OR KHÁC NỮA) AND (SS KHÁC)
SELECT * FROM Orders WHERE  Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND ShipCity != 'London' ORDER BY Freight DESC --50
SELECT * FROM Orders WHERE  Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND NOT(ShipCity = 'London') ORDER BY Freight DESC --50

--18.Liệt kê các khách hàng đến từ Mĩ hoặc Mexico
SELECT * FROM Customers WHERE Country ='USA' OR Country = 'Mexico'-- 18

--19.Liệt kê các khách hàng đến từ Mĩ hoặc Mexico
SELECT * FROM Customers WHERE Country !='USA' AND Country != 'Mexico'
SELECT * FROM Customers WHERE NOT(Country ='USA' OR Country = 'Mexico')

--20.Liệt kê các nhân viên sinh ra trong đoạn [1960 1970]
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 ORDER BY BirthDate DESC --4

