Select rs.id as[system_id],rs.system_name,count(rc.id)[numberOfCriteria]
	from ranking_system rs join ranking_criteria rc on rs.id = rc.ranking_system_id
	group by rs.id,rs.system_name
	order by numberOfCriteria desc