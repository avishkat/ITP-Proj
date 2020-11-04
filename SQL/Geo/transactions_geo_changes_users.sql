use hangout;
Delimiter $$
create procedure addleaves(In empid int,In fname varchar(60), in lname varchar(60), in leavetype varchar(60),  in leavedate date)
begin
insert into empleaves(leave_type,leave_date)
values(leavetype,leavedate);

insert into permanentleave
values(empid,last_insert_id());
end $$
Delimiter ;


create view deletedleaves as
select el.leaveid,pl.pempid,el.leave_type,el.leave_date,el.leave_status
from  empleaves el , permanentleave pl
where el.leaveid = pl.leave_id and el.leave_status ='Completed'

Delimiter $$
create procedure deleteleaves(In leavid int)
begin
update empleaves set leave_status ='Completed' where leaveid=leavid;

end $$
Delimiter ;


-- ALTER TABLE `hangout`.`empleaves` 
-- ADD COLUMN `leave_date` DATE NULL AFTER `leave_status`,
-- CHANGE COLUMN `leave_status` `leave_status` VARCHAR(50) NULL DEFAULT 'In Progress' ;

-- select * from deletedleaves;

-- drop view deletedleaves;

-- drop procedure if exists addleaves;

-- call addleaves(1,'george','silva','fullday','2019-10-02');


-- select * from empleaves;
-- select * from permanentleave;



create table Users
(
	eid int,
	email varchar(50),
    password varchar(100),
    
    constraint pk_user
    primary key(eid),
    
    constraint fk_user
    foreign key(eid)
    references permanentemp(peid)
    
);


CREATE TABLE Attendance
(
	attenid int  AUTO_INCREMENT,
    presentdate date ,
    clockin time default '08:00:00',
    clockout time default '15:00:00',
    atten varchar(30) default 'present',
    atd_eid int,
    
    CONSTRAINT pk_attenid
		PRIMARY KEY (attenid),
        
	CONSTRAINT fk_attendEmp
		FOREIGN KEY (atd_eid)
		REFERENCES Employee(id)
        on update cascade
        on delete cascade
);


Delimiter $$
create procedure absentatten(In eid int) 
begin
insert into attendance
(presentdate,atd_eid)
values(curdate(),eid);

update attendance
set atten ='Absent',clockin='00:00:00',clockout='00:00:00'
where atd_eid=eid;
end $$

Delimiter ;


Delimiter $$
create procedure markatten(In eid int) 
begin
insert into attendance
(presentdate,atd_eid)
values(curdate(),eid);

end $$
Delimiter ;





create view  leavecount(eid,noofleaves,month,year)as
select pempid ,count(leave_id),month(el.leave_date)as month,year(el.leave_date)as year
from permanentleave pl,empleaves el
where pl.leave_id=el.leaveid
group by pempid,month;


create view permanentEmployee(eid,ename,basicSalary,year,month,bonus,netSalary) as
select id,concat(fname,lname),basicSalary,year,month,bonus,netSal
from employee e, permanentemp p
where e.id = p.peid;

create view temporaryEmployee(eid,ename,year,month,hrate,hours,netSalary) as
select id,concat(fname,lname),year,month,otRate,hours,totalSal
from employee e, tempemployee t
where e.id = t.teid;


create view absentatten(eid,year,month,absentcount) as
select atd_eid,year(presentdate),month(presentdate),count(atten) 
from attendance
where atten='Absent'
group by atd_eid;

create view presentatten(eid,year,month,absentcount) as
select atd_eid,year(presentdate),month(presentdate),count(atten)
from attendance
where atten='present'
group by atd_eid;
