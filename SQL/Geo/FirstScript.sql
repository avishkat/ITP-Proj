use hangout;

create table Employee 
(
	id int AUTO_INCREMENT ,
	eid varchar(50),
    fname varchar(60),
    lname varchar(60),
    nic varchar(10),
    dob datetime,
    address varchar(100),
    tel varchar(10),
    
    CONSTRAINT pk_eid
		PRIMARY KEY (id)
);

create table PermanentEmp
(
	peid int,
    bonus float,
    epf float,
    etf float,
    
    CONSTRAINT pk_peid
		PRIMARY KEY (peid),
        
	CONSTRAINT fk_peid
		FOREIGN KEY (peid)
		REFERENCES Employee(id)
        on update cascade
        on delete cascade
);

CREATE TABLE TempEmployee
(
	teid int,
    hours float,
    hrate float,
    
    CONSTRAINT pk_teid
		PRIMARY KEY (teid),
        
	CONSTRAINT fk_teid
		FOREIGN KEY (teid)
		REFERENCES Employee(id)
        on update cascade
        on delete cascade
);

CREATE TABLE EmpLeaves
(
	leaveid int  AUTO_INCREMENT,
    leave_type varchar(60),
    leave_status varchar(50) default 'In Progress',
	leave_date datetime,
    
    CONSTRAINT pk_leaveid
		PRIMARY KEY (leaveid)
);

CREATE TABLE PermanentLeave
(
	pempid int,
    leave_id int,
    
    CONSTRAINT pk_permanentLeave
		PRIMARY KEY (pempid,leave_id),
        
	CONSTRAINT fk_pempid
		FOREIGN KEY (pempid)
		REFERENCES PermanentEmp(peid)
        on update cascade
        on delete cascade,
        
	CONSTRAINT fk_leave_id
		FOREIGN KEY (leave_id)
		REFERENCES EmpLeaves(leaveid)
        on update cascade
        on delete cascade
);

CREATE TABLE Attendance
(
	attenid int  AUTO_INCREMENT,
    dateCount int,
    atd_eid int,
    
    CONSTRAINT pk_attenid
		PRIMARY KEY (attenid),
        
	CONSTRAINT fk_attendEmp
		FOREIGN KEY (atd_eid)
		REFERENCES Employee(id)
        on update cascade
        on delete cascade
);

create table Menu
(
menuId int  AUTO_INCREMENT,
menu_name varchar(50),
menu_description varchar(100),
price float,

constraint pk_mid_mname
primary key(menuId,menu_name)

);

create table Package
(
packageId int  AUTO_INCREMENT,
menu_id int,
noOfPeople int,

constraint pk_pid
primary key(packageId),

constraint fk_mid
foreign key(menu_id)
references Menu(menuId)
ON UPDATE CASCADE
ON DELETE CASCADE
);
    

CREATE TABLE TempPackage
(
	empid int,
    packageId int,
    
    CONSTRAINT pk_tempPackage
		PRIMARY KEY (empid,packageId),
        
	CONSTRAINT fk_empid
		FOREIGN KEY (empid)
		REFERENCES TempEmployee(teid)
        on update cascade
        on delete cascade,
        
	CONSTRAINT fk_packid
		FOREIGN KEY (packageId)
		REFERENCES Package(packageId)
		on update cascade
        on delete cascade
);

create table Stock
(
		stockId int  AUTO_INCREMENT,
		arrivalDate date,
		expDate date,
		stock_type varchar(100),
		qty int,

		constraint pk_sid
		primary key(stockId)
);

create table Product(
	productID int  AUTO_INCREMENT,
	productName varchar(10),
	quantity integer,
	unitPrice float,
    
    constraint pk_pid
	primary key(productID)
);

create table RawMaterials
(
		rawId int  AUTO_INCREMENT,
		raw_type varchar(100),
		qty int,
		raw_name varchar(100),
		price float,

		constraint pk_rid
		primary key(rawId)
);

