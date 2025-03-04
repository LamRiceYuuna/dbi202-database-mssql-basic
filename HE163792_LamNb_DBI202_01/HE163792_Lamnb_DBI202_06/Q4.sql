select od.OrderID, o.OrderDate, SUM(od.Quantity*od.SalePrice*(1- od.Discount))  as TotalAmount
		from Orders o join OrderDetails od on o.ID = od.OrderID
		group by od.OrderID, o.OrderDate
		having SUM(od.Quantity*od.SalePrice*(1- od.Discount)) > 8000
		order by TotalAmount desc

