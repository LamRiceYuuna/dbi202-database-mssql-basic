Create table Customers
(
	SSN varchar(20) primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(255)
)

Create table Loans
(
	LoanNumber varchar(20) primary key,
	Amount float,
	Branch nvarchar(100),
	[Date] Date,
	SSN varchar(20)
	foreign key(SSN) references Customers(SSN)
)

Create table Payments
(
	PaymentNo varchar(30),
	Amount float,
	[Date] Date,
	LoanNumber varchar(20),
	primary key(PaymentNo,LoanNumber),
	foreign key (LoanNumber) references Loans(LoanNumber)
)