Create trigger tr_delete_productInventory_location
on ProductInventory
for delete
as 
begin
	select d.ProductID,d.LocationID,l.Name as LocationName, d.Shelf,d.Bin,d.Quantity
		from deleted d join Location l on l.LocationID = d.LocationID

end
