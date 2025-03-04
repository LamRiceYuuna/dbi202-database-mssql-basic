Select  MONTH(OrderDate) as [OrderMonth], Year(OrderDate) as [OrderYear],
	count(PurchaseOrderID) as [NumberOfPurchaseOrders]
	from PurchaseOrders 
	group by MONTH(OrderDate),Year(OrderDate)
	having count(PurchaseOrderID) = 
	(select min(tb1.NumberOfPurchaseOrders) from (Select  MONTH(OrderDate) as [OrderMonth], Year(OrderDate) as [OrderYear],
	count(PurchaseOrderID) as [NumberOfPurchaseOrders]
	from PurchaseOrders 
	group by MONTH(OrderDate),Year(OrderDate)) as tb1)