Create proc Proc2
@typeName varchar(30),
@numberOfAuthors int output
as
begin
	set @numberOfAuthors = (select count(a.authorId) from authors a join books b on a.authorId=b.authorId
											join types t on t.typeId = b.typeId
											where t.name = @typeName)
end
