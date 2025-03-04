Create trigger Tr2
on books
for insert
as
begin
	select i.bookId, i.name as [bookName],i.authorId,a.name as [authorName],a.surname as [authorSurname],i.typeId,t.name as [typeName] 
	from inserted i join authors a on i.authorId = a.authorId
							join types t on t.typeId = i.typeId
end
