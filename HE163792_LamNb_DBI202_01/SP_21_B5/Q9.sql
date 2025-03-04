Create trigger Tr1
on Employees
after insert
as
begin
	select i.EmployeeID,i.FirstName,i.LastName,d.DepartmentID,d.DepartmentName
	from inserted i left join Departments d on i.DepartmentID = d.DepartmentID
end

