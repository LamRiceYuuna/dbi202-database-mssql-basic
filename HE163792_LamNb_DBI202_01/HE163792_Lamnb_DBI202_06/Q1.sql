create table Teachers
(
	TeacherID int primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(200),
	Gender char(1)
)

create table Classes
(
	ClassID int primary key,
	[year] int,
	[Semester] char(10),
	[NoCredits] int,
	courseID char(6),
	GroupID char(6),
	TeacherID int,
	foreign key (TeacherID) references Teachers(TeacherID)
)

create table Students
(
	StudentID int primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(200),
	Gender char(1)
)

create  table Attend
(
	StudentID int,
	ClassID int,
	[Date] date,
	[Slot] int,
	Attend bit
	primary key([Date],[Slot],StudentID,ClassID),
	foreign key (StudentID) references Students(StudentID),
	foreign key (ClassID) references Classes(ClassID)
)