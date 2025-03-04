Select p.PurchaseOrderID,p.SupplierID,s.SupplierName,p.OrderDate
	from PurchaseOrders p join Suppliers s on p.SupplierID=s.SupplierID
	where p.OrderDate between '2013-01-01' and '2013-01-03'