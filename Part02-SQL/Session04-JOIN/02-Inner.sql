
SELECT * FROM VnDict, EnDict --tích Đề-các

SELECT * FROM VnDict CROSS JOIN EnDict --tích Đề-các

SELECT * FROM VnDict vn, EnDict en --TÍCH ĐỀ-CÁC XONG, RỒI FILTER LẠI
		 WHERE vn.Nmbr = en.Nmbr--THỰC DỤNG

SELECT * FROM VnDict , EnDict  
		 WHERE Nmbr = Nmbr	--BỐI RỐI TÊN
		 
SELECT * FROM VnDict , EnDict  
		 WHERE VnDict.Nmbr = EnDict.Nmbr--NÊN ĐẶT ALIAS THÌ GIÚP NGẮN GỌN CÂU LỆNH

--CHUẨN THẾ GIỚI
SELECT * FROM VnDict INNER JOIN EnDict --Nhìn sâu vào table rồi ghép, ko ghép bừa bãi
					ON VnDict.Nmbr = EnDict.Nmbr--Ghép có tương quan bên trong , theo điểm chung


SELECT * FROM VnDict JOIN EnDict 
					ON VnDict.Nmbr = EnDict.Nmbr
					
--Có thể dùng thêm WHERE ĐƯỢC HAY KHÔNG ??? KHI XÀI INNER, JOIN
--JOIN CHỈ THÊM DATA ĐỂ TÍNH TOÁN , GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TBO
--KIẾN THỨC SELECT ĐÃ HỌC

--THÍ NGHIỆM THÊM CHO INNER JOIN, GHÉP NGANG XEM CÓ MÔN ĐĂNG HỘ ĐỐI HAY KHÔNG???
SELECT * FROM EnDict
SELECT * FROM VnDict

SELECT * FROM EnDict e, VnDict v
		 WHERE e.Nmbr > v.Nmbr --GHÉP CÓ CHỌN LỌC , KO XÀI DẤU =
						       --MÀ DÙNG DẤU > >= < <= !=
							   --NON-EQUI JOIN
							   --VẪN KO LÀ GHÉP BỪA BÃI
--2Two 1Một
--3Three 1Một
--3Three 2Hai

SELECT * FROM EnDict e, VnDict v --thực dụng
		 WHERE e.Nmbr != v.Nmbr

SELECT * FROM EnDict e JOIN VnDict v --Chuẩn mực
		 ON e.Nmbr != v.Nmbr