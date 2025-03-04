select od.ProductID, p.ProductName, count(od.OrderID) as NumberOfOrders
	from Product p join OrderDetails od on p.ID = od.ProductID
	group by od.ProductID, p.ProductName
	having count(od.OrderID) =
	(select min(counts.NumberOfOrders) from
	(select od.ProductID, p.ProductName, count(od.OrderID) as NumberOfOrders
	from Product p join OrderDetails od on p.ID = od.ProductID
	group by od.ProductID, p.ProductName) as counts)