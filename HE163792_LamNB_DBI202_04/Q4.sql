Select po.PurchaseOrderID,po.SupplierID,po.OrderDate,pol.StockItemID,
	si.StockItemName,pol.OrderedOuters
	from PurchaseOrders po join PurchaseOrderLines pol 
	on po.PurchaseOrderID = pol.PurchaseOrderID
	join StockItems si on si.StockItemID = pol.StockItemID
	where po.OrderDate between '2016-01-01' and '2016-01-05'
	order by po.PurchaseOrderID asc, si.StockItemName asc