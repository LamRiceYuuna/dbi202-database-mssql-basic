create trigger  Tr1
on PurchaseOrders
for insert
as
begin
	select i.PurchaseOrderID,i.SupplierID,i.OrderDate,i.ExpectedDeliveryDate,i.IsOrderFinalized,i.DeliveryMethod,s.SupplierName
	from inserted i join Suppliers s on i.SupplierID = s.SupplierID
end