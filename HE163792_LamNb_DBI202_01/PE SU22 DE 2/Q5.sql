select count1.DepartmentID, count1.Name, count1.NumberOfCourses, count2.NumberOfStudents 
	from
	(select d.DepartmentID, d.Name, count(c.CourseID) as NumberOfCourses
	from Department d join Course c on d.DepartmentID = c.DepartmentID
	group by d.DepartmentID, d.Name) as count1
	join 
	(select d.DepartmentID, count(distinct sg.StudentID) as NumberOfStudents
	from Department d join Course c on d.DepartmentID=c.DepartmentID
	join StudentGrade sg on sg.CourseID = c.CourseID
	group by d.DepartmentID) as count2
	on count1.DepartmentID = count2.DepartmentID
	order by count2.NumberOfStudents desc, count1.Name asc