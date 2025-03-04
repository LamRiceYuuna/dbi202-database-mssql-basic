select pm.ModelID,pm.Name as [ModelName],p.ProductID, p.Name as [ProductName],count(p.ProductID) as [NumberOfLocations]
		from ProductInventory pit left join Product p 
		on pit.ProductID= p.ProductID
		right join ProductModel pm on pm.ModelID = p.ModelID
		where pm.Name like 'HL Mountain%'
		group by pm.ModelID,pm.Name,p.ProductID, p.Name
