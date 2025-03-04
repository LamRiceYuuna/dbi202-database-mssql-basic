--I.Phân tích bảng PackageTypes(Các loại gói)
select * from PackageTypes --14
--1. PackageTypes <-----PurcharseOrderLines(Các dòng đơn đặt hàng)
select * from PackageTypes pt full join PurchaseOrderLines pol
			on pt.PackageTypeID = pol.PackageTypeID--5874
select * from PackageTypes pt join PurchaseOrderLines pol
			on pt.PackageTypeID = pol.PackageTypeID -- 5863
select * from PackageTypes pt left join PurchaseOrderLines pol
			on pt.PackageTypeID = pol.PackageTypeID--5874
--Vênh giữ liệu về bảng PackageTypes
select PackageTypeID from PackageTypes where PackageTypeID NOT in 
			(select distinct PackageTypeID from PurchaseOrderLines)--1,2,3,4,5,8,10,11,12,13,14
select PackageTypeID from PackageTypes where PackageTypeID  in 
			(select distinct PackageTypeID from PurchaseOrderLines) --9,6,7

--2. PackageTypes <-----StockItems(Hàng tồn kho)
 --2.1,PK với UnitPackageID
select * from PackageTypes pt full join StockItems si 
		on  pt.PackageTypeID = si .UnitPackageID--146
select * from PackageTypes pt left join StockItems si 
		on  pt.PackageTypeID = si .UnitPackageID--146
select * from PackageTypes pt right join StockItems si 
		on  pt.PackageTypeID = si .UnitPackageID--135
--Vênh giữ liệu về bảng PackageTypes
select PackageTypeID from PackageTypes where PackageTypeID NOT in 
			(select distinct UnitPackageID from StockItems)--1,2,3,4,5,6,8,11,12,13,14
select PackageTypeID from PackageTypes where PackageTypeID  in 
			(select distinct UnitPackageID from StockItems)--7,9,10
 --2.2,PK với OuterPackageID
select * from PackageTypes pt full join StockItems si 
		on  pt.PackageTypeID = si .OuterPackageID --146 
select * from PackageTypes pt left join StockItems si 
		on  pt.PackageTypeID = si .OuterPackageID --146
select * from PackageTypes pt right join StockItems si 
		on  pt.PackageTypeID = si .OuterPackageID --135 
--Vênh giữ liệu về bảng PackageTypes
select PackageTypeID from PackageTypes where PackageTypeID NOT in 
			(select distinct OuterPackageID from StockItems)--1,2,3,4,5,8,10,11,12,13,14
select PackageTypeID from PackageTypes where PackageTypeID in 
			(select distinct OuterPackageID from StockItems)--6,7,9

--II.Phân tích bảng StockItems(Hàng tồn kho)
select * from StockItems--135
--1.StockItems<----- PurcharseOrderLines
select * from StockItems si full join PurchaseOrderLines pol
		on si.StockItemID = pol.StockItemID --5863
select * from StockItems si left join PurchaseOrderLines pol
		on si.StockItemID = pol.StockItemID --5863
select * from StockItems si right join PurchaseOrderLines pol
		on si.StockItemID = pol.StockItemID --5863
--Data vừa khít ko vênh

--III.Phân tích bảng Suppliers(Các nhà cung cấp)
select * from Suppliers--10
--1.Suppliers <----- StockItems
select * from Suppliers s full join StockItems si
		on s.SupplierID = si.SupplierID -- 141
select * from Suppliers s left join StockItems si
		on s.SupplierID = si.SupplierID -- 141
select * from Suppliers s right join StockItems si
		on s.SupplierID = si.SupplierID -- 135
--Vênh giữ liệu về bảng Suppliers
Select SupplierID from Suppliers where SupplierID not in
	(select distinct SupplierID from StockItems) -- 1,3,6,7,8,9
Select SupplierID from Suppliers where SupplierID  in
	(select distinct SupplierID from StockItems) -- 2,4,5,10

--2.Suppliers<----- SupplierTransactions
select si.SupplierID,st.SupplierID from StockItems si full join SupplierTransactions st
		on si.SupplierID = st.SupplierID--92,272
select si.SupplierID,st.SupplierID from StockItems si left join SupplierTransactions st
		on si.SupplierID = st.SupplierID --92,094
select si.SupplierID,st.SupplierID from StockItems si right join SupplierTransactions st
		on si.SupplierID = st.SupplierID--92,272
--Vênh giữ liệu về bảng SupplierTransactions
Select SupplierID from Suppliers where SupplierID not in
	(select distinct SupplierID from SupplierTransactions)--3,6,8,9
Select SupplierID from Suppliers where SupplierID  in
	(select distinct SupplierID from SupplierTransactions)--1,2,4,5,7,10

--2.Suppliers<----- PurchaseOrders
select * from Suppliers s full join PurchaseOrders po 
		on s.SupplierID = po.SupplierID --1085
select * from Suppliers s left join PurchaseOrders po 
		on s.SupplierID = po.SupplierID--1085
select * from Suppliers s right join PurchaseOrders po 
		on s.SupplierID = po.SupplierID--1079
--Vênh giữ liệu về bảng Suppliers
Select SupplierID from Suppliers where SupplierID not in
	(select distinct SupplierID from PurchaseOrders)--1,3,6,7,8,9
Select SupplierID from Suppliers where SupplierID in
	(select distinct SupplierID from PurchaseOrders)--2,4,5,10


--IV.Phân tích bảng PurchaseOrders(Đơn đặt hàng)
select * from PurchaseOrders -- 1,079
--1.PurchaseOrders <----- SupplierTransactions
select * from PurchaseOrders po full join SupplierTransactions st
		on po.PurchaseOrderID = st.PurchaseOrderID--1,443
select * from PurchaseOrders po left join SupplierTransactions st
		on po.PurchaseOrderID = st.PurchaseOrderID --1079
select * from PurchaseOrders po right join SupplierTransactions st
		on po.PurchaseOrderID = st.PurchaseOrderID--1,442
--Vênh giữ liệu về cả 2 bảng
Select PurchaseOrderID from PurchaseOrders where PurchaseOrderID  in
	(select distinct PurchaseOrderID from PurchaseOrders) --1079

--2.PurchaseOrders <----- PurcharseOrderLines
select * from PurchaseOrders po full join PurchaseOrderLines pol
		on po.PurchaseOrderID = pol.PurchaseOrderID--5,863
select * from PurchaseOrders po left join PurchaseOrderLines pol
		on po.PurchaseOrderID = pol.PurchaseOrderID--5,863
select * from PurchaseOrders po right join PurchaseOrderLines pol
		on po.PurchaseOrderID = pol.PurchaseOrderID--5,863
--Data vừa khít ko vênh

--V.Phân tích bảng SupplierTransactions(Giao dịch với nhà cung cấp)
select * from SupplierTransactions--1,442


--VI.Phân tích bảng PurchaseOrderLines
select * from PurchaseOrderLines --5863

