select count1.CourseID, count1.Title, count1.Credits, count1.DepartmentID, count1.NumberOfInstructors, count2.NumberOfStudents
	from 
	(select c.CourseID,c.Title, c.Credits, c.DepartmentID, count(ci.PersonID) as NumberOfInstructors
	from Course c left join CourseInstructor ci
	on c.CourseID = ci.CourseID 
	group by c.CourseID,c.Title, c.Credits, c.DepartmentID) as count1
	join
	(select c.CourseID, count(distinct sg.StudentID) as NumberOfStudents from Course c left join StudentGrade sg 
	on c.CourseID = sg.CourseID
	group by c.CourseID) as count2
	on count1.CourseID = count2.CourseID
	order by count1.DepartmentID asc, count2.NumberOfStudents desc, count1.Title asc 


				
			
			


	
	
			
			

			
			