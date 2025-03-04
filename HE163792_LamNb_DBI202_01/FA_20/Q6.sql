Select uy.university_id,u.university_name,uy.year , uy.student_staff_ratio
	from university u join university_year uy on u.id = uy.university_id
	where uy.year = 2015
	and uy.student_staff_ratio = 
	(select min(tb1.student_staff_ratio) from (Select uy.university_id,u.university_name,uy.year , uy.student_staff_ratio
	from university u join university_year uy on u.id = uy.university_id
	where uy.year = 2015) as tb1)