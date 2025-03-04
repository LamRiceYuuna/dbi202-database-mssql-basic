create table Departments
(
	DepartmentID varchar(15) primary key,
	[Name] nvarchar(100)
)

create table Projects
(
	ProjectCode varchar(15) primary key,
	Title nvarchar(200),
	DepartmentID varchar(15),
	foreign key (DepartmentID) references Departments(DepartmentID)
)

create table Students
(
	StudentCode varchar(10) primary key,
	[Name] nvarchar(100),
	Class varchar(7),
	DepartmentID varchar(15),
	foreign key (DepartmentID) references Departments(DepartmentID)
)

create table Participate 
(
	StudentCode varchar(10),
	ProjectCode varchar(15),
	foreign key (StudentCode) references Students(StudentCode),
	foreign key (ProjectCode) references Projects(ProjectCode),
	primary key (StudentCode,ProjectCode)
)
