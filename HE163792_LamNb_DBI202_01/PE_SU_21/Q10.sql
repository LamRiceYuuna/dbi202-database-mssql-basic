update stocks set quantity = 30 where 
store_id = 1 and
product_id  in (select p.product_id from products p join stocks s on p.product_id = s.product_id 
	where p.category_name = 'Cruisers Bicycles' and s.store_id = 1)

