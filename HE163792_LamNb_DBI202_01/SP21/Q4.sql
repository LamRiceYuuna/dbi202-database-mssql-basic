Select p.product_id,p.product_name,p.list_price,p.brand_name,p.category_name,s.store_id,s.quantity
	from products p join stocks s on p.product_id = s.product_id
	where s.store_id = 1 and s.quantity > 25
	order by p.category_name asc,p.list_price desc