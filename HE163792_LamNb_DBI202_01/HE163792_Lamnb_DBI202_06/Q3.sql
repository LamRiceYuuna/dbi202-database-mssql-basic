select * from Customer c join Orders o on c.ID = o.CustomerID
	where CustomerName like 'B%' and o.OrderDate >='2017-12-1' and o.OrderDate <= '2017-12-31'
	order by c.Segment desc, c.CustomerName asc

