Select j.JobID, j.JobTitle, count(e.EmployeeID) as NumberOfEmloyees
		from Jobs j join Employees e on j.JobID = e.JobID
		group by j.JobID, j.JobTitle
		having count(e.EmployeeID) = 
		(select max(tb1.NumberOfEmloyees) from(Select j.JobID, j.JobTitle, count(e.EmployeeID) as NumberOfEmloyees
		from Jobs j join Employees e on j.JobID = e.JobID
		group by j.JobID, j.JobTitle) as tb1)