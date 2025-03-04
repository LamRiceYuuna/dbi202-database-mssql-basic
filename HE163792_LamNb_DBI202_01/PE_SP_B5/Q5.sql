select t.typeId,t.name, count(distinct b.bookId) as NumberOfBooks,count(br.borrowId) as NumberOfBorrows 
	from types t join books b on t.typeId = b.typeId
	join borrows br on br.bookId = b. bookId
	group by t.typeId,t.name
	order by t.typeId asc