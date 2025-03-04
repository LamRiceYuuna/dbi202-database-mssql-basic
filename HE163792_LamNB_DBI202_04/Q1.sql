Create table Departments
(
	DepartmentID int primary key,
	[Name] nvarchar(100),
)

Create table Projects
(
	ProjectID int primary key,
	Title nvarchar(255),
)

Create table Employees
(
	EmployeeID varchar(10) primary key,
	[Name] nvarchar(100),
	DOB date
)

Create table Participate
(
	DepartmentID int,
	ProjectID int,
	EmployeeID varchar(10),
	Hours int,
	primary key (DepartmentID,ProjectID,EmployeeID),
	foreign key (DepartmentID) references Departments(DepartmentID),
	foreign key (ProjectID) references Projects(ProjectID),
	foreign key (EmployeeID) references Employees(EmployeeID)
)