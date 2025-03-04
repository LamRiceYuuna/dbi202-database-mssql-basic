DROP DATABASE ClubManagement

CREATE DATABASE ClubManagement

USE ClubManagement

DROP TABLE Club
CREATE TABLE Club
(
	ClubID char(5) PRIMARY KEY,         -- PK Primary Key - Khóa chính
	ClubName nvarchar(50),
	Hotline varchar(11)
)

INSERT INTO Club VALUES('SiTi', N'Cộng đồng Sinh viên Tình nguyện', '090x')
INSERT INTO Club VALUES('SkllC', N'Skillcetera', '091x')
INSERT INTO Club VALUES('CSG', N'CLB Truyền thông Cóc Sài Gòn', '092x')
INSERT INTO Club VALUES('FEV', N'FPT Event Club', '093x')
INSERT INTO Club VALUES('FCode', N'FPT Code', '094x')

SELECT * FROM Club

DROP TABLE Student
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,          -- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50)	
)

INSERT INTO Student(StudentID, LastName, FirstName) VALUES('SE1', N'Nguyễn', N'Một');
INSERT INTO Student(StudentID, LastName, FirstName) VALUES('SE2', N'Lê', N'Hai');
INSERT INTO Student(StudentID, LastName, FirstName) VALUES('SE3', N'Trần', N'Ba');
INSERT INTO Student(StudentID, LastName, FirstName) VALUES('SE4', N'Phạm', N'Bốn');
INSERT INTO Student(StudentID, LastName, FirstName) VALUES('SE5', N'Lý', N'Năm');

SELECT * FROM Student

DROP TABLE Registration
CREATE TABLE Registration
(
	RegID int IDENTITY(1, 1) PRIMARY KEY,   -- PK Primary Key - Khóa chính - Tăng tự động từ 1	      
	StudentID char(8),
	ClubID char(5),    
	JoinedDate date,
	LeavedDate date
	CONSTRAINT FK_Reg_Club FOREIGN KEY (ClubID) REFERENCES Club(ClubID),                -- FK Foreign Key - Khóa ngoại
	CONSTRAINT FK_Reg_Student FOREIGN KEY (StudentID) REFERENCES Student(StudentID)     -- FK Foreign Key - Khóa ngoại
)


-- SiTi 3, SkllC 2, CSG 2, FEV 0, FCODE 0
-- SE1 3, SE2 3, SE3 1, SE4 0, SE5 0
INSERT INTO Registration(StudentID, ClubID) VALUES('SE1', 'SiTi')
INSERT INTO Registration(StudentID, ClubID) VALUES('SE1', 'SkllC')
INSERT INTO Registration(StudentID, ClubID) VALUES('SE1', 'CSG')


INSERT INTO Registration(StudentID, ClubID) VALUES('SE2', 'SiTi')
INSERT INTO Registration(StudentID, ClubID) VALUES('SE2', 'SkllC')
INSERT INTO Registration(StudentID, ClubID) VALUES('SE2', 'CSG')

INSERT INTO Registration(StudentID, ClubID) VALUES('SE3', 'SiTi')

SELECT * FROM Registration

--THỰC HÀNH
--1.Liệt kê thông tin sv đang theo học
SELECT * FROM Student
SELECT * FROM Registration
SELECT * FROM Club
--2.Liệt kê thông tin sv đang học kèm theo clb bạn ấy đang tham gia
--Output 1: mã sv, tên sv, mã clb
--Output 2: mã sv, tên sv, mã clb, tên clb
SELECT * FROM Student AS s JOIN Registration AS r
		 ON s.StudentID = r.StudentID --ghép 2 table sát nhau, nhiều cột

SELECT s.StudentID, s.FirstName +' '+ s.LastName AS [Full name], r.ClubID 
		FROM Student AS s  JOIN Registration AS r
		ON s.StudentID = r.StudentID --rút bớt cột

--!!! Thiếu mẹ nó 2 sv 4 vs 5 VÌ JOIN = 
			
SELECT s.StudentID, s.FirstName +' '+ s.LastName AS [Full name], r.ClubID 
		FROM Student AS s LEFT JOIN Registration AS r
		ON s.StudentID = r.StudentID

--3.In ra thông tin tham gia clb của các sv
--Output:mã sv , tên sv , mã clb , tên clb, joineddate

SELECT s.StudentID,s.FirstName+' '+s.LastName AS FullName,r.ClubID,c.ClubName,r.JoinedDate  
		FROM Student s  JOIN Registration r 
		ON s.StudentID =r.StudentID 
		 JOIN Club c ON r.ClubID = c.ClubID
