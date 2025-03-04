delete from Suppliers where SupplierID in  (select SupplierID from Suppliers where SupplierID not in
(select SupplierID from PurchaseOrderLines )) 
	or 
	SupplierID in
(select SupplierID from Suppliers where SupplierID not in
(select s.SupplierID from Suppliers s  join SupplierTransactions st on s.SupplierID = st.SupplierID
		 join StockItems si on si .SupplierID = s.SupplierID))
