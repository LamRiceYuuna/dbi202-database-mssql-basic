select p.PersonID, p.LastName, p.FirstName, p.HireDate, p.Discriminator 
	from Person p where p.Discriminator = 'Instructor'