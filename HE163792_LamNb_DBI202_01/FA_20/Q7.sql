select c.university_id, c.university_name, c.ranking_criteria_id, c.criteria_name, c.year, c.score from 
(select ury.university_id, u.university_name, ury.ranking_criteria_id, rc.criteria_name, ury.year, ury.score
from university_ranking_year ury, ranking_criteria rc, university u
where ury.year = 2016 and rc.id = ury.ranking_criteria_id and rc.criteria_name = 'Teaching' and u.id = ury.university_id) as c
join (select * from university_ranking_year ury, ranking_criteria rc
where ury.year = 2016 and rc.id = ury.ranking_criteria_id and rc.criteria_name = 'Teaching') as c1
on c1.score = c.score 
group by c.university_id, c.university_name, c.ranking_criteria_id, c.criteria_name, c.year, c.score
having count(c.university_id) >1
order by c.score DESC