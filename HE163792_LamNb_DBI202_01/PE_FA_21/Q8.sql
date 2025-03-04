Create proc proc_product_subcategory
@subcategoryID int ,
@numberOfProduct int output
as
begin
	set @numberOfProduct = (select count(distinct p.ProductID) from ProductSubcategory ps join Product p
		on ps.SubcategoryID = p.SubcategoryID 
		where ps.SubcategoryID = @subcategoryID)
end