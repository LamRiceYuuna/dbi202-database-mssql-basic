select pph.ProductID,pph.Price,pph.StartDate, pph.EndDate
	from ProductPriceHistory pph
	where (pph.EndDate between '2003-1-1' and '2003-12-31') and pph.Price < 100
	order by pph.Price desc
