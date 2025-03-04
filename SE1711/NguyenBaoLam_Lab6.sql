--1.Done
--2.
CREATE DATABASE NguyenBaoLam_Lab6
--3.
CREATE TABLE Students
(
	StudentID int not null,
	Name varchar(30),
	Age tinyint,
	stGender bit
)

INSERT Students VALUES
	(1, 'Joe Hart', 25, 1),
	(2, 'Colin Doyle', 20, 1),
	(3, 'Paul Robinson', 16, null),
	(4, 'Luis Garcia Paulson', 17, 0),
	(5, 'Ben Foster', 30, 1);

CREATE TABLE Projects
(
	PID int not null,
	PName varchar(50),
	Cost float,
	Type varchar(10)
)
INSERT Projects VALUES
	(1, 'NewYork Bridge', 100, null),
	(2, 'Tenda Road', 60, null),
	(3, 'Google Road', 200, null),
	(4, 'The Star Bridge', 50, null);

DROP TABLE StudentProject

CREATE TABLE StudentProject
(
	StudentID int not null,
	PID int not null,
	WorkDate date,
	Duration int
)

INSERT StudentProject VALUES
	(1, 4, '05/15/09', 3),
	(2, 2, '05/14/09', 5),
	(2, 3, '05/20/09', 6),
	(2, 1, '05/16/09', 4),
	(3, 1, '05/16/09', 6),
	(3, 4, '05/19/09', 7),
	(4, 4, '05/21/09', 8);

SELECT * FROM Students
SELECT * FROM Projects
SELECT * FROM StudentProject

--4.
--4a.
ALTER TABLE Students ADD CONSTRAINT Ck_Age CHECK(Age > 15 AND Age < 33)
--4b.
ALTER TABLE Students ADD CONSTRAINT PK_StudentID PRIMARY KEY(StudentID)

ALTER TABLE Projects ADD CONSTRAINT PK_PID PRIMARY KEY(PID)

ALTER TABLE StudentProject ADD CONSTRAINT PK_StudentID_PID PRIMARY KEY(StudentID, PID)
--4c.
ALTER TABLE StudentProject ADD CONSTRAINT DF_Duration DEFAULT(0) FOR Duration

--4d.
ALTER TABLE StudentProject ADD 
	CONSTRAINT FK_StudentID FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_Projects FOREIGN KEY(PID) REFERENCES Projects(PID);

--5.
UPDATE Projects SET Type = CASE	
	WHEN Cost < 80 then 'Education'
	WHEN Cost BETWEEN 80 AND 150 THEN 'Normal'
	else 'Government'
	end;

SELECT * FROM Projects

--6.
SELECT Name, COUNT(PID) [Số lượng dự án] 
	FROM Students a JOIN StudentProject b ON a.StudentID = b.StudentID
	GROUP BY Name, a.StudentID
	HAVING COUNT(PID) > 1

--7.
SELECT TOP(1) WITH TIES Name, SUM(Duration) [Tổng thời gian] 
	FROM Students a JOIN StudentProject b ON a.StudentID = b.StudentID
	GROUP BY Name, a.StudentID
	ORDER BY SUM(Duration) DESC

--8.
SELECT *
	FROM Students a JOIN StudentProject b ON a.StudentID = b.StudentID
	JOIN Projects c On c.PID = b.PID
	WHERE a.Name like '%Paul%' AND PName = 'The Star Bridge'

--9.
SELECT * FROM Students WHERE StudentID NOT IN(
	SELECT StudentID FROM StudentProject)

--10.
CREATE VIEW vwStudentProject AS
SELECT TOP(99.99) PERCENT Name, PName, WorkDate, Duration
	FROM Students a FULL JOIN StudentProject b ON a.StudentID = b.StudentID
	FULL JOIN Projects c ON c.PID = b.PID
	ORDER BY Name ;

SELECT * FROM vwStudentProject	

--11.
ALTER VIEW vwStudentProject with encryption , schemabinding AS
SELECT Name, PName, WorkDate, Duration
	FROM dbo.Students a  JOIN dbo.StudentProject b ON a.StudentID = b.StudentID
	JOIN dbo.Projects c ON c.PID = b.PID

CREATE	UNIQUE CLUSTERED INDEX ixStudentName
	ON vwStudentProject (Name, PName);

--12.
CREATE PROC spWorkin (@Name varchar(50) ) AS
BEGIN
	IF(EXISTS(SELECT Name FROM Students WHERE Name LIKE'%'+@Name+'%'))
		SELECT Name, PName FROM Students a JOIN StudentProject b 
		ON a.StudentID = b.StudentID JOIN Projects c
		ON c.PID = b.PID
		WHERE Name LIKE'%'+@Name+'%'
	ELSE IF(@Name = 'any')
		SELECT Name, PName FROM Students a JOIN StudentProject b 
		ON a.StudentID = b.StudentID JOIN Projects c
		ON c.PID = b.PID
	ELSE
		PRINT N'Không có thông tin'
END;

exec spWorkin 'Paul'
exec spWorkin 'any'
exec spWorkin 'grewgw'

--13.
CREATE TRIGGER tgUpdateTrig ON Students
INSTEAD OF UPDATE AS
BEGIN
	ALTER TABLE StudentProject DROP CONSTRAINT FK_StudentID;
	UPDATE Students SET StudentID = (SELECT StudentID FROM inserted)
		WHERE StudentID = (SELECT StudentID FROM deleted)
	UPDATE StudentProject SET StudentID = (SELECT StudentID FROM inserted)
		WHERE StudentID = (SELECT StudentID FROM deleted)
	ALTER TABLE StudentProject ADD CONSTRAINT FK_StudentID
		FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
END;

SELECT * FROM Students
SELECT * FROM StudentProject
UPDATE Students SET StudentID = 16 WHERE StudentID = 1

--14.
CREATE PROC spDropOut (@PName varchar(50)) AS
BEGIN
	IF(EXISTS(SELECT PName FROM Projects WHERE PName = @PName))
	begin
		delete from StudentProject WHERE PID
			IN(SELECT PID FROM Projects WHERE PName = @PName)
		delete from Projects where PName = @PName;
	end;
	else
		PRINT N'Không tìm được thông tin'
END;

EXEC spDropOut 'The Star Bridge'
select * from Projects
select * from StudentProject