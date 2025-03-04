USE Northwind
----------------------------------------------------------------------
--LÍ THUYẾT
--DB ENGINE hộ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán 
--trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
--COUNT() SUM() MIN() MAX() AVG()
--*CÚ PHÁP:
--SELECT CỘT ..., HÀM GOM NHÓM().,...FROM<TABLE>


--CÚ PHÁP MỞ RỘNG
--SELECT CỘT.....,HÀM GOM NHÓM(),... FROM<TABLE>...WHERE...GROUP BY (GOM THEO CỤM CỘT NÀO)

--SELECT CỘT....., HÀM GOM NHÓM(),...FROM<TABLE>...WHERE...GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING......


--*HÀM COUNT() DÙNG ĐỂ ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ???
--     COUNT(*) ĐẾM SỐ DÒNG TRONG TABLE: ĐẾM TẤT CẢ CÁC DÒNG KO CARE TIÊU CHUẨN NÀO KHÁC
--	   COUNT(*) FROM ...WHERE
--					CHỌN RA NHỮNG DÒNG THỎA TIÊU CHÍ WHERE NÀO ĐÓ TRƯỚC ĐÃ, RỒI MỚI ĐẾM
--					FILTER RỒI ĐẾM


--     COUNT(CỘT NÀO ĐÓ):
-------------------------------------------------------------
--1.In ra danh sách các nhân viên
SELECT * FROM Employees

--2.Đếm xem có bao nhiêu nhân viên
SELECT COUNT(*) AS[Number of employees] FROM Employees 

--3.Có bao nhiêu nhân viên ở London
SELECT COUNT(*) AS[Number of emps in London] FROM Employees WHERE City = 'London'

--4.Có bao nhiêu lượt thành phố xuất hiện cứ xh tên tp là đếm
SELECT COUNT(City) FROM Employees --9

--5.Đếm xem có bao nhiêu region
SELECT COUNT(Region) FROM Employees--5
--Phát hiện hàm count(cột) , nếu cell của cột chứa null, ko đếm

--6.Đếm xem có bao nhiêu khu vực null, có bao nhiêu dòng region null
SELECT COUNT(*) FROM Employees WHERE Region IS NULL--4 đếm sự xh của dòng chứa region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL--0 null ko đếm đc, k value 
SELECT * FROM Employees WHERE Region IS NULL

--7.Có bao nhiêu thành phố trong table nv
SELECT * FROM Employees
SELECT City FROM Employees--9
SELECT DISTINCT City FROM Employees--5
--Tui coi kết quả trên là 1 table, mất quá trời công sức lọc ra 5 thành phố
--Subquery mới, coi 1 câu select là 1 table, biến table này vào trong mệnh đề from
--Ngáo 
SELECT * FROM 
			(SELECT DISTINCT City FROM Employees) AS CITES

SELECT COUNT(*) FROM 
			(SELECT DISTINCT City FROM Employees) AS CITES

SELECT COUNT(*) FROM Employees--9NV
SELECT COUNT(City) FROM Employees--9city
SELECT COUNT(DISTINCT City) FROM Employees--5city

--8.Đếm xem mỗi thành phố có bn nhân viên
--Khi câu hỏi có tính toán gom data ( hàm aggregate) mà lại chứa từ khóa mỗi
--Gặp từ "mỗi", chính là chia để đếm , chia để trị, chia cụm để gom đếm
SELECT * FROM Employees

--Seatle 2 | Tacoma 1 | Kirland 1| Redmon 1| London 4
--Sự xuất hiện của nhóm
--Đếm theo sự xh của nhóm , count++ trong nhóm thoy, sau đó reset ở nhóm mới

SELECT COUNT(City) FROM Employees GROUP BY City--Đếm value của city , nhưng đếm theo nhóm
--											   --Chia city thành nhóm, rồi đếm trong nhóm

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City

SELECT EmployeeID, City, COUNT(City) AS [No employess] FROM Employees GROUP BY City, EmployeeID
--VÔ NGHĨA , CHIA NHÓM THEO KEY, MSSV VÔ NGHĨA
--Chốt hạ: Khi xài hàm gom nhóm, bạn có quyền liệt kê tên cột lẻ ở select
--		   Nhưng cột lẻ bắt buộc phải xuất hiện trong mệnh đề GROUP BY		
--		   Để đảm bảo logic: cột hiển thị | số lượng đi kèm, đếm gom theo cột hiển thị mới logic
--CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT LÀ HỢP LÍ
-->MUỐN HIỂN THỊ SỐ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, GOM NHÓM THEO CÁI GÌ ĐÓ


