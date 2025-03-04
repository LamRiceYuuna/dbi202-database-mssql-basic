Create proc proc_university_year
@year int,
@pct_international_students int,
@nbUniversity int output
as
begin
	set @nbUniversity =(select count(u.id) from university u join university_year uy on u.id = uy.university_id
			where uy.year = @year and uy.pct_international_students > @pct_international_students)
end
