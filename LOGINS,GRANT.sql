/*Stored procedure or function on nurseschedule table*/
/*If nurse enter her id and password then if she wants to check her shift timings*/
use hospital;
select * from Nurse;
select * from NurseSchedule;
create proc dbo.NurseTimings
@Id nvarchar(20)
AS
select Nurse.Nurse_ID,FirstName,LastName,StartTime,EndTime,Date
from Nurse inner join NurseSchedule on Nurse.Nurse_ID = NurseSchedule.Nurse_ID
where Nurse.Nurse_ID = @Id;

EXEC dbo.NurseTimings 5;


/* Using functions*/
create function fnnurseshifttime
   (@Id nvarchar(20))
   returns table

return
      (select Nurse.Nurse_ID,FirstName,LastName,StartTime,EndTime,Date
from Nurse inner join NurseSchedule on Nurse.Nurse_ID = NurseSchedule.Nurse_ID
where Nurse.Nurse_ID = @Id)

select * from
fnnurseshifttime(6);
/*If nurse wants to check the health attributes of patient along with his details*/
use hospital;
select * from Health_Attribute;
create proc dbo.ChkPatientHealthDetails
@Id nvarchar(20)
AS
select Patient.Patient_ID,FirstName,LastName,Systolic_BP,Diastolic_BP,BloodSugar,Pulse
from Health_Attribute inner join Patient on Patient.Patient_ID=Health_Attribute.Patient_ID
where Patient.Patient_ID = @Id;

EXEC dbo.ChkPatientHealthDetails 5;


/*Using Grant permissions*/
/*Giving grant permission for doctor on patient table and on health attribute table*/

CREATE LOGIN TESTF0 WITH PASSWORD = 'abc@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF1 WITH PASSWORD = 'def@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF2 WITH PASSWORD = 'ghi@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF3 WITH PASSWORD = 'jkl@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF4 WITH PASSWORD = 'mno@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF5 WITH PASSWORD = 'pqr@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF6 WITH PASSWORD = 'stu@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF7 WITH PASSWORD = 'vwx@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF8 WITH PASSWORD = 'xyz@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN TESTF9 WITH PASSWORD = 'adc@12345',
DEFAULT_DATABASE = hospital;

create user TESTF0 for login TESTF0 with Default_Schema = dbo;
create user TESTF1 for login TESTF1 with Default_Schema = dbo;
create user TESTF2 for login TESTF2 with Default_Schema = dbo;
create user TESTF3 for login TESTF3 with Default_Schema = dbo;
create user TESTF4 for login TESTF4 with Default_Schema = dbo;
create user TESTF5 for login TESTF5 with Default_Schema = dbo;
create user TESTF6 for login TESTF6 with Default_Schema = dbo;
create user TESTF7 for login TESTF7 with Default_Schema = dbo;
create user TESTF8 for login TESTF8 with Default_Schema = dbo;
create user TESTF9 for login TESTF9 with Default_Schema = dbo;

Grant insert,select,update,delete on Patient to TESTF0,TESTF1,TESTF2,TESTF3,TESTF4,TESTF5,TESTF6,TESTF7,TESTF8,TESTF9;
Grant select on Health_Attribute to TESTF0,TESTF1,TESTF2,TESTF3,TESTF4,TESTF5,TESTF6,TESTF7,TESTF8,TESTF9;

select * from Nurse;
Update Nurse SET FirstName = 'NURSE0' where FirstName = 'TESTF0';
Update Nurse SET FirstName = 'NURSE1' where FirstName = 'TESTF1';
Update Nurse SET FirstName = 'NURSE2' where FirstName = 'TESTF2';
Update Nurse SET FirstName = 'NURSE3' where FirstName = 'TESTF3';
Update Nurse SET FirstName = 'NURSE4' where FirstName = 'TESTF4';
Update Nurse SET FirstName = 'NURSE5' where FirstName = 'TESTF5';
Update Nurse SET FirstName = 'NURSE6' where FirstName = 'TESTF6';
Update Nurse SET FirstName = 'NURSE7' where FirstName = 'TESTF7';
Update Nurse SET FirstName = 'NURSE8' where FirstName = 'TESTF8';
Update Nurse SET FirstName = 'NURSE9' where FirstName = 'TESTF9';

