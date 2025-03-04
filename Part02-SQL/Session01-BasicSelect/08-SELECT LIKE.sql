USE Northwind

--LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG LỆNH SELECT:
--Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
--gần đúng trên kiểu chuỗi , ví dụ, liệt kê ai đó có tên là AN, khác với câu
--liệt kê ai đó tên bắt đầu bằng chữ A
--Tìm đúng, TOÁN TỬ = 'AN'
--Tìm gần đúng, tìm có sự xuất hiện , ko dùng = , dùng toán tử LIKE
--                           LIKE'A...'....
--ĐỂ SỬ DỤNG TOÁN TỬ LIKE, TA CẦN THÊM 2 THỨ TRỢ GIÚP , DẤU % VÀ DẤU _
--% đại diện cho 1 chuỗi bất kì nào đó
--_ đại diện cho 1 kí tự bất kì nào đó
--VÍ DỤ: Name LIKE 'A%', bất kì ai có tên xuất hiện bằng chữ A, phần còn lại là gì ko care
--       Name LIKE 'A_',  bất kì ai có tên là 2 kí tự, trong đó kí tự đầu phải là A 




---------------------------

--1.In ra danh sách nhân viên 
SELECT * FROM Employees

--2.Nhân viên lào có tên bắt đầu bằng chữ A
SELECT * FROM Employees WHERE FirstName = 'A%'--0 vì toán tử ss = A%, có ai tên A% ko
SELECT * FROM Employees WHERE FirstName LIKE 'A%' --2

--2.1Nhân viên lào có tên bắt đầu bằng chữ A , in ra cả full name được ghép đầy đủ

SELECT EmployeeID, FirstName + ' '+ LastName AS [Full Name], Title  FROM Employees WHERE FirstName LIKE 'A%'

SELECT EmployeeID,CONCAT(FirstName,' ',LastName) AS [Full Name], Title  FROM Employees WHERE FirstName LIKE 'A%'

--3.Nhân viên lào có chữ A cuối cùng
SELECT EmployeeID,CONCAT(FirstName,' ',LastName) AS [Full Name], Title  
                  FROM Employees WHERE FirstName LIKE '%A'

--4.Nhân viên nào tên có 4 kí tự
--Dùng hàm kiểm tra độ dài tên = 4 hay ko - Homework
SELECT * FROM Employees WHERE FirstName LIKE '____'--1

--5.Xem danh sách các sản phẩm/món đồ đang có - Product 
SELECT * FROM Products --77

--6. Những sản phẩm nào có tên bắt đầu bằng chữ Ch
SELECT * FROM Products WHERE ProductName LIKE 'Ch%'--6

SELECT * FROM Products WHERE ProductName LIKE '%Ch%'--14
--trong tên có từ Ch , ko quan tâm vị trí xh

--7.Những sản phẩm tên có 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '_____'--3


--8.Những sản phẩm tên có từ cuối cùng là 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '%_____'--tên có từ 5 kí tự trở lên

SELECT * FROM Products WHERE ProductName LIKE '% _____'--tên có ít nhất 2 từ
													   --từ cuối cùng 5 kí tự
													   --vô tình loại đi thằng	
SELECT * FROM Products WHERE ProductName LIKE '% _____' OR ProductName LIKE '_____'--14													   -- tên chỉ có đúng 5 kí tự