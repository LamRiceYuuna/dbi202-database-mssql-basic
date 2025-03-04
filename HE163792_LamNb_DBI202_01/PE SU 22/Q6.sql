select c.DepartmentID,d.Name, count(c.CourseID) as NumberOfOnsiteCourses
			from Department d join Course c 
			on d.DepartmentID = c.DepartmentID
			join OnsiteCourse oc on c.CourseID = oc.CourseID
			group by c.DepartmentID,d.Name 
			having count(c.CourseID) =
			(select min(counts.NumberOfOnsiteCourses) from
			(select c.DepartmentID,d.Name, count(c.CourseID) as NumberOfOnsiteCourses
			from Department d join Course c 
			on d.DepartmentID = c.DepartmentID
			join OnsiteCourse oc on c.CourseID = oc.CourseID
			group by c.DepartmentID,d.Name) as counts)

