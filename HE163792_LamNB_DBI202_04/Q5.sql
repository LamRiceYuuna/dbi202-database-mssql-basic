Select s.SupplierID,s.SupplierName, count(si.StockItemID) as [NumberOfStockItem]
	from Suppliers s left join StockItems si 
	on s.SupplierID = si.SupplierID
	group by s.SupplierID,s.SupplierName
	order by NumberOfStockItem desc, s.SupplierName asc