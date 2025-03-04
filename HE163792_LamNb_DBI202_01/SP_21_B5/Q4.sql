Select e.EmployeeID,e.FirstName,e.LastName,e.Salary,d.DepartmentName,l.StateProvince,l.CountryID 
		from Employees e full join Departments d on e.DepartmentID = d.DepartmentID
		full join Locations l on l.LocationID = d.LocationID
		where e.Salary > 3000 and l.StateProvince ='Washington'  and l.CountryID = 'US'