--NẾU BẠN GOM THEO KEY/PK, VÔ NGHĨA HENG, VÌ KEY HOK TRÙNG, MỖI THẰNG 1 NHÓM, ĐẾM CÁI GÌ
--MÃ SỐ SV  --- ĐẾM CÁI GÌ ??? VÔ NGHĨA
--MÃ CHUYÊN NGÀNH --- ĐẾM SỐ SV CHUYÊN NGÀNH!!!
--MÃ QUỐC GIA -- ĐẾM SỐ ĐƠN HÀNG
--ĐIỂM THI -- ĐẾM SỐ LƯỢNG SINH VIÊN ĐẠT ĐƯỢC ĐIỂM ĐÓ
--CÓ CỘT ĐỂ GOM, CỘT ĐÓ ĐỂ DÙNG ĐỂ HIỂN THỊ SỐ LƯỢNG KẾT QUẢ
--In ra mã nhân viên
--1 London 1
--2 Seatle 1
--3        1
--4




SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City

--9.Hãy cho biết thành phố có từ 2 nhân viên trở lên
--2 chặng làm
--9.1 Các thành phố có bao nhiêu nhân viên
--9.2 Đếm xong mỗi thành phố, ta bắt đầu lọc kết quả sau đếm
--FILTER SAU ĐẾM, WHERE SAU ĐẾM , WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City
SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City

SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City HAVING COUNT(*) >= 2


--10.Đếm số nhân viên của 2 thành phố Seattle và London
SELECT City, COUNT(*) AS [No employess] FROM Employees WHERE City = 'Seattle' OR  City = 'London' GROUP BY City --2 4


--11.Đếm số nhân viên của 2 thành phố Seattle và London , tp nào có nhiều hơn 3 nhân viên
SELECT City, COUNT(*) AS [No employess] FROM Employees 
					WHERE City = 'Seattle' OR  City = 'London' 
					GROUP BY City 
					HAVING COUNT(*) >= 3


--12.Đếm xem có bn đơn hàng đã bán ra
SELECT * FROM Orders
SELECT COUNT(*) AS[No Orders] FROM Orders --830
SELECT COUNT(OrderID) AS[No Orders] FROM Orders
--830 mã đơn khác nhau , đếm mã đơn, hay đếm cả cái đơn là như nhau
-- nếu cột có value Null ăn hành!!

--12.1 Nước Mĩ có bao nhiêu đơn hàng
--đi tìm Mĩ mà đếm, lọc Mĩ rồi tính tiếp , WHERE Mĩ
--KO PHẢI LÀ CÂU GOM NHÓM CHIA NHÓM, KO PHẢI MỖI QUỐC GIA BN ĐƠN MÀ CHIA NHÓM
--MỖI QG CÓ BN ĐƠN, COUNT THEO QUỐC GIA, GROUP BY QUỐC GIA 
SELECT COUNT(*) AS[No USA Orders] FROM Orders WHERE ShipCountry = 'USA'

--12.2 Mĩ, Anh, Pháp chiếm tổng bn đơn hàng
SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('USA','UK','France')--255 cho cả 3

--12.3 Mĩ, Anh, Pháp mỗi quốc gia có bn đơn hàng
SELECT ShipCountry, COUNT(ShipCountry) AS [No orders] FROM Orders 
					WHERE ShipCountry IN ('USA','UK','France')
					GROUP BY ShipCountry 
--12.4. Trong 3 qg Mĩ, Anh, Pháp , qg nào có 100 đơn hàng trở lên
SELECT ShipCountry, COUNT(ShipCountry) AS [No orders] FROM Orders 
					WHERE ShipCountry IN ('USA','UK','France')
					GROUP BY ShipCountry 
					HAVING COUNT(ShipCountry) >= 100
--14.Đếm xem có bn lượt quốc gia đã mua hàng
SELECT  COUNT(ShipCountry) AS [No of sell] FROM Orders
--15.Đếm xem có bn quốc gia đa mua hàng( mỗi quốc gia đếm 1 lần)
SELECT COUNT( DISTINCT ShipCountry) FROM Orders
--16.Đếm số lượng đơn hàng của mỗi quốc gia
SELECT ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry
--17.Quốc gia nào có từ 10  đơn hàng trở lên
SELECT ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= 10
--18.Đếm xem mỗi chủng loại có bn mặt hàng (bia rượi có 5 sp, thủy sản có 10sp)
SELECT * FROM Categories

--19.Thành phố nào có nhiều nhân viên nhất
SELECT City, COUNT(*) FROM Employees GROUP BY City HAVING COUNT(*) >= ALL ( SELECT COUNT(*) FROM Employees GROUP BY City)
--20.Quốc gia nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(ShipCountry) FROM Orders GROUP BY ShipCountry HAVING COUNT(ShipCountry) >= ALL(SELECT COUNT(ShipCountry) FROM Orders GROUP BY ShipCountry)
--21.Trong 3 qg Mĩ, Anh, Pháp , qg nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(ShipCountry) AS [No orders] FROM Orders 
					WHERE ShipCountry IN ('USA','UK','France')
					GROUP BY ShipCountry 
					HAVING COUNT(ShipCountry) >= ALL(SELECT COUNT(ShipCountry) FROM Orders WHERE ShipCountry IN ('USA','UK','France') GROUP BY ShipCountry)