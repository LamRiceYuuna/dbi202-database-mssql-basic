--FPT UNIVERSITY HCMC - © 2021 GIÁO.LÀNG

--39 EXERCISES ON NORTHWIND DATABASE 
 USE Northwind
--1. In ra thông tin các sản phẩm (nhãn hàng/mặt hàng) có trong hệ thống
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, mã chủng loại, đơn giá, số lượng trong kho 
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp (quốc gia)
-- Output 3: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại
-- Output 4: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp
SELECT * FROM Products p--77

SELECT p.ProductID, p.ProductName, p.SupplierID, s.CompanyName, s.Country , p.UnitsInStock
						FROM Products p FULL JOIN Suppliers s 
						 ON p.SupplierID = s.SupplierID--77

SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName
						FROM Products p FULL JOIN Categories c
						ON p.CategoryID = c.CategoryID--77

SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName, s.SupplierID, s.CompanyName, s.Country
						FROM Products p  JOIN Categories c
						ON p.CategoryID = c.CategoryID
						JOIN Suppliers s ON p.SupplierID = s.SupplierID--77
--2. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Mỹ
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, đơn giá, số lượng trong kho, mã chủng loại, tên chủng loại 
SELECT p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock  FROM Products p JOIN Suppliers s
		 ON p.SupplierID = s.SupplierID
		 WHERE s.Country = 'USA'

SELECT p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock, c.CategoryID, c.CategoryName
		 FROM Products p FULL JOIN Suppliers s
		 ON p.SupplierID = s.SupplierID
		 FULL JOIN Categories c ON p.CategoryID = c.CategoryID
		 WHERE s.Country = 'USA'

--3. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Anh, Pháp, Mỹ
-- Output: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 

SELECT p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, s. Country, p.UnitPrice, p.UnitsInStock 
		FROM Products p JOIN Suppliers s
		ON p.SupplierID = s.SupplierID
		WHERE s.Country IN ('UK', 'France', 'USA')--24
--4. Có bao nhiêu nhà cung cấp?
SELECT COUNT(*) AS [No Suppliers ] FROM Suppliers

--5. Có bao nhiêu nhà cung cấp đến từ Mỹ
SELECT COUNT(*) AS [No Suppliers USA ] FROM Suppliers WHERE Country = 'USA'
--6. Nhà cung cấp Exotic Liquids cung cấp những sản phẩm nào
--- Output 1: mã sản phẩm, tên sản phẩm, đơn giá, số lượng trong kho
--- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
--- Output 3: mã nhà cung cấp, tên nhà cung cấp, mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
 
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock FROM Suppliers s JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 WHERE s.CompanyName = 'Exotic Liquids'

SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName FROM Suppliers s FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 WHERE s.CompanyName = 'Exotic Liquids'

SELECT p.SupplierID, s.CompanyName,p.ProductID, p.ProductName, p.CategoryID, c.CategoryName FROM Suppliers s FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 WHERE s.CompanyName = 'Exotic Liquids'
--7. Mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng (nhãn hàng)
--- Output 1: mã nhà cung cấp, số lượng mặt hàng
--- Output 2: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SELECT s.SupplierID, COUNT ( DISTINCT c.CategoryName) AS [So luong mat hang] 
		 FROM  Suppliers s  FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 GROUP BY s.SupplierID
		 ORDER BY s.SupplierID 

SELECT s.SupplierID,s.CompanyName , COUNT ( DISTINCT c.CategoryName) AS [So luong mat hang] 
		 FROM  Suppliers s  FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 GROUP BY s.SupplierID,s.CompanyName 
		 ORDER BY s.SupplierID
--8. Nhà cung cấp Exotic Liquids cung cấp bao nhiêu nhãn hàng?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SELECT s.SupplierID,s.CompanyName , COUNT ( DISTINCT c.CategoryName) AS [So luong mat hang] 
		 FROM  Suppliers s  FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 WHERE s.CompanyName = 'Exotic Liquids'
		 GROUP BY s.SupplierID,s.CompanyName 
		 
--9. Nhà cung cấp nào cung cấp nhiều nhãn hàng nhất?
--- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
SELECT TOP(1) WITH TIES s.SupplierID,s.CompanyName , COUNT (DISTINCT  c.CategoryName) AS SL 
		 FROM  Suppliers s  FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 GROUP BY s.SupplierID,s.CompanyName
		 ORDER BY SL DESC 

		 
									
