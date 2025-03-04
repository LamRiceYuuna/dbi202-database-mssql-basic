Select e1.Fname,e1.Lname,e2.Fname,e2.Lname from EMPLOYEE e1 join EMPLOYEE e2 on e1.Super_ssn= e2.Ssn
	order by e1.Fname desc