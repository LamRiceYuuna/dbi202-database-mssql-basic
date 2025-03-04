select l.LocationID,l.Name as [LocationName], count(distinct p.ProductID) as [NumberOfProducts]
	from Location l join  ProductInventory p on l.LocationID = p.LocationID
	group by l.LocationID,l.Name
	order by NumberOfProducts desc, LocationName asc