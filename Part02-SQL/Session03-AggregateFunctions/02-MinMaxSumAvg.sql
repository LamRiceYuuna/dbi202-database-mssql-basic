	USE Northwind
----------------------------------------------------------------------
--LÍ THUYẾT
--DB ENGINE hộ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán 
--trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
--COUNT() SUM() MIN() MAX() AVG()
--*CÚ PHÁP:
--SELECT CỘT ..., HÀM GOM NHÓM().,...FROM<TABLE> WHERE .... GROUP BY..., HAVING(WHERE THỨ 2)

--------------------------------------------------------
--THỰC HÀNH
--1.Liệt kê danh sách nhân viên
SELECT * FROM Employees

--2.Năm sinh nào là bé nhất(tuổi max)
SELECT MIN(BirthDate) FROM Employees
SELECT MAX(BirthDate) FROM Employees

--3.Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
SELECT * FROM Employees 
	             WHERE BirthDate = (
								SELECT MIN(BirthDate) FROM Employees						
									)
SELECT * FROM Employees 
	             WHERE BirthDate <= ALL(
								SELECT MIN(BirthDate) FROM Employees						
									)
SELECT * FROM Employees 
	             WHERE BirthDate <= ALL(
								SELECT BirthDate FROM Employees						
									)
--4. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
--4.1 Trọng lượng nào là lớn nhất trong các đơn hàng đã bán
SELECT * FROM Orders ORDER BY Freight
SELECT * FROM Orders WHERE Freight = (
					SELECT MIN(Freight) AS MinFreight FROM Orders
									)
									SELECT * FROM Orders WHERE Freight = (
					SELECT MAX(Freight) AS MinFreight FROM Orders
									)
SELECT MIN(Freight) AS MinFreight FROM Orders
SELECT MAX(Freight) AS MaxFreight FROM Orders

--5.Tính tổng khối lượng của các đơn hàng đã vận chuyển
--830 đơn hàng
SELECT * FROM Orders
SELECT COUNT(*) FROM Orders
SELECT SUM(Freight) AS [Sum Of Freight] FROM Orders

--6.Trung bình các đơn hàng nặng bao nhiêu???

SELECT AVG(Freight) AS [AVG Of Freight] FROM Orders

--7.Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT * FROM Orders WHERE Freight >= (
SELECT AVG(Freight) AS [AVG Of Freight] FROM Orders
									)

--8. Có bn đơn hàng có trọng lượng lớn hơn trọng lượng trung bình của tất cả
SELECT COUNT(Freight) AS [AVG] FROM Orders WHERE Freight >= (
					SELECT AVG(Freight) AS [AVG Of Freight] FROM Orders
									) 
SELECT COUNT(*) FROM (
				SELECT * FROM Orders 
						WHERE Freight >= (
						     SELECT AVG(Freight) FROM Orders
							 ) ) AS [AVG]

									) 
			
--chỉ những thằng lớn hơn trung bình thì mới đếm, hok chia nhóm à ngen	

--CỘT XH TRONG SELECT HÀM Ý ĐẾM THEO CỘT NÀY
--TÍNH  <ĐẾM CÁI GÌ ĐÓ CỦA TỈNH> -> RÕ RÀNG PHẢI CHIA THEO TỈNH MÀ ĐẾM
													--GROUP BY TỈNH	
--CHUYÊN NGÀNH , <ĐẾM CHUYÊN NGÀNH> -> CHIA THEO CN MÀ ĐẾM
                                    --GROUP BY CHUYÊN NGÀNH
						
--CÓ QUYỀN GROUP BY TRÊN NHIỀU CỘT
--MÃ CHUYÊN NGÀNH, TÊN CHUYÊN NGÀNH<SL SV> -> GROUP BY MÃ CN , TÊN CN

--ÔN TẬP THÊM
--1.In danh sách nhân viên
SELECT * FROM Employees

--2.Đếm xem mỗi khu vực có bao nhiêu nhân viên
SELECT Region, COUNT(*) FROM Employees GROUP BY Region--4(NULL)5(WA)
                                            --2 NHÓM REGION, 2 CỤM REGION :WA, NULL
SELECT Region, COUNT(Region) FROM Employees GROUP BY Region
--0 VÀ 5, DO NULL KO ĐC XEM LÀ VALUE ĐỂ ĐẾM, NHƯNG VẪN LÀ MỘT VALUE ĐỂ ĐC CHIA NHÓM
                                                       --NHÓM KO CÓ GIÁ TRỊ

--3.Khảo sát đơn hàng
SELECT * FROM Orders
--Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(ShipCountry) FROM Orders GROUP BY ShipCountry

--4. Quốc gia nào nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry
					HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM Orders GROUP BY ShipCountry)

SELECT MAX([No Orders]) AS CntryMaxOrders FROM (
SELECT ShipCountry, COUNT(*) AS [No Orders] FROM Orders GROUP BY ShipCountry
) AS Cntry


SELECT ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry
					HAVING COUNT(*) = (SELECT MAX([No Orders]) AS CntryMaxOrders FROM (
							SELECT ShipCountry, COUNT(*) AS [No Orders] FROM Orders GROUP BY ShipCountry
							) AS Cntry
							)

--5. LIỆT KÊ CÁC ĐƠN HÀNG CỦA K/H MÃ SỐ VINET
SELECT * FROM Orders WHERE CustomerID = 'VINET'

--6.VINET ĐÃ MUA BAO NHIÊU LẦN
SELECT CustomerID , COUNT(*) FROM Orders 
                 WHERE CustomerID = 'VINET'  --ERROR

SELECT CustomerID , COUNT(*) FROM Orders 
                          WHERE CustomerID = 'VINET'
						  GROUP BY CustomerID
						  --CHIA THEO MÃ KHÁCH HÀNG MÀ ĐẾM , 
						  --ĐẾM XOG LOẠI ĐI THG KO PHẢI LÀ VINET

SELECT CustomerID , COUNT(*) FROM Orders 
                          
						  GROUP BY CustomerID
						  HAVING CustomerID = 'VINET'