Select JobID, JobTitle, min_salary from Jobs 
		where min_salary > 5000 and JobTitle like '%Manager'
		order by min_salary desc, JobTitle asc