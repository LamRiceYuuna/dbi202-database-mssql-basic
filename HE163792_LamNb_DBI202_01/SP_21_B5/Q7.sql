select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates from
(select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName from Employees e, Departments d where d.DepartmentID = e.DepartmentID) as v
inner join (select e.EmployeeID, e.FirstName, e.LastName, e.Salary, e.ManagerID from Employees e) as a
on v.EmployeeID = a.ManagerID 
group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as f
union
select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates from
(select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName from Employees e, Departments d where d.DepartmentID = e.DepartmentID and e.Salary>10000) as v
left join (select e.EmployeeID, e.ManagerID from Employees e) as a
on v.EmployeeID = a.ManagerID 
group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as g
order by NumberOfSubordinates DESC


