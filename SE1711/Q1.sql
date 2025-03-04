use Lab2_DBI202
Select CourseID, Name AS[CourseName], Credits  from Courses 
	where Name like '%a%' and Credits = 4