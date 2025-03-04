select c.PersonID,c.LastName,c.FirstName,c.HireDate,c.Discriminator,b.CourseID,a.Title,a.DepartmentID 
		from Course a full join CourseInstructor b 
		on a.CourseID = b.CourseID
		full join  Person c on b.PersonID = c.PersonID
		where c.Discriminator = 'Instructor'
		order by a.DepartmentID desc, a.Title asc