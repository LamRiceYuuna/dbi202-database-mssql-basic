select count1.DepartmentID, count1.Name, count1.NumberOfOnlineCourses, count2.NumberOfOnsiteCourses
	from
	(select d.DepartmentID,d.Name, count(oc.CourseID) as NumberOfOnlineCourses
	from Department d left join Course c on d.DepartmentID = c.DepartmentID
	left join OnlineCourse oc on oc.CourseID = c.CourseID
	group by d.DepartmentID,d.Name) as count1
	join 
	(select  d.DepartmentID, count(oc.CourseID) as NumberOfOnsiteCourses
	from Department d left join Course c on d.DepartmentID = c.DepartmentID
	left join OnsiteCourse oc on oc.CourseID = c.CourseID
	group by d.DepartmentID) as count2
	on count1.DepartmentID = count2.DepartmentID
	order by count1.NumberOfOnlineCourses desc,count2.NumberOfOnsiteCourses desc