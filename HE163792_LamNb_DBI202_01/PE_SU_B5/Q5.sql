select c.customerNumber,c.customerName,c.city,c.state,c.country, count(distinct o.orderNumber) AS NumberOfOrders,sum(p.amount) as TotalPaymentAmount  
	from orders o join customers c on o.customerNumber = c.customerNumber
	join payments p on p.customerNumber = c.customerNumber
	where c.state in ('CA','NY') and c.country = 'USA'
	group by c.customerNumber, c.customerName,c.city,c.state,c.country
	order by c.state asc, c.customerName asc