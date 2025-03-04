create trigger InsertSubCategory 
on SubCategory
for insert
as
begin
	select i.SubCategoryName,c.CategoryName from inserted i join Category c on i.CategoryID = c.ID
end