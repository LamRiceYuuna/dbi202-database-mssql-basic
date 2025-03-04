select s.store_id,s.store_name, count(o.order_id) as NumberOfOrdersIn2018
	from stores s join orders o on s.store_id = o.store_id
	where o.order_date between '2018-01-01' and '2018-12-31'
	group by s.store_id,s.store_name
	order by NumberOfOrdersIn2018 desc	

