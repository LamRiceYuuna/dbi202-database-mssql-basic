select e.employeeNumber, e.firstName + ' ' +e.lastName as [employeeFullname], e.jobTitle,e.officeCode, o.city as officeCity, o.state as officeState, o.country as officeCountry 
		from employees e  join offices o on e.officeCode = o.officeCode
		where o.country = 'France' or  o.country ='USA'
		order by officeCountry asc , officeCity asc,  e.employeeNumber asc