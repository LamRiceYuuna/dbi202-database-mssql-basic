
CREATE DATABASE DBLab2

USE DBLab2

CREATE TABLE Student
(
	RN int NOT NULL,
	Name varchar(20),
	Age tinyint	
)

CREATE TABLE Test
(
	TestID int NOT NULL,
	Name varchar(20),
		
)

CREATE TABLE StudentTest
(
	RN int ,
	TestID int,
	Date date,
	Mark float
		
)

ALTER TABLE Student ADD CONSTRAINT pk_student PRIMARY KEY(RN)
ALTER TABLE Test ADD CONSTRAINT pk_testid PRIMARY KEY(TestID)

ALTER TABLE StudentTest ADD CONSTRAINT fk_student FOREIGN KEY(RN) references Student(RN)

ALTER TABLE StudentTest ADD CONSTRAINT fk_test_id FOREIGN KEY(TestID) references Test(TestID)

INSERT INTO Student VALUES(1, 'Nguyen Hong Ha', 20)
INSERT INTO Student VALUES(2, 'Truong Ngoc Anh', 30)
INSERT INTO Student VALUES(3, 'Tuan Minh', 25)
INSERT INTO Student VALUES(4, 'Dan Truong', 22)

INSERT INTO Test VALUES(1, 'EPC')
INSERT INTO Test VALUES(2, 'DWMX')
INSERT INTO Test VALUES(3, 'SQL1')
INSERT INTO Test VALUES(4, 'SQL2')

INSERT INTO StudentTest VALUES(1, 1, '7/17/2006', 8)
INSERT INTO StudentTest VALUES(1, 2, '7/18/2006', 5)
INSERT INTO StudentTest VALUES(1, 3, '7/19/2006', 7)
INSERT INTO StudentTest VALUES(2, 1, '7/17/2006', 7)
INSERT INTO StudentTest VALUES(2, 2, '7/18/2006', 4)
INSERT INTO StudentTest VALUES(2, 3, '7/19/2006', 2)
INSERT INTO StudentTest VALUES(3, 1, '7/17/2006', 10)
INSERT INTO StudentTest VALUES(3, 3, '7/18/2006', 1)

SELECT * FROM StudentTest
SELECT * FROM Student


-----
--a.
SELECT CONVERT(NUMERIC (4,2) , Mark) FROM StudentTest

--b.
SELECT * FROM Student WHERE	Age > 25
--c.
SELECT * FROM Student WHERE	Age IN(20, 30)
--d.
SELECT * FROM Test WHERE Name LIKE '%s%'
--e.
SELECT * FROM StudentTest WHERE Mark > 5
--f.
SELECT * FROM Student WHERE Name LIKE '% ____'
--g.
SELECT * FROM Student WHERE Name LIKE '______ %'
--h.
SELECT * FROM Student WHERE Name LIKE '[^r][^r][^r][^r][^r][^r] %'
--i.
ALTER TABLE Student ADD Status varchar(10) DEFAULT('Young')
--k.
ALTER TABLE StudentTest DROP CONSTRAINT fk_student
ALTER TABLE StudentTest DROP CONSTRAINT fk_test_id 
--l.
ALTER TABLE Student DROP CONSTRAINT pk_student
ALTER TABLE Test DROP CONSTRAINT pk_testid
--m.
DROP TABLE Student
DROP TABLE Test
DROP TABLE StudentTest
--n.
DROP DATABASE DBLab2

--=======EXTRA========

--1.
SELECT AVG(Age) AS [AVG Age] FROM Student 
--2.
SELECT * FROM Student WHERE Age >= ALL (
					SELECT Age FROM Student
					)
--3.
SELECT * FROM Student WHERE Age <= ALL (
					SELECT Age FROM Student
					)
--4.
SELECT TOP(1) WITH TIES Name, Mark
		FROM Test a JOIN StudentTest b ON a.TestID = b.TestID
		ORDER BY Mark DESC
--5.
SELECT TOP(1) WITH TIES Name, Mark
		FROM Test a JOIN StudentTest b ON a.TestID = b.TestID
		ORDER BY Mark
--6.
SELECT  TOP(1) WITH TIES Name, Date
	   FROM Student a JOIN StudentTest b ON a.RN = b.RN
	   ORDER BY Date DESC
--7.
SELECT  TOP(1) WITH TIES Name, Date
	   FROM Student a JOIN StudentTest b ON a.RN = b.RN
	   ORDER BY Date 
--8.
SELECT SUM(Age) AS [Total Age] FROM Student
--9.
SELECT Name, DATEDIFF(DY,Date, GETDATE()) AS N'Số ngày đã thi'
		FROM Test a  JOIN StudentTest b ON a.TestID = b.TestID
--10.
SELECT TOP(1) WITH TIES Name, Mark 
		FROM Student a JOIN StudentTest b ON a.RN = b.RN
		ORDER BY Mark DESC
--11.
SELECT TOP(1) WITH TIES Name, Mark 
		FROM Student a JOIN StudentTest b ON a.RN = b.RN
		ORDER BY Mark 
--12.
SELECT Name,CONVERT(numeric (4, 2), AVG(Mark)) FROM Student a JOIN StudentTest b ON a.RN=b.RN
				GROUP BY a.RN, Name
				ORDER BY AVG(Mark) DESC
--13.
SELECT a.Name AS N'Tên học viên', c.Name AS N'Tên môn học' 
				FROM Student a JOIN StudentTest b ON a.RN=b.RN
				JOIN Test c ON b.TestID = c. TestID
--14.
SELECT Name FROM Student WHERE RN
		NOT IN (SELECT RN FROM StudentTest)
--15.
SELECT a.Name AS N'Tên học viên', c.Name AS N'Tên môn học' 
				FROM Student a JOIN StudentTest b ON a.RN=b.RN
				JOIN Test c ON b.TestID = c. TestID
				WHERE Mark < 5
--16
SELECT TOP(1) WITH TIES Name, AVG(Mark) 
		FROM Student a JOIN StudentTest b ON a.RN = b.RN
		GROUP BY a.RN, Name
		ORDER BY AVG(Mark) DESC

--17.
SELECT TOP(1) WITH TIES Name, AVG(Mark) 
		FROM Student a JOIN StudentTest b ON a.RN = b.RN
		GROUP BY a.RN, Name
		ORDER BY AVG(Mark) 
--18.
SELECT Name, MAX(Mark) AS [Max Mark] FROM Test a JOIN StudentTest b ON a.TestID = b.TestID
		GROUP BY a.TestID,Name;

--19.
SELECT a.Name AS N'Tên học viên', c.Name AS N'Tên môn học' 
				FROM Student a LEFT JOIN StudentTest b ON a.RN=b.RN
				LEFT JOIN Test c ON b.TestID = c. TestID
				