select bookId,name,pagecount,point,typeId 
	from books where pagecount < 200 and point >=50
	order by typeId asc, bookId asc