--10. Liệt kê các nhà cung cấp cung cấp từ 3 nhãn hàng trở lên
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
SELECT s.SupplierID,s.CompanyName , COUNT (DISTINCT  c.CategoryName) AS SL 
		 FROM  Suppliers s  FULL JOIN Products p 
		 ON s.SupplierID = p.SupplierID
		 FULL JOIN Categories c ON c.CategoryID = p.CategoryID
		 GROUP BY s.SupplierID,s.CompanyName 
		 HAVING COUNT (DISTINCT  c.CategoryName) >= 3
--11. Có bao nhiêu nhóm hàng/chủng loại hàng
SELECT * FROM Categories
--12. In ra thông tin các sản phẩm (mặt hàng) kèm thông tin nhóm hàng
-- Output: mã nhóm hàng, tên nhóm hàng, mã sản phẩm, tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName 
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
--13. Liệt kê các sản phẩm thuộc nhóm hàng Seafood
-- Output 1: mã sản phẩm, tên sản phẩm
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName 
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 WHERE c.CategoryName = 'Seafood'--12

SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName 
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 WHERE c.CategoryName = 'Seafood'--12
--14. Liệt kê các sản phẩm thuộc nhóm hàng Seafood và Beverages, sắp xếp theo nhóm hàng
-- Output 1: mã sản phẩm, tên sản phẩm
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName 
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 WHERE c.CategoryName IN ('Seafood','Beverages')
		 ORDER BY c.CategoryName

SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName  
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 WHERE c.CategoryName IN ('Seafood','Beverages')
		 ORDER BY c.CategoryName--24
--15. Mỗi nhóm hàng có bao nhiêu nhãn hàng/mặt hàng
-- Output 1: mã nhóm hàng số lượng nhãn hàng 
-- Output 2: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
SELECT  c.CategoryID , COUNT(c.CategoryName) as [SL Nhan Hang]
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 GROUP BY c.CategoryName, c.CategoryID

SELECT  c.CategoryID , c.CategoryName, COUNT( c.CategoryName) as [SL Nhan Hang]
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 GROUP BY c.CategoryName, c.CategoryID

SELECT  p.ProductName, c.CategoryName
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 ORDER BY c.CategoryName
--16. Nhóm hàng nào có nhiều nhãn hàng/mặt hàng nhất
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 

SELECT TOP(1) WITH TIES  c.CategoryID , c.CategoryName, COUNT( c.CategoryName) as [SL Nhan Hang]
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 GROUP BY c.CategoryName, c.CategoryID
		 ORDER BY [SL Nhan Hang] DESC
--17. Nhóm hàng nào có từ 10 nhãn hàng/mặt trở lên
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
SELECT c.CategoryID , c.CategoryName, COUNT( c.CategoryName) as [SL Nhan Hang]
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 GROUP BY c.CategoryName, c.CategoryID
		 HAVING COUNT( c.CategoryName) >= 10
--18. In ra số lượng nhãn hàng/mặt hàng của 2 nhóm hàng Seafood và Beverages 
--- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID , c.CategoryName, COUNT( c.CategoryName) as [SL Nhan Hang]
		 FROM Categories c JOIN Products p
		 ON c.CategoryID = p.CategoryID
		 WHERE c.CategoryName = 'Seafood' OR c.CategoryName = 'Beverages'
		 GROUP BY c.CategoryName, c.CategoryID

--19. In ra tất cả các đơn hàng
-- Output 1: Mã đơn hàng, mã khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- Output 3: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, mã công ty vận chuyển, tên công ty vận chuyển, gửi tới quốc gia nào
SELECT OrderID, CustomerID, EmployeeID, OrderDate, ShipCountry FROM Orders

SELECT o.OrderID,c.CustomerID, c.CompanyName, e.EmployeeID, e.FirstName +' '+ e.LastName as FullName, o.OrderDate, o.ShipCountry
		FROM Orders o FULL JOIN Customers c ON o.CustomerID = c.CustomerID
		FULL JOIN Employees e ON e.EmployeeID = o.EmployeeID
--20. In ra các đơn hàng gửi tới Mỹ
-- Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID,c.CustomerID, c.CompanyName, e.EmployeeID, o.OrderDate, o.ShipCountry
		FROM Orders o FULL JOIN Customers c ON o.CustomerID = c.CustomerID
		FULL JOIN Employees e ON e.EmployeeID = o.EmployeeID
		WHERE o.ShipCountry = 'USA'

