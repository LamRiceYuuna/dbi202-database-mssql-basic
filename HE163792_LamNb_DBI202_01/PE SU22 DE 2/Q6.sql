select d.DepartmentID, d.Name, count(oc.CourseID) as NumberOfOnlineCourses
		from Department d join Course c
		on d.DepartmentID = c.DepartmentID
		join OnlineCourse oc on oc.CourseID = c.CourseID
		group by d.DepartmentID, d.Name
		having count(oc.CourseID) = 
		(select max (count1.NumberOfOnlineCourses) from(select d.DepartmentID, d.Name, count(oc.CourseID) as NumberOfOnlineCourses
		from Department d join Course c
		on d.DepartmentID = c.DepartmentID
		join OnlineCourse oc on oc.CourseID = c.CourseID
		group by d.DepartmentID, d.Name) as count1)