Create table Customers
(
	CustomerID int primary key,
	FullName nvarchar(100),
	[Address] nvarchar(200)
)

Create table Branches
(
	BranchID int primary key,
	[Name] nvarchar(100),
	[Address] nvarchar(200)
)

Create table Vehicles
(
	VehicleID int primary key,
	Model nvarchar(50),
	Maker varchar(20),
	[Year] int,
	RentalPrice float
)

Create table Rent
(
	PickupDate Date,
	DropoffDate Date,
	CustomerID int,
	BranchID int,
	VehicleID int,
	primary key(PickupDate,CustomerID,BranchID,VehicleID),
	foreign key(CustomerID) references Customers(CustomerID),
	foreign key(BranchID) references Branches(BranchID),
	foreign key(VehicleID) references Vehicles(VehicleID)
)