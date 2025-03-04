Create trigger Tr2
on stocks
for delete
as 
begin
	select d.product_id,p.product_name,d.store_id,s.store_name,d.quantity
	from deleted d join products p on d.product_id = p.product_id
	join stores s on s.store_id = d.store_id
end
