Select l.LocationID,l.StreetAddress,l.City,l.StateProvince,l.CountryID,count(d.DepartmentID) as NumberOfDepartments
		from Locations l left join Departments d on l.LocationID = d.LocationID
		group by l.LocationID,l.StreetAddress,l.City,l.StateProvince,l.CountryID
		order by NumberOfDepartments desc,l.LocationID asc