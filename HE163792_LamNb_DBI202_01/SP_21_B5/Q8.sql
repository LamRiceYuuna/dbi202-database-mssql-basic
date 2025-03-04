Create proc pr1
@countryID varchar(10),
@numberOfDepartments int output
as 
begin
	set @numberOfDepartments = (select count(d.DepartmentID) from Departments d join Locations l on d.LocationID = l.LocationID
			where l.CountryID = @countryID)
end
