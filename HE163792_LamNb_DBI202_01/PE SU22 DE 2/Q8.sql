create proc Proc1 
@studentId int,
@numberOfOnlineCourses int output
as
begin
	set @numberOfOnlineCourses =  (select count(oc.CourseID) from Course c right join OnlineCourse oc on c.CourseID = oc.CourseID 
					   join StudentGrade sg on sg.CourseID = c.CourseID
					   where sg.StudentID = @studentId) 
end

