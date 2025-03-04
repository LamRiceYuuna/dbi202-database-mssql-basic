create table items
(
	itemID int primary key,
	[name] nvarchar(255),
	price float
)

create table itemVariants
(
	variantID int primary key,
	detail nvarchar(200),
	color nvarchar(50),
	size nvarchar(30),
	itemID int
	foreign key (itemID) references items(itemID)
)

create table categories
(
	catID int primary key,
	[name] nvarchar(255)
)

create table belongTo
(
	catID int,
	itemID int,
	primary key(catID, itemID),
	foreign key (itemID) references items(itemID),
	foreign key (catID) references categories(catID)
)