--Vấn đề lớn : mất mẹ nó 2 sv 4 và 5, mất mẹ luôn cả clb FCODE FEV
 
 SELECT s.StudentID,s.FirstName+' '+s.LastName AS FullName,r.ClubID,c.ClubName,r.JoinedDate  
		FROM Student s  , Registration r,Club c
		WHERE s.StudentID =r.StudentID AND r.ClubID = c.ClubID
--Tao đố m lấy đc phần hụt, vì nó chỉ đi tìm đám bằng nhau common field
--ghép và in ra, thằng nào ko bằng, hụt, kệ m mày

--JOIN SẼ GIÚP , VÌ NÓ NHÌN LUÔN PHẦN CHUNG VÀ PHẦN HỤT

SELECT s.StudentID,s.FirstName+' '+s.LastName AS FullName,r.ClubID,c.ClubName,r.JoinedDate  
		FROM Student s FULL JOIN  Registration r 
		ON s.StudentID =r.StudentID 
		 FULL JOIN  Club c ON r.ClubID = c.ClubID--11


--btvn
--1.Đếm số clb mà mỗi sv đã tham gia
--Output:mã sv, tên sv, số clb tham gia
SELECT s.StudentID, s.FirstName + ' '+s.LastName AS FullName,COUNT(c.ClubName) AS SLCLB FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID
		LEFT JOIN Club c ON c.ClubID = r.ClubID
		GROUP BY s.StudentID, s.FirstName + ' '+s.LastName 
--2.Sinh viên SE1 tham gia mấy clb
--Output: mã sv, tên sv, số-clb-tham gia
SELECT s.StudentID, s.FirstName + ' '+s.LastName AS FullName,COUNT(c.ClubName) AS SLCLB FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID
		LEFT JOIN Club c ON c.ClubID = r.ClubID
		WHERE S.StudentID = 'SE1'
		GROUP BY s.StudentID, s.FirstName + ' '+s.LastName 
--3.Sv nào tham gia nhiều clb nhất
SELECT s.StudentID, s.FirstName + ' '+s.LastName AS FullName,COUNT(c.ClubName) AS SLCLB FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID
		LEFT JOIN Club c ON c.ClubID = r.ClubID
		GROUP BY s.StudentID, s.FirstName + ' '+s.LastName
--4.CLB Cộng đồng Sinh viên Tình nguyện có những sv nào tham gia (gián tiếp)
--ko dùng sub cũng okie. nhớ là tôi không hỏi SiTi à nhen
-- dùng aub cũng okie
SELECT s.StudentID, s.FirstName + ' '+s.LastName AS FullName FROM Student s FULL JOIN Registration r ON s.StudentID = r.StudentID
		 FULL JOIN Club c ON c.ClubID = r.ClubID
		 WHERE c.ClubName = N'Cộng đồng Sinh viên Tình nguyện'
--5.Mỗi clb có bn thành viên
--Output: mã clb, tên clb, số thành viên
SELECT c.ClubID, c.ClubName, COUNT(S.FirstName) FROM Student s RIGHT JOIN Registration r ON s.StudentID = r.StudentID
		 RIGHT JOIN  Club c ON c.ClubID = r.ClubID
		 GROUP BY c.ClubID, c.ClubName
--6.Câu lạc bộ nào đông member nhất
--Output: mã clb, tên clb , số tv
SELECT TOP(1) WITH TIES  c.ClubID, c.ClubName, COUNT(S.FirstName) AS SLTV FROM Student s RIGHT JOIN Registration r ON s.StudentID = r.StudentID
		 RIGHT JOIN  Club c ON c.ClubID = r.ClubID
		 GROUP BY c.ClubID, c.ClubName
		 ORDER BY SLTV DESC
--7.Clb SiTi và CSG có bao nhiêu member, đếm riêng từng clb
--Output: mã clb, tên clb, số tv(2 dòng)
SELECT c.ClubID, c.ClubName, COUNT(S.FirstName) as SLTV FROM Student s RIGHT JOIN Registration r ON s.StudentID = r.StudentID
		 RIGHT JOIN  Club c ON c.ClubID = r.ClubID
		 GROUP BY c.ClubID, c.ClubName
		 HAVING C.ClubID IN('SiTi','CSG')
--8.Có tổng cộng bn lượt sv tham gia clb
SELECT  COUNT(S.FirstName) as SLTV FROM Student s RIGHT JOIN Registration r ON s.StudentID = r.StudentID
		 RIGHT JOIN  Club c ON c.ClubID = r.ClubID
		 
