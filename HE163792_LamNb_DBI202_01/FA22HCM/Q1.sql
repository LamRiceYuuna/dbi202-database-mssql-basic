

create table Salespersons (
	SalespersonID int primary key,
	Name varchar(100)
)


create table Cars (
	SerialNo int primary key,
	Price decimal(12),
	Model varchar(50),
	SalespersonID int foreign key references Salespersons(SalespersonID),
	Saledate date
)

create table Options (
	OptionName varchar(100),
	Price decimal(8),
	SerialNo int foreign key references Cars(SerialNo),
	primary key (OptionName, SerialNo)
)