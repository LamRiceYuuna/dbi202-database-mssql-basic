Create table Locations
(
	locationID varchar(20) primary key,
	[Name] nvarchar(100),
	[Address] nvarchar(255)
)

create table Events
(
	eventID int primary key,
	[name] nvarchar(255),
	StartTime DateTime,
	EndTime DateTime,
	locationID varchar(20),
	foreign key(locationID) references Locations(locationID)
)

create table Staffs
(
	staffID int primary key,
	[name] nvarchar(255),
	Phone varchar(15),
)

create table workFor 
(
	[role] nvarchar(30),
	eventID int,
	staffID int,
	primary key([role],eventID, staffID),
	foreign key(eventID) references Events(eventID),
	foreign key(staffID) references Staffs(staffID)
)