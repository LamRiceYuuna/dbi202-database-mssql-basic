use Lab2_DBI202
Select a.DeptID,a.Name[DepartmentName], b.StudentID, b.FirstName + ' ' + b.LastName as[FullName],b.Sex
    from Departments a full join Students b on a.DeptID=b.DeptID
	where a.Name in ('Computer Science','Network and Communication','Software Engineering')