select p.SubCategoryID, count(p.ID) as NumberOfProducts  from Product p
		group by p.SubCategoryID
		having count(p.ID) >=
		(select min([5Max].NumberOfProducts) from
		(select top (5) count(p.ID) as NumberOfProducts  from Product p group by p.SubCategoryID order by NumberOfProducts desc) as [5Max])
		union all
select p.SubCategoryID, count(p.ID) as NumberOfProducts  from Product p
		group by p.SubCategoryID
		having count(p.ID) <=
		(select max([5Min].NumberOfProducts) from
		(select top (5) count(p.ID) as NumberOfProducts  from Product p group by p.SubCategoryID order by NumberOfProducts asc) as [5Min])
		order by NumberOfProducts desc