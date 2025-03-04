use Lab2_DBI202
Select a.CourseID,a.Name[CourseName], a.Credits,c.StudentID,c.LastName,c.FirstName,d.Name[DepartmentName],
	b.Year,b.Semester,b.Mark
    from Courses a full join Results b on a.CourseID=b.CourseID
	full join Students c on c.StudentID = c.StudentID 
	full join Departments d on d.DeptID = c.DeptID
	where a.Credits = 4
	order by CourseName ASC


