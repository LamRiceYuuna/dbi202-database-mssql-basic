select pdi.ProductID,p.Name, sum(pdi.Quantity) as TotalQuantity from Product p join ProductInventory pdi 
	on p.ProductID = pdi.ProductID
	group by pdi.ProductID,p.Name
	having sum(pdi.Quantity) = 
	(select max(tb1.TotalQuantity) from 
	(select pdi.ProductID,p.Name, sum(pdi.Quantity) as TotalQuantity from Product p join ProductInventory pdi 
	on p.ProductID = pdi.ProductID
	group by pdi.ProductID,p.Name) as tb1)