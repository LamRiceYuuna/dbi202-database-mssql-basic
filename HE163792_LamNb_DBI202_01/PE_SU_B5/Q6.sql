select e.employeeNumber, e.lastName, e.firstName, count(c.customerNumber) as NumberOfCustomers
	from employees e  left join customers c on e.employeeNumber = c.salesRepEmployeeNumber
	where e.jobTitle = 'Sales Rep'
	group by e.employeeNumber, e.lastName, e.firstName
	having count(c.customerNumber) = 
	(select max (countMax.NumberOfCustomers) from (select e.employeeNumber, e.lastName, e.firstName, count(c.customerNumber) as NumberOfCustomers
	from employees e  left join customers c on e.employeeNumber = c.salesRepEmployeeNumber
	where e.jobTitle = 'Sales Rep'
	group by e.employeeNumber, e.lastName, e.firstName) as countMax)
	union all
select e.employeeNumber, e.lastName, e.firstName, count(c.customerNumber) as NumberOfCustomers
	from employees e  left join customers c on e.employeeNumber = c.salesRepEmployeeNumber
	where e.jobTitle = 'Sales Rep'
	group by e.employeeNumber, e.lastName, e.firstName
	having count(c.customerNumber) = 
	(select min (countMin.NumberOfCustomers) from (select e.employeeNumber, e.lastName, e.firstName, count(c.customerNumber) as NumberOfCustomers
	from employees e  left join customers c on e.employeeNumber = c.salesRepEmployeeNumber
	where e.jobTitle = 'Sales Rep'
	group by e.employeeNumber, e.lastName, e.firstName) as countMin)