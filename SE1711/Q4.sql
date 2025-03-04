use Lab2_DBI202
Select a.DeptID,a.Name 
    from Departments a full join Students b on a.DeptID = b.DeptID
	group by a.DeptID,a.Name
	having COUNT(b.StudentID) >= 2

