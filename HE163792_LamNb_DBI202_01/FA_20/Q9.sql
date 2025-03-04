Create trigger tr_insert_university_ranking
on university_ranking_year
for insert
as
begin
	select i.university_id,u.university_name,i.ranking_criteria_id,rc.criteria_name,i.year,i.score
		from inserted i join university u on u.id = i.university_id
		join ranking_criteria rc on rc.id = i.ranking_criteria_id
end
