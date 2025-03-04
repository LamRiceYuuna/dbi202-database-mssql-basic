Create proc pr1
@store_id int,
@numberOfStaff int output
as 
begin
	set @numberOfStaff = (select count(sf.staff_id) 
	from stores st join staffs sf on st.store_id = sf.staff_id
	where st.store_id = @store_id)
end