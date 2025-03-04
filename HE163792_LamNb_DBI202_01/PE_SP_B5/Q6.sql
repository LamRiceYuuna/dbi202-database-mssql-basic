select b.bookId, b.name , count(br.borrowId) as NumberOfBorrows
	from books b join borrows br on b.bookId=br.bookId
	group by b.bookId, b.name
	having count(br.borrowId) =
	(select max(MaxBr.NumberOfBorrows) from (select b.bookId, b.name , count(br.borrowId) as NumberOfBorrows
	from books b join borrows br on b.bookId=br.bookId
	group by b.bookId, b.name) as MaxBr)