USE Cartesian

--1. Liệt kê các cặp từ điển anh việt 
SELECT * FROM EnDict e, VnDict v
		 WHERE e.Nmbr = v.Nmbr
		 --CÓ BẰNG CELL THÌ MỚI GHÉP
SELECT * FROM EnDict e INNER JOIN VnDict v
	    ON e.Nmbr = v.Nmbr
		--Hãy ghép đi, trên cột này có cell/value này = cell/value bên kia
SELECT * FROM EnDict e JOIN VnDict v
	    ON e.Nmbr = v.Nmbr
--3câu trên tương đương kết quả!!!

--2.Hụt mất của tui từ 4 - Four và 5 - Năm ko thấy xuất hiện!!
--mún xh 4 Four và 5 Năm  thì tích Đề-các

SELECT * FROM EnDict e, VnDict v

SELECT * FROM EnDict
SELECT * FROM VnDict

--3. Tui muốn xh lấy tiếng Anh làm chuẩn, tìm các nghĩa TV tương đương
--   Nếu ko có tương đương vẫn phải hiện ra

SELECT * FROM EnDict e LEFT JOIN VnDict v
	    ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e LEFT OUTER JOIN VnDict v
	    ON e.Nmbr = v.Nmbr

--4.Tui mún lấy tiếng Việt làm mốc ban đầu
SELECT * FROM VnDict e LEFT OUTER JOIN EnDict v
	    ON e.Nmbr = v.Nmbr

--Vẫn lấy tV làm đầu , nhưng Tv ở bên tay phải kìa
SELECT * FROM EnDict e RIGHT OUTER JOIN VnDict v
	    ON e.Nmbr = v.Nmbr

--5.Dù chung  và riêng của mỗi bên , lấy hết, chấp nhận FA ở một vế

SELECT * FROM EnDict e FULL OUTER JOIN VnDict v
	    ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e FULL JOIN VnDict v
	    ON e.Nmbr = v.Nmbr

SELECT * FROM VnDict v FULL JOIN EnDict e
	    ON e.Nmbr = v.Nmbr

--Full outer join thứ tự table ko quan trọng, viết trc sau đều đc
--left, right thứ tự table là có chuyện

--OUTER JOIN SINH RA ĐỂ ĐẢM BẢO VIỆC KẾT NỐI GHÉP BẢNG
--KO BỊ MẤT MÁT DATA
-- DO INNER JOIN, JOIN = CHỈ TÌM CÁI CHUNG CỦA 2 BÊN

--SAU KHI TIM RA ĐC DATA CHUNG RIÊNG, TA CÓ QUYỀN FILTER TRÊN LOẠI
-- CELL NÀO ĐÓ, WHERE NHƯ BÌNH THƯỜNG


--6 In ra bộ từ điển Anh-Việt (Anh làm chuẩn ) của những con số từ 3 trở lên
SELECT * FROM EnDict e LEFT JOIN VnDict v
		ON e.Nmbr =v.Nmbr 
		WHERE e.Nmbr >=3

SELECT * FROM EnDict e LEFT JOIN VnDict v
		ON e.Nmbr =v.Nmbr 
		WHERE v.Nmbr >=3

--6 In ra bộ từ điển Anh-Việt Việt -Anh của những con số từ 3 trở lên


SELECT * FROM EnDict e FULL JOIN VnDict v
		ON e.Nmbr =v.Nmbr 
		WHERE e.Nmbr >=3 --toang mất mẹ số 5 VN


SELECT * FROM EnDict e FULL JOIN VnDict v
		ON e.Nmbr =v.Nmbr 
		WHERE v.Nmbr >=3 --có 5 mất 4

SELECT * FROM EnDict e FULL JOIN VnDict v
		ON e.Nmbr =v.Nmbr 
		WHERE v.Nmbr >=3 OR e.Nmbr >=3