USE Northwind

--LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG LỆNH SELECT:
--Trong thực tế có những dữ liệu/info chưa xác định được nó là gì??
--kí tên danh sách thi, danh sách kí tên có cột điểm , điểm ngay lúc kí tên chưa xác nhận đc
--từ từ sẽ có, sẽ update sau
--Hiện tượng dữ liệu chưa xđ, chưa biết, từ từ đưa vào, hiện nhìn vào
--chưa thấy có data , thì ta gọi giá trị chưa xđ này là NULL
--NULL ĐẠI DIỆN CHO THỨ CHƯA XÁC ĐỊNH, CHƯA XĐ TỨC LÀ KO CÓ GIÁ TRỊ, KO CÓ GIÁ TRỊ
--THÌ KO THỂ SO SÁNH > >= < <= = !=
--CẤM TUYỆT ĐỐI XÀI CÁC TOÁN TỬ SO SÁNH KÈM VỚI GIÁ TRỊ NULL
--TA DÙNG TOÁN TỬ , IS NULL, IS NOT NULL, NOT (..IS NULL) ĐỂ FILTER CELL CÓ
--GIÁ TRỊ NULL



----------------------------------------------------------------

--1.In ra danh sách nhân viên
SELECT * FROM Employees--9

--2.Ai chưa xác định khu vực ở, region null
SELECT * FROM Employees WHERE Region = 'NULL' --0 vì ko ai ở khu vực tên là NULL
SELECT * FROM Employees WHERE Region = NULL --0 vì NULL ko thể dùng > < =
SELECT * FROM Employees WHERE Region IS NULL --4

--3. Những ai đã xác định được khu vực cư trú
SELECT * FROM Employees WHERE Region IS NOT NULL -- 5
SELECT * FROM Employees WHERE NOT(Region IS NULL)--5

--4.Những nhân viên đại diện kinh doanh và xác định đc nơi cư trú
SELECT * FROM Employees WHERE Title ='Sales Representative' AND Region IS NOT NULL--3
SELECT * FROM Employees WHERE Title ='Sales Representative' AND NOT(Region IS NULL)--3

--5.Liệt kê danh sách khách hàng đến từ anh , pháp , mỹ , có cả thông tin số fax và region
SELECT * FROM Customers WHERE Country IN ('UK','France','USA') 
                           AND Fax IS NOT NULL AND Region IS NOT NULL




