--DROP DATABASE StudentManagement

CREATE DATABASE StudentManagement

USE StudentManagement

CREATE TABLE Major
(
	MajorID char(2) PRIMARY KEY,         -- PK Primary Key - Khóa chính
	MajorName varchar(30),
	Hotline varchar(11)
)

INSERT INTO Major VALUES('SE', 'Software Engineering', '090x')
INSERT INTO Major VALUES('IA', 'Information Assurance', '091x')
INSERT INTO Major VALUES('GD', 'Graphic Design', '092x')
INSERT INTO Major VALUES('JP', 'Japanese', '093x')
INSERT INTO Major VALUES('KR', 'Korean', '094x')

SELECT * FROM Major

DROP TABLE Student
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,          -- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50), 
	MajorID char(2) REFERENCES Major(MajorID)  -- FK Foreign Key - Khóa ngoại
)

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE3', N'Trần', N'Ba', 'SE');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE6', N'Võ', N'Sáu', 'IA');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD8', N'Huỳnh', N'Tám', 'GD');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('JP9', N'Ngô', N'Chín', 'JP');

SELECT * FROM Student

-- TỪ TỪ HÃY THÊM VÀO ĐỂ XEM FULL-OUTER JOIN RA SAO
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('UNK', N'Đặng', N'Mười', NULL);


SELECT * FROM Major
SELECT * FROM Student

--1.In ra thông tin chi tiết của SV kèm thông tin chuyên ngành
SELECT * FROM Student --info tắt chuyên ngành
SELECT * FROM Major --chỉ có info chuyên ngành , thiếu info sv
--JOIN cần chắc rồi, lấy info đang nằm ở bên kia ghép thêm theo chiều ngang
 
SELECT * FROM Student s , Major m
		 WHERE s.MajorID = m.MajorID --dư cột MajorID

SELECT s.*, m.MajorName, m.Hotline FROM Student s , Major m
		 WHERE s.MajorID = m.MajorID 

SELECT s.*, m.MajorName, m.Hotline 
		FROM Student s INNER JOIN Major m
		 ON s.MajorID = m.MajorID 

--2.In ra thông tin chi tiết của sv kèm info chuyên ngành.Chỉ quan tâm sv SE và IA
SELECT s.*, m.MajorName, m.Hotline 
		FROM Student s INNER JOIN Major m
		 ON s.MajorID = m.MajorID 
		 WHERE m.MajorID IN('SE','IA')--6

SELECT s.*, m.MajorName, m.Hotline 
		 FROM Student s , Major m
		 WHERE s.MajorID = m.MajorID AND m.MajorID IN('SE','IA')

--3.In ra thông tin các sv kèm chuyên ngành. Chuyên ngành nào chưa có sv cũng in ra luôn
--Phân tích: căn theo sv mà in, thì HÀN QUỐC tèo ko xuất hiện
SELECT s.*, m.* 
		FROM Student s RIGHT JOIN Major m
		 ON s.MajorID = m.MajorID --10

SELECT s.*, m.* 
		FROM Major m LEFT JOIN Student s
		 ON s.MajorID = m.MajorID --10 DÒNG KOREA FA null

--4.Có bn chuyên ngành??


SELECT * FROM Major
SELECT * FROM Student

SELECT COUNT(*) FROM Major
SELECT COUNT(MajorID) AS [No major] FROM Major 

--5.Mỗi chuyên ngành có bao nhiêu sinh viên??
--output 2: số lượng sv đang theo học từng chuyên ngành
--output 1:mã cn | số lượng sv đang theo học
--phân tích: hỏi sv, bao nhiêu sv, đếm sv sure !!!
--            gặp thêm từ mỗi !!!!
-- mỗi chuyên ngành có 1 con số đếm, đếm theo chuyên ngành, chia nhóm chuyên ngành mà đếm

SELECT MajorID ,COUNT(*) AS [No students]  FROM Student GROUP BY MajorID

--6.Chuyển ngành nào có từ 6 sv trở lên??
--PHÂN TÍCH: CHIA CHẶNG RỒI
			--đầu tiên phải đếm chuyên ngành đã, quét qua bảng 1 lần để đế ra sv
			--đếm xong, dợt lại kết quả , lọc thêm cái từ 3 sv trở lên
			--phải đếm xong từng ngành rồi ms tính tiếp
SELECT MajorID ,COUNT(*) AS [No students]  FROM Student GROUP BY MajorID HAVING COUNT(*) >= 3

--7.Chuyên ngành nào có ít sv nhất???

SELECT MajorID ,COUNT(*) AS [No students]  
				FROM Student 
				GROUP BY MajorID 
				HAVING COUNT(*) <= ALL(SELECT COUNT(*) AS [No students]  
								FROM Student 
								GROUP BY MajorID)

--8.Đếm sinh viên của chuyên ngành SE			

SELECT COUNT(*) AS [No students SE]  
				FROM Student
				WHERE MajorID = 'SE'--câu này chạy nhanh
				
SELECT MajorID,COUNT(*) AS [No students SE]  
				FROM Student
				WHERE MajorID = 'SE'
				GROUP BY MajorID --Chỉ còn lại 1 nhóm

--9.Đếm số sv của mỗi cn
--output : mã cn, tên cn , số lg sv
--phân tích:đáp án cần có info của 2 table
--			đếm trên 2 table
--			đếm trong Major hok có info sv
--			đếm trong sv chỉ có đc mã cn
--			muốn có mã cn , tên cn, số lg sv -> join 2 bảng rồi ms đếm
SELECT * FROM Student
SELECT s.StudentID,s.FirstName,m.MajorID,m.MajorName  
				FROM Student s INNER JOIN Major m
				ON m.MajorID = s.MajorID
	
SELECT m.MajorID,m.MajorName, COUNT(*) AS [No students]  
				FROM Student s INNER JOIN Major m
				ON m.MajorID = s.MajorID	
				GROUP BY m.MajorID,m.MajorName


--10.câu 10 điểm nè ...
--THẾ CÒN TRÒ CHƠI CON MỰC THÌ SAO??????
--CHUYÊN NGÀNH HQ CỦA EM ĐÂU RỒI

SELECT s.StudentID,s.FirstName,m.MajorID,m.MajorName  
				FROM Student s RIGHT JOIN Major m
				ON m.MajorID = s.MajorID

SELECT m.MajorID,m.MajorName, COUNT(*)  
				FROM Student s RIGHT JOIN Major m
				ON m.MajorID = s.MajorID
				GROUP BY m.MajorID,m.MajorName --sai vì có 1 dòng KR FA , null vế sv
												--count(1) có 1 dòng FA, HQ có 1 sv sai

SELECT m.MajorID,m.MajorName, COUNT(StudentID)  
				FROM Student s RIGHT JOIN Major m
				ON m.MajorID = s.MajorID
				GROUP BY m.MajorID,m.MajorName--Count null lại đúng trong TH này
											--vì mã sv là null ứng vs cn KR
											--count(*) chỉ cần có dòng là ra số 1
											--chấp dòng có nhiều null hay không

											--đếm cell cell null-->(0)

				--DASH BOARD MÀN HÌNH THỐNG KÊ CỦA ADMIN WEBSITE TUYỂN SINH