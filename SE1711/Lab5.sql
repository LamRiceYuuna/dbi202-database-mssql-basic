--1.Done
--2.
CREATE DATABASE DBLab5
USE DBLab5
--3.

CREATE TABLE Student
(
	RN int NOT NULL,
	Name nvarchar(30),
	Age int,
	Gender bit
)

CREATE TABLE Subjects
(
	sID int NOT NULL,
	sName nvarchar(30),
)

CREATE TABLE StudentSubject
(
	RN int NOT NULL,
	sID int NOT NULL,
	Mark float,
	Date date,
)

--4.Tạo PK
ALTER TABLE Student ADD CONSTRAINT PK_RN_Student PRIMARY KEY(RN)
ALTER TABLE Subjects ADD CONSTRAINT PK_sID_Subjects PRIMARY KEY(sID)

ALTER TABLE StudentSubject ADD CONSTRAINT PK_RN_sID PRIMARY KEY(RN, sID)

--5.
ALTER TABLE StudentSubject ADD CONSTRAINT CK_Mark CHECK(Mark BETWEEN 0 AND 10)

--6.
ALTER TABLE StudentSubject ADD CONSTRAINT FK_RN FOREIGN KEY(RN) REFERENCES Student(RN)

--7.
ALTER TABLE StudentSubject ADD CONSTRAINT FK_sID FOREIGN KEY(sID) REFERENCES Subjects(sID)

--8.
INSERT Student(RN, Name) VALUES
		(1, N'Mỹ Linh'),
		(2, N'Đàm Vĩnh Hưng'),
		(3, N'Kim Tử Long'),
		(4, N'Tài Linh'),
		(5, N'Mỹ Lệ'),
		(6, N'Ngọc Oanh');

INSERT Subjects VALUES
		(1, 'SQL'),
		(2, 'LGC'),
		(3, 'HTML'),
		(4, 'CF');

INSERT StudentSubject VALUES
		(1, 1, 8, '7/28/2005'),
		(2, 2, 3, '7/29/2005'),
		(3, 3, 9, '7/31/2005'),
		(4, 1, 5, '7/30/2005'),
		(5, 4, 10, '7/19/2005'),
		(6, 1, 9, '7/25/2005');

--9.
UPDATE  Student SET Gender = 0 WHERE Name IN (N'Mỹ Linh', N'Tài Linh', N'Mỹ Lệ')  

UPDATE  Student SET Gender = 1 WHERE Name = N'Kim Tử Long'
SELECT * FROM Student

--10.
INSERT Subjects VALUES 
		(5, 'Core Java'),
		(6, 'VB.Net');

--11.
SELECT * FROM Subjects WHERE sID NOT IN (SELECT sID FROM  StudentSubject)

--12.
SELECT s.sName, MAX(ss.Mark) AS [Điểm số lớn nhất] FROM Subjects s LEFT JOIN StudentSubject ss
		 ON s.sID = ss.sID
		 GROUP BY s.sName

--13.
SELECT s.sName, COUNT(ss.Mark) AS [Số lượng điểm] FROM Subjects s  JOIN StudentSubject ss
		 ON s.sID = ss.sID
		 GROUP BY s.sName
		 having COUNT(ss.Mark) > 1

--14.
SELECT st.RN, sj.sID, Name, Age, Gender = case Gender
		when 1 then 'Male'
		when 0 then 'Female'
		else 'Unknow'
		end
		,sName, Mark, Date  FROM Subjects sj  JOIN StudentSubject ss
		 ON sj.sID = ss.sID JOIN Student st ON st.RN = ss.RN

--15.
CREATE INDEX nci_Name on Student(Name);
CREATE INDEX nci_sName on Subjects(sName);
CREATE INDEX nci_RN_sID on StudentSubject(RN, sID);

--16.

SELECT TOP(3) st.RN, Name,Mark,sj.sName, GETDATE() AS [Date],
			ROW_NUMBER() OVER(ORDER BY Mark DESC)[Rank]	INTO TOP3	 
		 FROM Student st  JOIN StudentSubject ss
		 ON st.RN = ss.RN JOIN Subjects sj ON ss.sID = sj.sID

SELECT *  FROM TOP3

--17.

SELECT st.Name,AVG(ss.Mark) [Điểm tb]
		FROM Student st  JOIN StudentSubject ss
		 ON st.RN = ss.RN JOIN Subjects sj ON ss.sID = sj.sID
		 WHERE ss.Mark >= 5
		 GROUP BY st.Name, st.RN
		 having AVG(ss.Mark) >= 8

--18.
SELECT st.Name,AVG(ss.Mark) [Điểm tb]
		FROM Student st  JOIN StudentSubject ss
		ON st.RN = ss.RN JOIN Subjects sj ON ss.sID = sj.sID
		GROUP BY st.Name, st.RN
		having AVG(ss.Mark) >= 6.5 AND 
		(SELECT COUNT(Mark) FROM StudentSubject WHERE st.RN = RN AND Mark < 5) <= 1 AND
		(SELECT COUNT(Mark) FROM StudentSubject WHERE st.RN = RN AND Mark < 3) = 0