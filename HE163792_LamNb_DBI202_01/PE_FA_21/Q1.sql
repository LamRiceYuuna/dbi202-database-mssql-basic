create table Employees
(
	EmpID int primary key,
	[name] nvarchar(50),
	salary money,
)

create table Managers
(
	ManagerID int primary key,
	bonus money,
	EmpID int,
	foreign key(EmpID) references Employees(EmpID)
)

create table Projects
(
	ProjectID int primary key,
	[name] nvarchar(200),
	ManagerID int,
	foreign key(ManagerID) references Managers(ManagerID)
)

create table Works
(
	EmpID int,
	ProjectID int,
	hours int,
	primary key(EmpID, ProjectID),
	foreign key(ProjectID) references Projects(ProjectID),
	foreign key(EmpID) references Employees(EmpID)
)