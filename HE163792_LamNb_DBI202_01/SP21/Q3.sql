Select customer_id,first_name,last_name,city,state
	from customers where city in('Bellmore','New York') and state = 'NY'
	order by city asc