SELECT uy.university_id,u.university_name,uy.year,uy.num_students,uy.pct_international_students,u.country_id 
	from university_year uy join university u on uy.university_id = u.id
	where year = 2016 and uy.pct_international_students > 30
	order by u.university_name asc
	