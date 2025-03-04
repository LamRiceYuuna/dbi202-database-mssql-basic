Select s.staff_id,s.first_name,s.last_name,count(distinct o.order_id) as [NumberOfOrders]
	from staffs s left join orders o on s.store_id = o.store_id
	where year(o.order_date) = 2016 
	group by s.staff_id,s.first_name,s.last_name
	order by NumberOfOrders desc
	

select * from staffs


select distinct s.staff_id, s.first_name, s.last_name, count(o.order_id) as NumberOfOrders from staffs s 
join orders o on o.store_id = s.store_id
where year(o.order_date) = 2016
group by s.staff_id, s.first_name, s.last_name
order by NumberOfOrders