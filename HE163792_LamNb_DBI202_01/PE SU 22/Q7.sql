select c.CourseID, c.Title, c.Credits, d.Name[DepartmentName], p.PersonID, p.LastName,
	   p.FirstName, p.Discriminator, max(sg.Grade)[Grade]
		from Course c full join Department d on c.DepartmentID = d.DepartmentID
					full join StudentGrade sg on sg.CourseID = c.CourseID
					full join Person p on p.PersonID = sg.StudentID
		group by sg.CourseID, sg.StudentID,  sg.Grade,
		c.CourseID, c.Title, c.Credits, d.Name, p.PersonID, p.LastName,
	   p.FirstName, p.Discriminator
		having (sg.CourseID = sg.CourseID and 
		Grade = (select max(Grade) from StudentGrade 
			where CourseID = sg.CourseID
			group by CourseID)) or c.CourseID not in (select CourseID from StudentGrade)
order by d.Name asc, c.Title asc, p.FirstName asc

