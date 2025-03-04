Select product_name,model_year, list_price, brand_name 
	from products
	where brand_name = 'Trek' and model_year = 2018 and list_price > 3000
	order by list_price asc