CREATE LOGIN NURSE0 WITH PASSWORD = 'abc@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE1 WITH PASSWORD = 'def@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE2 WITH PASSWORD = 'ghi@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE3 WITH PASSWORD = 'jkl@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE4 WITH PASSWORD = 'mno@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE5 WITH PASSWORD = 'pqr@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE6 WITH PASSWORD = 'stu@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE7 WITH PASSWORD = 'vwx@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE8 WITH PASSWORD = 'xyz@12345',
DEFAULT_DATABASE = hospital;
CREATE LOGIN NURSE9 WITH PASSWORD = 'adc@12345',
DEFAULT_DATABASE = hospital;

create user NURSE0 for login NURSE0 with Default_Schema = dbo;
create user NURSE1 for login NURSE1 with Default_Schema = dbo;
create user NURSE2 for login NURSE2 with Default_Schema = dbo;
create user NURSE3 for login NURSE3 with Default_Schema = dbo;
create user NURSE4 for login NURSE4 with Default_Schema = dbo;
create user NURSE5 for login NURSE5 with Default_Schema = dbo;
create user NURSE6 for login NURSE6 with Default_Schema = dbo;
create user NURSE7 for login NURSE7 with Default_Schema = dbo;
create user NURSE8 for login NURSE8 with Default_Schema = dbo;
create user NURSE9 for login NURSE9 with Default_Schema = dbo;

Grant select on Health_Attribute to NURSE0,NURSE1,NURSE2,NURSE3,NURSE4,NURSE5,NURSE6,NURSE7,NURSE8,NURSE9;

/*creating view on patient table*/
/* If we want to grant part of information of patient table to Nurse.Then we can create a view on patient table and then it can be
viewed by nurse*/
select * from patient;
select * from Nurse;
create view patient_data AS
select Patient_ID,FirstName,LastName,Gender,Bed_ID
from Patient

select * from patient_data;

grant select on patient_data to NURSE0,NURSE1,NURSE2,NURSE3,NURSE4,NURSE5,NURSE6,NURSE7,NURSE8,NURSE9;



/* deleted not null for doctor_id and nurse_id as one of them only will be giving the medicine to patient  */
create table MedicineUseRecord(
	MUR_ID				nvarchar(20) not null primary key,
	Medince_ID 			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Doctor_ID			nvarchar(20) foreign key(Doctor_ID) references Doctor(Doctor_ID),
	Nurse_ID 			nvarchar(20) foreign key(Nurse_ID) references Nurse(Nurse_ID),
	Quantity			int not null check(Quantity > 0),--changed by aakruthi
	Patient_ID			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	UsedDate			date not null
);
insert MedicineUseRecord
values (1,1,1,null,5,1,'2016/01/01'),
(2,2,null,2,5,2,'2016/01/02'),
(3,3,3,null,5,3,'2016/01/03'),
(4,4,null,4,5,4,'2016/01/04'),
(5,5,null,5,5,5,'2016/01/05'),
(6,6,6,null,5,6,'2016/01/06'),
(7,7,7,null,5,7,'2016/01/07'),
(8,8,null,8,5,8,'2016/01/08'),
(9,9,null,9,5,9,'2016/01/09'),
(10,0,8,null,5,0,'2016/01/10');

/* Given identity property to bill_id so the id gets auto generated and inserted values accordingly and in bill_detail
changed the bill_id to int */
create table Bill(
	Bill_ID				int identity(1,1) not null primary key,
	Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	BillTotal 			money,
	PaymentTotal			money,
	InsuranceTotal			money,
	PaymentDate			date
);
insert Bill values
(1,344,234,234,'2014/02/01'),
(2,345,200,200,'2014/02/01'),
(3,345,200,200,'2014/02/01'),
(4,765,500,500,'2016/04/11'),
(5,345,300,300,'2015/03/02'),
(6,345,300,300,'2016/04/17'),
(7,345,300,300,'2015/02/02'),
(8,345,300,300,'2016/01/01'),
(9,345,300,300,'2016/01/11');


create table Bill_Detail(
	BillDetail_ID		nvarchar(20) not null primary key,
	Bill_ID 			int not null foreign key(Bill_ID) references Bill(Bill_ID),
	Medince_ID			nvarchar(20) foreign key(Medince_ID) references Medicine(Medince_ID),/*changed by aakruthi.removed not null*/
	Type				nvarchar(20),
	Total 				money,
	Date 				date
);


 

 

