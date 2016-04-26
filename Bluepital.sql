use master;
drop database hospital;
create database hospital;
use hospital;
create table Supplier(
	Supplier_ID			nvarchar(20) not null primary key,
	Supplier_Name		nvarchar(30) not null,
	ContactFirstName	nvarchar(30) not null,
	ContactLastName		nvarchar(30) not null,
	Phone				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	Address				nvarchar(20) not null,
	City				nvarchar(15) not null,
	State				nvarchar(10) not null
);


create table Medicine(
	Medince_ID 			nvarchar(20) not null primary key,
	Name 				nvarchar(50) not null,
	Supplier_ID 		nvarchar(20) not null foreign key(Supplier_ID) references Supplier(Supplier_ID),
	UnitPrice 			money not null check(UnitPrice >= 0),  --changed by aakruthi 
	AvailableQuantity	int not null,--changed by aakruthi
	Description 		text
);

create table Department(
	DepartmentID		nvarchar(20) not null primary key,--changed by aakruthi
	Name 				nvarchar(50) not null
);


create table Insurance(
	Insurance_ID 			nvarchar(20) not null primary key,
	Name 				nvarchar(50) not null,
	Total 				money not null check(Total > 0),
	Date 				date not null,
	Description 			text
);

create table Bed(
	Bed_ID 				nvarchar(20) not null primary key,
	Building 			nvarchar(50) not null,
	Floor 				int not null,
	Used 				bit
);

create table Doctor(
	Doctor_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age				int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID			nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID 			nvarchar(20) --changed by aakruthi
);

create table Nurse(
	Nurse_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age					int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID			nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID			nvarchar(20) --changed by aakruthi
);


create table Patient(
	Patient_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	Age					int not null check(Age >= 0),
	Statues				char(3) not null check(Statues = 'I' or Statues = 'II' or Statues = 'III' or Statues = 'IV'),
	Phone				nvarchar(15) not null,
	Email 				nvarchar(20) not null,
	DepartmentID			nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
	Bed_ID				nvarchar(20) not null foreign key(Bed_ID) references Bed(Bed_ID),
	Insurance_ID			nvarchar(20) not null foreign key(Insurance_ID) references Insurance(Insurance_ID)
);

create table Bill(
	Bill_ID				nvarchar(20) not null primary key,
	Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	BillTotal 			money,
	PaymentTotal			money,
	InsuranceTotal			money,
	PaymentDate			date
);

create table Bill_Detail(
	BillDetail_ID		        nvarchar(20) not null primary key,
	Bill_ID 			nvarchar(20) not null foreign key(Bill_ID) references Bill(Bill_ID),
	Medince_ID			nvarchar(20) foreign key(Medince_ID) references Medicine(Medince_ID),/*changed by aakruthi.removed not null*/
	Type				nvarchar(20),
	Total 				money,
	Date 				date
);

create table Contract(
	Contract_ID			nvarchar(20) not null primary key,
	Supplier_ID			nvarchar(20) not null foreign key(Supplier_ID) references Supplier(Supplier_ID),
	Medince_ID			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Quantity			int not null check(Quantity > 0),--changed by aakruthi
	UnitPrice		        money not null check(UnitPrice >= 0),--changed by aakruthi
	Invoice				as (UnitPrice*Quantity),--changed by aakruthi
	Date			        datetime not null default getdate()--changed by aakruthi
);

create table TreatmentTeam(
	Patient_ID			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	Doctor_ID			nvarchar(20) not null foreign key(Doctor_ID) references Doctor(Doctor_ID)
);

create table MedicineUseRecord(
	MUR_ID				nvarchar(20) not null primary key,
	Medince_ID 			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Doctor_ID			nvarchar(20) not null foreign key(Doctor_ID) references Doctor(Doctor_ID),
	Nurse_ID 			nvarchar(20) not null foreign key(Nurse_ID) references Nurse(Nurse_ID),
	Quantity			int not null check(Quantity > 0),--changed by aakruthi
	Patient_ID			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	UsedDate			date not null
);


