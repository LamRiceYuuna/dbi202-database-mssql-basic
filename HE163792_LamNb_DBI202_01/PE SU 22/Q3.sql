select c.CourseID,c.Title,c.Credits,c.DepartmentID,o.URL 
			  from Course c join OnlineCourse o 
			  on c.CourseID = o.CourseID
			  order by c.DepartmentID asc, c.Title asc