Select o.officeCode,o.city,o.state,o.country,e.employeeNumber,
		e.lastName,e.firstName,e.jobTitle,min(count(c.customerNumber)) as NumberOfCustomers
		from offices o full join employees e
		on o.officeCode = e.officeCode
		full join customers c on c.salesRepEmployeeNumber = e.employeeNumber
		group by o.officeCode,o.city,o.state,o.country,e.employeeNumber,
		e.lastName,e.firstName,e.jobTitle,count(c.customerNumber)

select * from offices

Select o.officeCode,e.employeeNumber,count( c.customerNumber) as NumberOfCustomers
		from offices o full join employees e
		on o.officeCode = e.officeCode
		full join customers c on c.salesRepEmployeeNumber = e.employeeNumber
		where e.jobTitle = 'Sales Rep'
		group by  o.officeCode,e.employeeNumber

select tb1.officeCode,min(tb1.NumberOfCustomers) as NumberOfCustomers
	from(Select o.officeCode,e.employeeNumber,count( c.customerNumber) as NumberOfCustomers
		from offices o full join employees e
		on o.officeCode = e.officeCode
		full join customers c on c.salesRepEmployeeNumber = e.employeeNumber
		where e.jobTitle = 'Sales Rep'
		group by  o.officeCode,e.employeeNumber) as tb1
		group by tb1.officeCode

Select o.officeCode,e.employeeNumber,count( c.customerNumber) as NumberOfCustomers
		from offices o full join employees e
		on o.officeCode = e.officeCode
		full join customers c on c.salesRepEmployeeNumber = e.employeeNumber
		where e.jobTitle = 'Sales Rep'