SELECT o.OrderID,c.CustomerID, c.CompanyName, e.EmployeeID, o.OrderDate, o.ShipCountry
		FROM Orders o FULL JOIN Customers c ON o.CustomerID = c.CustomerID
		FULL JOIN Employees e ON e.EmployeeID = o.EmployeeID
		WHERE o.ShipCountry = 'USA'
--21. In ra các đơn hàng gửi tới Anh, Pháp, Mỹ
-- Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID,c.CustomerID, c.CompanyName, e.EmployeeID, o.OrderDate, o.ShipCountry
		FROM Orders o FULL JOIN Customers c ON o.CustomerID = c.CustomerID
		FULL JOIN Employees e ON e.EmployeeID = o.EmployeeID
		WHERE o.ShipCountry IN( 'USA','France','UK')

SELECT o.OrderID,c.CustomerID, c.CompanyName, e.EmployeeID, o.OrderDate, o.ShipCountry
		FROM Orders o FULL JOIN Customers c ON o.CustomerID = c.CustomerID
		FULL JOIN Employees e ON e.EmployeeID = o.EmployeeID
		WHERE o.ShipCountry IN( 'USA','France','UK')

--22. Có tổng cộng bao nhiêu đơn hàng?
SELECT COUNT(*)  FROM Orders 
SELECT *  FROM Orders 
SELECT * FROM Customers
SELECT * FROM Employees
--23. In ra tổng số chi tiết của mỗi đơn hàng (mỗi đơn hàng có bao nhiêu dòng chi tiết)
-- Output 1: Mã đơn hàng, số lượng chi tiết đơn hàng
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, số lượng chi tiết đơn hàng
SELECT * FROM [Order Details]
SELECT a.OrderID,COUNT(a.OrderID ) AS [SL CT MDH] FROM Orders a FULL JOIN [Order Details] b
		 ON a.OrderID = b.OrderID
		GROUP BY a.OrderID

SELECT a.OrderID,c.CustomerID,c.CompanyName, COUNT(a.OrderID ) AS [SL CT MDH] FROM Orders a FULL JOIN [Order Details] b
		 ON a.OrderID = b.OrderID
		 FULL JOIN Customers c ON c.CustomerID = a.CustomerID
		GROUP BY a.OrderID,c.CustomerID,c.CompanyName
--24. HẮC NÃO!!!!! - Tính tổng tiền của mỗi đơn hàng (nhớ trừ tiền giảm giá tùy theo từng đơn)
-- Output 1: mã đơn hàng, tổng tiền (830 dòng) 
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền

SELECT a.OrderID, SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		  JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID 
		 ORDER BY a.OrderID 
SELECT a.OrderID,c.CustomerID,c.CompanyName ,SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID,c.CustomerID,c.CompanyName 
		 ORDER BY a.OrderID
--25. In ra các đơn hàng có tổng tiền từ 1000$ trở lên
-- Output 1: mã đơn hàng, tổng tiền
-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền

SELECT a.OrderID, SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		  JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID 
		 HAVING SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) >= 1000
		 ORDER BY a.OrderID

SELECT a.OrderID,c.CustomerID,c.CompanyName ,SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a FULL JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 FULL JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID,c.CustomerID,c.CompanyName
		 HAVING SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) >= 1000
		 ORDER BY a.OrderID
--26. Tính tiền của các đơn hàng gửi tới Mỹ (tính riêng cho từng đơn hàng)
-- Output: mã đơn hàng, quốc gia, tổng tiền
SELECT a.OrderID,a.ShipCountry ,SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID,a.ShipCountry
		 HAVING a.ShipCountry = 'USA'
		 ORDER BY a.OrderID
--27. Tính tổng tiền của tất cả các đơn hàng gửi tới Mỹ (gom tổng)
-- Output: quốc gia, tổng tiền

SELECT a.ShipCountry ,SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.ShipCountry
		 HAVING a.ShipCountry = 'USA'
--28. Tính tiền của các đơn hàng gửi tới Anh, Pháp, Mỹ (tính riêng cho từng đơn hàng)
-- Output: quốc gia, mã đơn hàng, tổng tiền
SELECT a.OrderID,a.ShipCountry ,SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 GROUP BY a.OrderID,a.ShipCountry
		 HAVING a.ShipCountry in('USA','UK','France')--255
