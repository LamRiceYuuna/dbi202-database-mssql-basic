select c.CourseID,c.Title,c.Credits,c.DepartmentID,ci.PersonID,p.LastName,p.FirstName 
	from Course c left join CourseInstructor ci on c.CourseID = ci.CourseID
	left join Person p on p.PersonID = ci.PersonID
	where c.DepartmentID = 4 or c.DepartmentID = 7
	order by c.DepartmentID asc, c.Title asc