--Kiểu dữ liệu - data type là cách ta lưu trữ loại dữ liệu nào đó
-- chữ, số(nguyên, thực), câu/đoạn văn, ngày tháng, tiền ($..)
-- 1 NNLT sẽ hộ trợ nhiều loại dữ liệu khác nhau - data types
-- 
-- Khi lập trình trong SQL Server, vì câu lệnh sẽ nằm trên nhiều dòng...

--mình cần nhắc Tool này 1 câu : đừng nhìn lệnh riêng lẻ (nhiều dòng), mà 
--hãy nhìn nguyên cụm lệnh mới có ý nghĩa (BATCH)

--Ta sẽ dùng lệnh GO để gom 1 cụm lệnh lập trình lại thành 1 đơn vị có ý nghĩa




--Khai báo biến
GO
DECLARE @msg1 as nvarchar(30)

DECLARE @msg nvarchar(30) = N'Xin chào - Welcome to T-SQL'

--IN BIẾN CÓ 2 LỆNH 
PRINT @msg -- in ra kết quả bên cửa sổ consol giống ngôn ngữ lt

SELECT @msg --in ra kq dưới dạng table

DECLARE @yob int --= 2003

--Gán giá trị cho biến
set @yob = 2003
select @yob = 2004 --select dùng theo 2 cách:gán gtri cho biến, in gtri cho biến

print @YOB

IF @yob > 2003
	BEGIN  --{
		PRINT 'HEY, BOY/GIRL'
		PRINT 'HELLO GEN Z'
	END  --}
ELSE
	BEGIN
		PRINT 'HELLO LADY & GENTLEMENT'
	END
GO