--29. Tổng số tiền thu được từ tất cả các đơn hàng là bao nhiêu?
SELECT SUM(b.UnitPrice * b.Quantity * (1 - b.Discount)) AS TotalMoney FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID

--30. In ra số lượng đơn hàng của mỗi khách hàng
-- Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua
SELECT * FROM Customers
SELECT c.CustomerID, c.CompanyName, COUNT(a.OrderID) FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 group by c.CustomerID, c.CompanyName
		 ORDER BY c.CustomerID

SELECT c.CustomerID, b.OrderID FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 ORDER BY c.CustomerID
--31. Khách hàng nào có nhiều đơn hàng nhất?
-- Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua
SELECT TOP(1) WITH TIES  c.CustomerID, c.CompanyName, COUNT(a.OrderID) AS SLDM FROM Orders a  JOIN [Order Details] b
		 ON a.OrderID = b.OrderID 
		 JOIN Customers c ON c.CustomerID = a.CustomerID
		 group by c.CustomerID, c.CompanyName
		 ORDER BY SLDM DESC

--32. Có bao nhiêu công ty giao hàng?
SELECT * FROM Shippers
SELECT * FROM Orders
SELECT COUNT( DISTINCT CompanyName) AS [No CT giao hang] FROM Shippers
--33. In ra số lượng đơn hàng mỗi công ty đã vận chuyển
-- Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName, COUNT(o.OrderID) AS SLVC  FROM Orders o RIGHT JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		GROUP BY s.CompanyName, s.ShipperID

--34. Công ty nào vận chuyển nhiều đơn hàng nhất?
-- Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
SELECT TOP(1) WITH TIES s.ShipperID, s.CompanyName, COUNT(o.OrderID) AS SLVC  FROM Orders o RIGHT JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		GROUP BY s.CompanyName, s.ShipperID
		ORDER BY SLVC DESC
--35. In ra các đơn hàng vận chuyển bởi công ty Speedy Express
-- Output 1: Mã đơn hàng, ngày đặt hàng, mã công ty giao hàng
-- Output 2: Mã đơn hàng, ngày đặt hàng, gửi tới quốc gia nào, mã công ty giao hàng, tên công ty giao hàng
SELECT o.OrderID, o.OrderDate, s.ShipperID  FROM Orders o FULL JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		WHERE s.CompanyName = 'Speedy Express'
SELECT o.OrderID, o.OrderDate, o.ShipCountry, s.ShipperID ,s.CompanyName FROM Orders o  JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		WHERE s.CompanyName = 'Speedy Express'
--36. Công ty Speedy Express đã vận chuyển bao nhiêu đơn hàng 
-- Output: Mã công ty giao hàng, tên công ty, số lượng đơn đã vận chuyển
SELECT s.ShipperID,s.CompanyName , COUNT(o.OrderDate) AS SLDH FROM Orders o  JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		WHERE s.CompanyName = 'Speedy Express'
		GROUP BY s.CompanyName, s.ShipperID
--37. Thêm công ty giao hàng sau vào database bằng cách chạy lệnh sau
    
    INSERT INTO Shippers VALUES('UPS Vietnam', '(+84) 909...')
    
    --sau đó in ra số lượng đơn hàng mỗi công ty đã vận chuyển

-- Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName, COUNT(o.OrderID) AS SLVC  FROM Orders o RIGHT JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		GROUP BY s.CompanyName, s.ShipperID

--38. Tiếp nối câu trên, in ra thông tin vận chuyển hàng của các công ty giao vận, sắp xếp theo mã số công ty giao vận
-- Output: Mã công ty giao hàng, tên công ty giao hàng, mã đơn hàng, ngày đặt hàng
SELECT s.ShipperID, s.CompanyName, o.OrderID,o.OrderDate  FROM Orders o RIGHT JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		ORDER BY s.ShipperID

--39. Tiếp nối câu trên, công ty UPS Vietnam vận chuyển những đơn hàng nào?
-- Output: Mã công ty giao hàng, tên công ty giao hàng, mã đơn hàng, ngày đặt hàng
SELECT s.ShipperID, s.CompanyName, o.OrderID,o.OrderDate  FROM Orders o RIGHT JOIN Shippers s 
		ON o.ShipVia = s.ShipperID
		WHERE s.CompanyName = 'UPS Vietnam'
		ORDER BY s.ShipperID