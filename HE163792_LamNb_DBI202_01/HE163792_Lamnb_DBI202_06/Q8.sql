create proc TotalAmount 
@OrderID nvarchar(255),
@TotalAmount float output
as
begin
	set @TotalAmount = (select SUM(od.Quantity*od.SalePrice*(1- od.Discount)) 
				from OrderDetails od  join Orders o on od.OrderID = o.ID
				where od.OrderID = @OrderID
				group by od.OrderID
				)
end
