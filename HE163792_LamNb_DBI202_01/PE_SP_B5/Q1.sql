
create table Roles
(
	RoleID varchar(15) primary key,
	[Name] nvarchar(100)
)
create table Projects
(
	ProjectCode varchar(20) primary key,
	[Name] nvarchar(500),
	BeginDate Date,
	EndDate Date,
	
)

create table Employees
(
	SSN varchar(20) primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(200),

)

create table Participate
(
	RoleID varchar(15),
	ProjectCode varchar(20),
	SSN varchar(20),
	primary key(RoleID,ProjectCode,SSN),
	foreign key (RoleID) references Roles(RoleID),
	foreign key (ProjectCode) references Projects(ProjectCode),
	foreign key (SSN) references Employees(SSN)

)