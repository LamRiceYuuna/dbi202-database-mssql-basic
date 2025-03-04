create proc Proc1
@customerNumber int,
@numberOfOrders int output
as
begin
	set @numberOfOrders = (select count(o.orderNumber) from orders o join customers c on o.customerNumber = o.customerNumber
							where c.customerNumber = @customerNumber )
end	