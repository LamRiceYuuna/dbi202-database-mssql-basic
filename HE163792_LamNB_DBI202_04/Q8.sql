create proc Proc1
@SupplierName nvarchar(50),
@OrderYear int, 
@numberOfPurchaseOrders int output
as 
begin
	set @numberOfPurchaseOrders =(select count(po.PurchaseOrderID) 
								from PurchaseOrders po join Suppliers s on po.SupplierID = s.SupplierID
								where s.SupplierName = @SupplierName and year(po.OrderDate) = @OrderYear) 
end

