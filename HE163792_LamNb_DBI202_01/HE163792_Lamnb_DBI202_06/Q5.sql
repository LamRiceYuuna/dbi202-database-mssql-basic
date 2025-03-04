select od.ProductID, p.ProductName, od.Quantity
		from Product p join OrderDetails od on p.ID = od.ProductID
		where od.Quantity =
		(select max(counts.Quantity) from
		(select od.ProductID, p.ProductName, od.Quantity
		from Product p join OrderDetails od on p.ID = od.ProductID) as counts)