create table Raw_Stock
(
		sid int,
		rid int,

		constraint pk_rawStock
		primary key(sid,rid),

		constraint fk_sid
		foreign key(sid)
		references Stock(stockId)
		ON UPDATE CASCADE
		ON DELETE CASCADE,

		constraint fk_rid
		foreign key(rid)
		references RawMaterials(rawId)
		ON UPDATE CASCADE
		ON DELETE CASCADE

);

create table Product_Stock(
	productID int,
	stockID int,

	constraint pk_prodStock
		primary key(productID,stockID),

	constraint fk_prodStock
		foreign key(productID)
		references Product(productID)
		on update cascade
		on delete cascade,

		foreign key(stockID)
		references Stock(stockId)
		on update cascade
		on delete cascade
);




create table Utilities
(
utilityId int  AUTO_INCREMENT,
qty int,
uti_name varchar(100),
price float,

constraint pk_uid
primary key(utilityId)

);
    
 create table Package_Utility
(
pid int,
uid int,

constraint fk_pid
foreign key(pid)
references Package(packageId)
ON UPDATE CASCADE
ON DELETE CASCADE,

constraint fk_uid
foreign key(uid)
references Utilities(utilityId)
ON UPDATE CASCADE
ON DELETE CASCADE

);

CREATE TABLE Customer
(
	customerID int  AUTO_INCREMENT,
	cus_Name VARCHAR(50),
	Phone CHAR(10),
	totalExpenditure REAL,
	cus_Point FLOAT,
	
	CONSTRAINT pk_customerID_phone
	PRIMARY KEY (customerID,phone)

);

-- CREATE TABLE Cust_Feedback
-- (
-- 	custID varchar(50),
-- 	feedbackID varchar(50),
-- 	service float,
-- 	food float,
-- 	overall FLOAT,

-- 	CONSTRAINT pk_feedbackID
-- 	PRIMARY KEY (feedbackID),
-- 	
-- 	CONSTRAINT fk_custID
-- 	FOREIGN KEY (custID)
-- 	REFERENCES Customer(customerID)
-- 	on update cascade
--     on delete cascade

-- );


create table Payment
(
	paymentID int  AUTO_INCREMENT,
    pay_date date,
    tot_amnt float,
    
    constraint pay_id
    primary key(paymentID)
);
    
CREATE TABLE Cust_Product
(
	productID int,
	custID int,
	paymentID int,
	
	CONSTRAINT pk_p
	PRIMARY KEY (productID,custID),
	
	CONSTRAINT fk_productID
	FOREIGN KEY (productID)
	REFERENCES Product(productID)
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


create table Catering(

	cateringID int  AUTO_INCREMENT,
    phone varchar(10),
	packageID int,
	customerID int,
	payementID int,
	orderdate date,
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
    on delete cascade,
    
    constraint fk_payment_catering_ID
    foreign key(payementID)
    references Payment(paymentID)
    on update cascade
    on delete cascade

);

CREATE TABLE hall_function (
  functionID int,
  phone varchar(10),
  packageID int,
  custID int,
  func_date date ,
  func_time time,
  func_status varchar(50) ,
  tax varchar(50) ,
  serviceCharge varchar(50) ,
  lateFee varchar(50),
  paymentID int ,
  
  CONSTRAINT pk_feunctionID_phone
	PRIMARY KEY (functionID,phone),
    
    CONSTRAINT fk_cust_ID
	FOREIGN KEY (custID)
	REFERENCES Customer(customerID)
    on update cascade
    on delete cascade,

	CONSTRAINT fk_hall_paymentID
	FOREIGN KEY (paymentID)
	REFERENCES Payment(paymentID)
    on update cascade
    on delete cascade,
    
    constraint fk_hall_packageID
    foreign key(PackageID)
    references Package(packageId)
    on update cascade
    on delete cascade
) ;
