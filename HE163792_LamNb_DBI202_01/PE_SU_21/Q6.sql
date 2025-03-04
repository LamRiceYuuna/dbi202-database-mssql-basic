Select p.product_id,p.product_name,p.model_year, sum(s.quantity) as [TotalStockQuantity]
	from products p join stocks s on p.product_id = s. product_id
	group by p.product_id,p.product_name,p.model_year
	having sum(s.quantity) =
	(select max(tb1.TotalStockQuantity) from
	(select p.product_id,p.product_name,p.model_year,sum(s.quantity) as[TotalStockQuantity] 
		from products p join stocks s on p.product_id = s. product_id
		group by p.product_id,p.product_name,p.model_year) as tb1)
