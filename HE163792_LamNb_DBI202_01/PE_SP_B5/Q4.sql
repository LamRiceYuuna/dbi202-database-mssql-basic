select b.bookId,b.name,b.pagecount,b.authorId,a.name,a.surname,t.name 
	from books b join authors a on b.authorId= a.authorId
					join types t on t.typeId = b.typeId
					where t.name in ('Diaries','Science fiction','Art','Journals') and b.pagecount <= 200
					order by t.name asc,b.name asc