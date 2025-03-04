
create table Buildings
(
	BuildingCode varchar(10) primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(100)
)

create table Rooms
(
	DoorNumber int identity(1, 1) primary key,
	[Floor] int,
	BuildingCode varchar(10),
	foreign key (BuildingCode) references Buildings(BuildingCode)
)

create table Departments
(
	DepartmentID int identity(1, 1) primary key,
	[Name] nvarchar(100),
	DoorNumber int,
	foreign key (DoorNumber) references Rooms(DoorNumber)
)