create table Health_Attribute(
	Health_ID 			nvarchar(20) not null primary key,
	Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	Systolic_BP 		nvarchar(30) not null,
	Diastolic_BP 		nvarchar(30) not null,
	BloodSugar 			nvarchar(30) not null,
	Pulse 				nvarchar(30) not null,
	Date 				date
);

create table Register(
	Register_ID 		        nvarchar(20) not null primary key,
	Name 				nvarchar(50) not null,
	Doctor_ID 			nvarchar(20) not null foreign key(Doctor_ID) references Doctor(Doctor_ID),
	Date 				date not null
);

create table NurseSchedule(
	Schedule_ID 			nvarchar(20) not null primary key,
	Nurse_ID 			nvarchar(20) not null foreign key(Nurse_ID) references Nurse(Nurse_ID),
	StartTime			time not null,
	EndTime 			time not null,
	Date                date not null,
	Bed_ID 				nvarchar(20) foreign key(Bed_ID) references Bed(Bed_ID)
);

insert supplier values 
(0,'TEST0','TESTF0','TESTL0','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(1,'TEST1','TESTF1','TESTL1','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(2,'TEST2','TESTF2','TESTL2','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(3,'TEST3','TESTF3','TESTL3','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(4,'TEST4','TESTF4','TESTL4','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(5,'TEST5','TESTF5','TESTL5','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(6,'TEST6','TESTF6','TESTL6','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(7,'TEST7','TESTF7','TESTL7','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(8,'TEST8','TESTF8','TESTL8','123123123','123123@123.com','TESTAddress','TESTCity','TESTState'),
(9,'TEST9','TESTF9','TESTL9','123123123','123123@123.com','TESTAddress','TESTCity','TESTState');

insert Medicine values
(0,'TEST0',0,'12','120','TESTINFO'),
(1,'TEST1',0,'12','120','TESTINFO'),
(2,'TEST2',1,'12','120','TESTINFO'),
(3,'TEST3',2,'12','120','TESTINFO'),
(4,'TEST4',2,'12','120','TESTINFO'),
(5,'TEST5',3,'12','120','TESTINFO'),
(6,'TEST6',4,'12','120','TESTINFO'),
(7,'TEST7',5,'12','120','TESTINFO'),
(8,'TEST8',6,'12','120','TESTINFO'),
(9,'TEST9',6,'12','120','TESTINFO');

insert Department values
(0,'TEST0'),
(1,'TEST1'),
(2,'TEST2'),
(3,'TEST3'),
(4,'TEST4'),
(5,'TEST5'),
(6,'TEST6'),
(7,'TEST7'),
(8,'TEST8'),
(9,'TEST9');

insert Insurance values
(0,'TEST0',100,'2016/05/01','TESTINFO'),
(1,'TEST1',200,'2016/05/02','TESTINFO'),
(2,'TEST2',300,'2016/05/03','TESTINFO'),
(3,'TEST3',400,'2016/05/03','TESTINFO'),
(4,'TEST4',500,'2016/05/04','TESTINFO'),
(5,'TEST5',600,'2016/05/05','TESTINFO'),
(6,'TEST4',500,'2016/05/04','TESTINFO'),
(7,'TEST4',500,'2016/05/04','TESTINFO'),
(8,'TEST4',500,'2016/05/04','TESTINFO'),
(9,'TEST4',500,'2016/05/04','TESTINFO');

insert Bed values
(0,'1',2,1),
(1,'1',1,0),
(2,'2',1,0),
(3,'2',3,1),
(4,'3',4,1),
(5,'2',3,1),
(6,'2',3,1),
(7,'2',3,1),
(8,'2',3,1),
(9,'2',3,1);

insert Doctor values
(0,'TESTF0','TESTL0','Doc',30,'M',0,'123123123','TEST0@test',null),
(1,'TESTF1','TESTL1','Doc',31,'F',0,'123123123','TEST0@test',0),
(2,'TESTF2','TESTL2','Doc',31,'M',1,'123123123','TEST0@test',null),
(3,'TESTF3','TESTL3','Doc',34,'F',1,'123123123','TEST0@test',2),
(4,'TESTF4','TESTL4','Doc',34,'M',1,'123123123','TEST0@test',2),
(5,'TESTF5','TESTL5','Doc',36,'M',2,'123123123','TEST0@test',null),
(6,'TESTF6','TESTL6','Doc',37,'F',2,'123123123','TEST0@test',5),
(7,'TESTF7','TESTL7','Doc',41,'F',1,'123123123','TEST0@test',5),
(8,'TESTF8','TESTL8','Doc',29,'M',3,'123123123','TEST0@test',5),
(9,'TESTF9','TESTL8','Doc',31,'M',4,'123123123','TEST0@test',5);

insert Nurse values
(0,'TESTF0','TESTL0','MISS',30,'M',0,'123123123','TEST0@test',null),
(1,'TESTF1','TESTL1','MISS',31,'F',0,'123123123','TEST0@test',0),
(2,'TESTF2','TESTL2','MISS',31,'M',1,'123123123','TEST0@test',null),
(3,'TESTF3','TESTL3','MISS',34,'F',1,'123123123','TEST0@test',2),
(4,'TESTF4','TESTL4','MISS',34,'M',1,'123123123','TEST0@test',2),
(5,'TESTF5','TESTL5','MISS',36,'M',2,'123123123','TEST0@test',null),
(6,'TESTF6','TESTL6','MISS',37,'F',2,'123123123','TEST0@test',5),
(7,'TESTF7','TESTL7','MISS',41,'F',1,'123123123','TEST0@test',5),
(8,'TESTF8','TESTL8','MISS',29,'M',3,'123123123','TEST0@test',5),
(9,'TESTF9','TESTL9','MISS',31,'M',4,'123123123','TEST0@test',5);

insert Patient values
(0,'TESTF0','TESTL0','M',20,'I','123123123','TEST@test',0,0,0),
(1,'TESTF1','TESTL1','F',89,'II','123123123','TEST@test',1,1,1),
(2,'TESTF2','TESTL2','F',34,'III','123123123','TEST@test',1,2,2),
(3,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(4,'TESTF4','TESTL4','M',26,'IV','123123123','TEST@test',3,4,4),
(5,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(6,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(7,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(8,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(9,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3);

insert Bill values
(1,1,344,234,234,'2014/02/01'),
(2,2,345,200,200,'2014/02/01'),
(3,3,345,200,200,'2014/02/01'),
(4,4,765,500,500,'2016/04/11'),
(5,5,345,300,300,'2015/03/02'),
(6,6,345,300,300,'2016/04/17'),
(7,7,345,300,300,'2015/02/02'),
(8,8,345,300,300,'2016/01/01'),
(9,9,345,300,300,'2016/01/11');

insert Bill_Detail values
(1,1,null,'Doc',100,'2016/02/10'),
(2,2,null,'Doc',100,'2015/12/12'),
(3,2,1,'Medicine',200,'2016/01/12'),
(4,3,1,'Medicine',300,'2016/03/20'),
(5,3,1,'Medicine',400,'2015/12/12'),
(6,3,1,'Medicine',500,'2016/02/12'),
(7,4,1,'Medicine',100,'2016/03/12'),
(8,1,1,'Medicine',200,'2016/04/12'),
(9,4,1,'Medicine',300,'2016/03/12'),
(10,1,null,'Room',500,'2016/01/13');

insert contract
values (1,1,1,5,2,10),
(2,2,2,5,3,15),
(3,3,3,5,4,20),
(4,4,4,5,5,25),
(5,5,5,5,6,30),
(6,6,6,5,1,5),
(7,7,7,5,2,10),
(8,8,8,5,3,15),
(9,9,9,5,4,20),
(10,0,0,5,5,25);


insert TreatmentTeam
values (1,1),
(2,2),
(2,3),
(3,4),
(4,5),
(5,6),
(6,7),
(7,8),
(8,9),
(9,0);


insert MedicineUseRecord
values (1,1,1,1,5,1,'2016/01/01'),
(2,2,2,2,5,2,'2016/01/02'),
(3,3,3,3,5,3,'2016/01/03'),
(4,4,4,4,5,4,'2016/01/04'),
(5,5,5,5,5,5,'2016/01/05'),
(6,6,6,6,5,6,'2016/01/06'),
(7,7,7,7,5,7,'2016/01/07'),
(8,8,8,8,5,8,'2016/01/08'),
(9,9,9,9,5,9,'2016/01/09'),
(10,0,0,0,5,0,'2016/01/10');

insert Health_Attribute
values (1,2,70,70,80,60,'2016-01-01'),
(2,3,100,70,80,60,'2016-02-01'),
(3,4,120,70,80,60,'2016-03-01'),
(4,5,150,70,80,60,'2016-04-01'),
(5,6,80,70,80,100,'2016-05-01'),
(6,7,90,70,80,60,'2016-06-01'),
(7,8,100,80,80,60,'2016-07-01'),
(8,9,110,70,80,70,'2016-08-01'),
(9,0,150,90,80,80,'2016-09-01'),
(10,1,80,100,80,90,'2016-10-01');



insert register
values (1,'xyz',1,'2016-01-01'),
(2,'ABC',2,'2016-01-02'),
(3,'DEF',3,'2016-01-03'),
(4,'GHI',4,'2016-01-04'),
(5,'JKL',5,'2016-01-05'),
(6,'MNO',6,'2015-01-01'),
(7,'PQR',7,'2015-01-02'),
(8,'STU',8,'2015-01-03'),
(9,'VWX',9,'2015-01-04'),
(10,'ADA',2,'2015-01-05');

insert NurseSchedule
values (1,1,'6:00:00','15:00:00',1),
(2,2,'6:00:00','15:00:00',2),
(3,3,'6:00:00','15:00:00',3),
(4,4,'6:00:00','15:00:00',4),
(5,5,'6:00:00','15:00:00',5),
(6,1,'15:00:00','21:00:00',1),
(7,2,'15:00:00','21:00:00',2),
(8,1,'21:00:00','6:00:00',1),
(9,2,'21:00:00','6:00:00',2),
(10,3,'21:00:00','6:00:00',3);

select * from Contract;



select * from NurseSchedule;
delete NurseSchedule where Schedule_ID = 2;
insert NurseSchedule values
(1,1,'06:00:00','15:00:00','2016/01/01',1),
(2,2,'15:00:00','23:59:00','2016/01/01',1),
(3,3,'00:00:00','06:00:00','2016/01/02',1),
(4,4,'06:00:00','15:00:00','2016/01/01',2),
(5,5,'15:00:00','23:59:00','2016/01/01',2),
(6,6,'00:00:00','06:00:00','2016/01/02',2),
(7,7,'06:00:00','15:00:00','2016/01/01',3),
(8,8,'15:00:00','23:59:00','2016/01/01',3),
(9,9,'00:00:00','06:00:00','2016/01/02',3),
(10,1,'06:00:00','15:00:00','2016/01/02',1),
(11,2,'15:00:00','23:59:00','2016/01/02',1),
(12,3,'00:00:00','06:00:00','2016/01/03',1),
(13,4,'06:00:00','15:00:00','2016/01/02',2),
(14,5,'15:00:00','23:59:00','2016/01/02',2),
(15,6,'00:00:00','06:00:00','2016/01/03',2),
(16,7,'06:00:00','15:00:00','2016/01/02',3),
(17,8,'15:00:00','23:59:00','2016/01/02',3),
(18,9,'00:00:00','06:00:00','2016/01/03',3);
select * from NurseSchedule

insert NurseSchedule values
(11,2,'15:00:00','23:00:00',4);

if object_id('dbo.NurseSchedule','U') is not null
drop table dbo.NurseSchedule;

/*Query1:Using functions on nurse schedule table*/
create function fnDateRange1
    (@NurseDateMin date,
	   @NurseDateMax date)
returns table

return
      (select Nurse_ID,StartTime,EndTime,Bed_ID 
	  from NurseSchedule where Date between @NurseDateMin and @NurseDateMax)


select * from dbo.fnDateRange1('2016-01-01','2016-01-02')
/*Query1:Using function and retrieving nurse information
for ex: details of nurse who is taking care of bed in morning shift*/
create function fnShiftTime
    (@NurseStartTime time,
	   @NurseEndTime time)
returns table

return
      (select Nurse_ID,Date,Bed_ID 
	  from NurseSchedule where StartTime=@NurseStartTime and EndTime=@NurseEndTime)

select N.Nurse_ID,FirstName,LastName,Date,Bed_ID from Nurse N join
fnShiftTime('06:00:00','15:00:00') S on  N.Nurse_ID = S.Nurse_ID

/*Query2:Stored Procedure on Health attribute table*/
/*Retrieve the health record of patient whose patient_id is 5 along with the details of doctor assigned to him using stored procedure*/

select * from Health_Attribute;
select * from Patient;
select * from TreatmentTeam;
select * from doctor;

create procedure dbo.PatientDoctorDetails
@PatientID nvarchar(20)
AS
BEGIN
select P.Patient_ID,P.FirstName,P.LastName,D.Doctor_ID,D.FirstName,D.LastName,Diastolic_BP,
BloodSugar,Pulse from Health_Attribute H 
inner join Patient P on H.Patient_ID = P.Patient_ID inner join TreatmentTeam T
on P. Patient_ID = T.Patient_ID inner join Doctor D on T.Doctor_ID = D.Doctor_ID
where P.Patient_ID = @PatientID
END
GO
EXEC dbo.PatientDoctorDetails 5;

/*Function on supplier table*/
/*Query3:Number of orders given in January month along with suppliers details*/
select * from Supplier;
select * from Contract;

create function fnOrder
   (@Ordermonth int)
   Returns table

return
(select S.Supplier_ID,Supplier_Name,Contract_ID,C.Medince_ID,Quantity from
Supplier S inner join Contract C on S.Supplier_ID = C.Supplier_ID where 
Month(Date)=@Ordermonth)


select * from fnOrder(1);

/*Recursive CTE on Doctor table*/

/*Query4:*/

select * from Doctor;
with Doctors
AS
(
select Doctor_ID,LastName,FirstName,convert(nvarchar(30),'None') AS 'ReportsToLastName',
convert(nvarchar(30),'None') AS 'ReportsToFirstName'
from Doctor where ReportToID IS NULL

UNION ALL

select D1.Doctor_ID,D1.LastName,D1.FirstName,D2.LastName AS 'ReportsToLastName',
D2.firstname AS 'ReportsToFirstName' from Doctor D1 inner join Doctor D2
on D1.ReportToID = D2.Doctor_ID
)
select LastName,FirstName,ReportsToLastName,ReportsToFirstName from Doctors;

/*Using Join*/

select D1.LastName AS 'LastName' ,D1.firstname AS 'FirstName',
D2.LastName AS 'ReportsToLastName',D2.firstname AS 'ReportsToFirstName'
from Doctor D1 left join Doctor D2
on D1.ReportToID = D2.Doctor_ID;

/*Using trigger*/
/*Query 5*/
select * from supplier;

if object_id (N'trgSupplier',N'TR') is not null
drop trigger trgSupplier;
GO

create trigger trgSupplier
on Supplier
after delete,insert,update
as
begin
 if @@rowcount = 0
 return
 select count(*) as InsertedCount from Inserted;
 select count(*) as DeletedCount from deleted;
 end;

 /*perform delete,insert and update actions*/
 alter table Supplier disable trigger ALL

 delete Supplier where Supplier_ID = 11;
 select * from Supplier;


 insert into Supplier values (11,'TEST11','TESTF11','TESTL11','123123123','123123@123.com','TESTAddress','TESTCity','TESTState')
 insert into Supplier values (12,'TEST12','TESTF12','TESTL12','123123123','123123@123.com','TESTAddress','TESTCity','TESTState')

 update Supplier set Supplier_Name = 'XYZ' where Supplier_ID = 11;
 delete Supplier where Supplier_ID = 11;







 







				
			



        



