use hangout;
-- drop table raw_stock;
-- drop table product_stock;
drop table cust_product;
drop table rawmaterials;
drop table product;


CREATE TABLE Cust_Stock
(
	stockID int,
	custID int,
	paymentID int,
	
	CONSTRAINT pk_p
	PRIMARY KEY (stockID,custID),
	
	CONSTRAINT fk_stockID
	FOREIGN KEY (stockID)
	REFERENCES Stock(stockId)
	on update cascade
	on delete cascade,
	
	CONSTRAINT fk_custmID
	FOREIGN KEY (custID)
	REFERENCES Customer(customerID)
	on update cascade
	on delete cascade,

	CONSTRAINT fk_paymentID
	FOREIGN KEY (paymentID)
	REFERENCES Payment(paymentID)
	on update cascade
	on delete cascade

);



create table Stock
(
		stockId int  AUTO_INCREMENT,
        name varchar(20),
		qty int,
        unitPrice float,
		arrivalDate date,
		expDate date,
        status varchar(15) default 'Available',
		
		constraint pk_sid
		primary key(stockId)
);


CREATE TABLE `hall_function` (
  `functionID` int(11)  AUTO_INCREMENT,
  `phone` varchar(10) NOT NULL,
  `custID` varchar(50) DEFAULT NULL,
  `cust_name` varchar(50) NOT NULL,
  `func_date` varchar(20) DEFAULT NULL,
  `func_time` varchar(20) DEFAULT NULL,
  `packageID` varchar(50) DEFAULT NULL,
  `menuID` varchar(50) NOT NULL,
  `no_of_people` int(11) NOT NULL,
  `amount` double NOT NULL,
  `advance` double NOT NULL,
  `tax` double DEFAULT NULL,
  `serviceCharge` double DEFAULT NULL,
  `total` double NOT NULL,
  `func_status` varchar(50) DEFAULT NULL,
  `paymentID` varchar(50) DEFAULT NULL,
  
  constraint pk_hall
  primary key(functionID)
  
  
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


select * from catering;
drop table catering;



create table bill(

item varchar(50),
ppu float,
qty int,
cost float

);

create table restitem(
rItemNo int PRIMARY KEY,
rItem varchar(20),
rqty int,
rUnitPrice float
);


create table Catering(

	cateringID int  AUTO_INCREMENT,
    	phone varchar(10),
	customerID int,
	packageID int,
	plates int,
	orderdate varchar(10),
    	status varchar(50),

   constraint pk_catering_phone
	primary key(cateringID,phone),

	constraint fk_packageID
    foreign key(packageID)
    references Package(packageId)
    on update cascade
    on delete cascade,
    
    constraint fk_CustomerID
    foreign key(CustomerID)
    references Customer(customerID)
    on update cascade
    on delete cascade
);


Alter table package add pack_Price varchar(45);

Alter table package drop noOfPeople;

CREATE VIEW payinfo AS
SELECT c.cateringID,cus.cus_Name,p.packageID,p.pack_price,c.plates,t.discount
FROM Catering c,Customer cus,Package p,transaction t
WHERE c.`packageID`=p.`packageId` AND c.`customerID`=cus.`customerID` AND c.`customerID`=t.cusID;

create table catpay
(
    paymentID varchar(10),
    cateringID int,
    cus_name varchar(50),
    pay_date date,
    tot_amnt float,
    
    constraint pay_id
    primary key(paymentID),

	CONSTRAINT fk_cateringID
	FOREIGN KEY (cateringID)
	REFERENCES catering(cateringID)
	on update cascade
	on delete cascade

	
);

ALTER TABLE Customer CHANGE totalExpenditure Email char(50);
ALTER TABLE Customer CHANGE cus_point Address varchar(100);
ALTER TABLE customer
ADD totalExpenditure varchar(10);

create table transaction(

	cusID int  AUTO_INCREMENT,
    	grossTotal varchar(10),
	Discount varchar(5),
	Points varchar(5),

   constraint pk_catering_phone
	primary key(cusID),

	constraint fk_cusID
    foreign key(cusID)
    references customer(customerID)
    on update cascade
    on delete cascade
);

create view cuspoints as 
select c.cus_name,sum(ca.Tot_amnt)
from customer c,catpay ca;


ALTER TABLE Utilities
ADD arrD date;

ALTER TABLE Utilities
ADD Status1 varchar(20)
DEFAULT "Available";

ALTER TABLE Stock
ADD Status1 varchar(20)
DEFAULT "Available";

select * from users;



create table catpay
(
    paymentID varchar(10),
    cateringID int,
    cus_name varchar(50),
    pay_date varchar(10),
    tot_amnt float,
    
    constraint pay_id
    primary key(paymentID),

	CONSTRAINT fk_cateringID
	FOREIGN KEY (cateringID)
	REFERENCES catering(cateringID)
	on update cascade
	on delete cascade
);
