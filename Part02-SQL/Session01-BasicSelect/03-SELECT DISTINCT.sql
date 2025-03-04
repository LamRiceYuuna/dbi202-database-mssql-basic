USE Northwind
--LÍ THUYẾT
-- MỘT DB là nơi chứa data ( bán hàng, thư viện , qlsv,...)
-- DATA được lưu dưới dạng TABLE, tách thành nhiều TABLE(nghệ thuật design db,NF)
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cx hiện thị dưới dạng table
--CÚ PHÁP CHUẨN : SELECT * FROM <TÊN-TABLE>
--                       * đại diện cho việc tui mún lấy all off columns 
--CÚ PHÁP MỞ RỘNG:
--                SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>
--                SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ
--                FROM <TÊN-TABLE>

--Khi ta SELECT ít cột từ table gốc thì nguy cơ dữ liệu sẽ bị trùng lại
--Không phải ta bị sai, ko phải người thiết kế table và người nhập liệu
--Do chúng ta có nhiều info trùng nhau/đặc điểm trùng nhau , nên nếu chỉ tập trung vào data này
--trùng nhau chắc chắn xảy ra
--100 triệu người dân VN được quản lí info bao gồm : ID, Tên, DOB,.....Tỉnh thành sinh sống
--                                                   <>                   63 tỉnh
--                                                   <>                 
--LỆNH SELECT HỘ TRỢ LOẠI TRỪ DÒNG TRÙNG NHAU/TRÙNG 100%
--SELECT DISTINCT TÊN-CÁC-CỘT FROM <TÊN-TABLE>


-----------------------------------------------------

--1. Liệt kê danh sách nhân viên 
SELECT * FROM Employees
--Phân tích: 9 người nhưng chỉ có 4 title. ~~~ 100 triệu dân VN chỉ có 63 tỉnh thành
SELECT TitleOfCourtesy FROM Employees --9 danh xưng
SELECT DISTINCT TitleOfCourtesy FROM Employees --chỉ là 4

SELECT DISTINCT EmployeeID, TitleOfCourtesy FROM Employees
--NẾU DISTINCT ĐI KÈM VỚI ID/KEY, NÓ VÔ DỤNG, KEY SAO TRÙNG MÀ LOẠI TRỪ

--2.In ra thông tin khách hàng
SELECT *FROM Customers--92 rows

--3.Có bao nhiêu quốc gia xuất hiện trong thông tin khách hàng , in ra
SELECT Country  FROM Customers -- 92 rows
SELECT DISTINCT Country  FROM Customers -- 22 rows


