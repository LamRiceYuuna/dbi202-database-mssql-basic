--1. Tạo một file SQL có tên Lab1.sql 
--Done
--2. Tạo một Cơ sở dữ liệu (CSDL) có tên DBLab1
CREATE DATABASE DBLab1
DROP DATABASE DBLab1
--3. Trong CSDL DBLab1 tạo các bảng và thiết lập các ràng buộc PK, FK theo sơ đồ phía trên.
USE DBLab1
DROP TABLE Students
CREATE TABLE Students
(
	StudentID int NOT NULL,
	StudentName nvarchar(50),
	Age int NOT NULL,
	Email varchar(100)
)
DROP TABLE Classes
CREATE TABLE Classes
(
	ClassID int NOT NULL,
	ClassName nvarchar(50),
)

CREATE TABLE ClassStudent
(
	StudentID int,
	ClassID int
)
DROP TABLE Subjects
CREATE TABLE Subjects
(
	SubjectID int NOT NULL,
	SubjectName nvarchar(50)
)


CREATE TABLE Marks
(
	Mark int,
	SubjectID int,
	StudentID int
)

ALTER TABLE Students ADD CONSTRAINT pk_student PRIMARY KEY(StudentID)
ALTER TABLE Subjects ADD CONSTRAINT pk_suject PRIMARY KEY(SubjectID)
ALTER TABLE Classes ADD CONSTRAINT pk_class PRIMARY KEY(ClassID)

ALTER TABLE Marks ADD CONSTRAINT fk_student_mark FOREIGN KEY(StudentID) references Students(StudentID)
ALTER TABLE ClassStudent ADD CONSTRAINT fk_student_classstudent FOREIGN KEY(StudentID) references Students(StudentID)
ALTER TABLE Marks ADD CONSTRAINT fk_student_subject FOREIGN KEY(SubjectID) references Subjects(SubjectID)
ALTER TABLE ClassStudent ADD CONSTRAINT fk_student_class FOREIGN KEY(ClassID) references Classes(ClassID)


--4.Chèn dữ liệu cho các bảng như dưới
INSERT INTO Students VALUES(1, 'Nguyen Quang An', 18, 'an@yahoo.com')
INSERT INTO Students VALUES(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com')
INSERT INTO Students VALUES(3, 'Nguyen Van Quyen ', 21, 'quyen')
INSERT INTO Students VALUES(4, 'Pham Thanh Binh', 25, 'binh@com')
INSERT INTO Students VALUES(5, 'Nguyen Van Tai Em', 30, 'taiem@spot.vn')


INSERT INTO Classes VALUES(1, 'C0706L')
INSERT INTO Classes VALUES(2, 'C0708G')


INSERT INTO ClassStudent VALUES(1, 1)
INSERT INTO ClassStudent VALUES(2, 1)
INSERT INTO ClassStudent VALUES(3, 2)
INSERT INTO ClassStudent VALUES(4, 2)
INSERT INTO ClassStudent VALUES(5, 2)


INSERT INTO Subjects VALUES(1, 'SQL')
INSERT INTO Subjects VALUES(2, 'Java')
INSERT INTO Subjects VALUES(3, 'C')
INSERT INTO Subjects VALUES(4, 'Visual Basic')


INSERT INTO Marks VALUES(8, 1, 1)
INSERT INTO Marks VALUES(4, 2, 1)
INSERT INTO Marks VALUES(9, 1, 1)
INSERT INTO Marks VALUES(7, 1, 3)
INSERT INTO Marks VALUES(3, 1, 4)
INSERT INTO Marks VALUES(5, 2, 5)
INSERT INTO Marks VALUES(8, 3, 3)
INSERT INTO Marks VALUES(1, 3, 5)
INSERT INTO Marks VALUES(3, 2, 4)

--5.Hiện thị danh sách tất các học viên
SELECT * FROM Students

--6.Hiện thị danh sách tất các môn học
SELECT * FROM Subjects

--7. Tạo ràng buộc Check để kiểm tra độ tuổi nhập vào trong bảng Students phải nằm trong khoảng 15 và 50.

ALTER TABLE Students ADD CONSTRAINT age_check CHECK (Age >= 15 AND Age <= 50)

--8. Trong bảng Students thêm một cột có tên Status có kiểu bit, sau đó thiết lập ràng buộc default(1) cho cột này

ALTER TABLE Students ADD Status bit
ALTER TABLE Students ADD CONSTRAINT status_default DEFAULT(1) FOR Status

--9. Loại bỏ tất cả các ràng buộc PK và FK giữa các bảng.

ALTER TABLE Students DROP CONSTRAINT pk_student 
ALTER TABLE Subjects DROP CONSTRAINT pk_suject 
ALTER TABLE Classes DROP CONSTRAINT pk_class 

ALTER TABLE Marks DROP CONSTRAINT fk_student_mark
ALTER TABLE ClassStudent DROP CONSTRAINT fk_student_classstudent 
ALTER TABLE Marks DROP CONSTRAINT fk_student_subject
ALTER TABLE ClassStudent DROP CONSTRAINT fk_student_class