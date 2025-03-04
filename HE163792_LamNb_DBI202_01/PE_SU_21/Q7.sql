
select st.store_name,o.staff_id,sf.first_name,sf.last_name, count(o.order_id) as NumberOfOrders
		from stores st  right join staffs sf on st.store_id = sf.store_id
		left join orders o on o.staff_id = sf.staff_id
		group by st.store_name,o.staff_id,sf.first_name,sf.last_name
		having count(o.order_id)
		=
		(select max(tb1.NumberOfOrders) from (select st.store_name,o.staff_id,sf.first_name,sf.last_name, count(o.order_id) as NumberOfOrders
		from stores st  right join staffs sf on st.store_id = sf.store_id
		left join orders o on o.staff_id = sf.staff_id
		group by st.store_name,o.staff_id,sf.first_name,sf.last_name) as tb1 )

select d1.store_name, d1.staff_id, d1.first_name, d1.last_name, d1.NumberOfOrders
from(select s.store_name, s1.staff_id, s1.first_name, s1.last_name, 
count(s.store_name) as NumberOfOrders
from stores s, staffs s1, orders o
where s1.store_id = s.store_id and o.store_id = s.store_id and o.staff_id = s1.staff_id
group by s.store_name, s1.staff_id, s1.first_name, s1.last_name) as d1
inner join (select b1.store_name, max(b1.NumberOfOrders) as num from (select s.store_name, count(s.store_name) as NumberOfOrders
from stores s, staffs s1, orders o
where s1.store_id = s.store_id and o.store_id = s.store_id and o.staff_id = s1.staff_id
group by s.store_name, s1.staff_id) as b1
group by b1.store_name) d2
on d2.store_name = d1.store_name and d2.num = d1.NumberOfOrders
order by d2.store_name ASC