-- SELECT * FROM hangout.employee;

-- select * from permanentemp;

-- select * from tempemployee;
use hangout;

ALTER TABLE `hangout`.`employee` 
CHANGE COLUMN `address` `type` VARCHAR(45) NULL DEFAULT NULL ;

ALTER TABLE `hangout`.`employee` 
CHANGE COLUMN `dob` `dob` DATE NULL DEFAULT NULL ;

ALTER TABLE `hangout`.`permanentemp` 
ADD COLUMN `basicSalary` FLOAT NULL AFTER `etf`;

ALTER TABLE `hangout`.`tempemployee` 
ADD COLUMN `otRate` FLOAT NULL AFTER `hrate`;

ALTER TABLE `hangout`.`employee` 
ADD COLUMN `gender` VARCHAR(45) NULL AFTER `tel`,
ADD COLUMN `department` VARCHAR(45) NULL AFTER `gender`,
ADD COLUMN `position` VARCHAR(45) NULL AFTER `department`;

ALTER TABLE `hangout`.`employee` 
ADD COLUMN `status` VARCHAR(45) NULL DEFAULT 'Available' AFTER `position`;

ALTER TABLE employee
DROP COLUMN tel ;

Delimiter $$
create procedure addPermanentEmployees(In fname varchar(60),In lname varchar(60),In nic varchar(10),In dob date, In gender varchar(45),In department varchar(45),In position varchar(45),In empType varchar(45),In basicSalary float)
begin
	if(empType = 'permanent') THEN
		insert into employee (fname,lname,nic,dob,gender,department,position,type)
		values(fname,lname,nic,dob,gender,department,position,empType);
        
        insert into permanentEmp(peid,basicSalary)
		values(last_insert_id(),basicSalary);
    end if;
end $$ 
Delimiter ;

Delimiter $$
create procedure addTemporaryEmployees(In fname varchar(60),In lname varchar(60),In nic varchar(10),In dob date, In gender varchar(45),In department varchar(45),In position varchar(45),In empType varchar(45),In otRate float)
begin
	if(empType = 'temporary') THEN
		insert into employee (fname,lname,nic,dob,gender,department,position,type)
		values(fname,lname,nic,dob,gender,department,position,empType);
        
        insert into tempemployee(teid,otRate)
        values(last_insert_id(),otRate);
    end if;
end $$ 
Delimiter ;

-- drop procedure addPermanentEmployees;
-- drop procedure addTemporaryEmployees;

-- call addPermanentEmployees('George','Silva','971589643V','1997-11-08','male','Pastry','Chef','temporary',100000);

-- call addTemporaryEmployees('George','Hiroshi','971589643V','1998-11-08','male','Bakery','Assistant Chef','temporary',100000);

-- create view disabledEmployees 
-- as
-- select e.eid,e.fname,e.lname,e.nic,e.dob,e.gender,e.department,e.position,e.type,p.peid,p.basicSalary,p.bonus,p.epf,p.etf,t.teid,t.hrate,t.hours,t.otRate
-- from employee e, permanentemp p, tempemployee t
-- where e.id=p.peid and e.id=t.teid and e.status = 'Unavailable';

-- select * from disabledEmployees;

-- drop view disabledEmployees;


ALTER TABLE `hangout`.`permanentemp` 
CHANGE COLUMN `month` `month` VARCHAR(45) NOT NULL DEFAULT 'January' ,
CHANGE COLUMN `year` `year` VARCHAR(45) NOT NULL DEFAULT '2019' ;
