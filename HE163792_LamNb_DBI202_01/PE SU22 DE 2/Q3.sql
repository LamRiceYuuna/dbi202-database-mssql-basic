select oc.CourseID, c.Title, c.Credits, c.DepartmentID,oc.URL 
		from Course c  join OnlineCourse oc 
		on c.CourseID = oc .CourseID
		order by c.DepartmentID asc, c.Title asc

