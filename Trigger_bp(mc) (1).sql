--use master
--create database hospital_testdb;

use hospital_testdb;

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
	UnitPrice 			money not null check(UnitPrice >= 0), 
	AvailableQuantity	int not null,
	Description 		text
);

create table Department(
	DepartmentID		nvarchar(20) not null primary key,
	Name 				nvarchar(50) not null
);


create table Insurance(
	Insurance_ID 		nvarchar(20) not null primary key,
	Name 				nvarchar(50) not null,
	Total 				money not null check(Total > 0),
	Date 				date not null,
	Description 		text
);

create table Bed(
	Bed_ID 				nvarchar(20) not null primary key,
	Building 			nvarchar(50) not null,
	Floor 				int not null,
	Used 				bit
);

create table Patient( --the column name statues should have been status but status is a keyword so i have made it pstatus (mayukh)
	Patient_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	Age					int not null check(Age >= 0),
	PStatus				char(3) not null check(PStatus = 'I' or PStatus = 'II' or PStatus = 'III' or PStatus = 'IV'),
	Phone				nvarchar(15) not null,
	Email 				nvarchar(20) not null,
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),
	Bed_ID				nvarchar(20) not null foreign key(Bed_ID) references Bed(Bed_ID),
	Insurance_ID		nvarchar(20) not null foreign key(Insurance_ID) references Insurance(Insurance_ID)
);



create table Bill(
	Bill_ID				nvarchar(20) not null primary key,
	Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	BillTotal 			money,
	PaymentTotal		money,
	InsuranceTotal		money,
	PaymentDate			date
);

create table Bill_Detail(
	BillDetail_ID		nvarchar(20) not null primary key,
	Bill_ID 			nvarchar(20) not null foreign key(Bill_ID) references Bill(Bill_ID),
	Medince_ID			nvarchar(20) foreign key(Medince_ID) references Medicine(Medince_ID),
	Type				nvarchar(20),
	Total 				money,
	Date 				date
);

create table Doctor(
	Doctor_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age					int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID 			nvarchar(20) 
);

create table Nurse(
	Nurse_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age					int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID			nvarchar(20) 
);


create table MedicineUseRecord(
	MUR_ID				nvarchar(20) not null primary key,
	Medince_ID 			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Doctor_ID			nvarchar(20) not null foreign key(Doctor_ID) references Doctor(Doctor_ID),
	Nurse_ID 			nvarchar(20) not null foreign key(Nurse_ID) references Nurse(Nurse_ID),
	Quantity			int not null check(Quantity > 0),
	Patient_ID			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	UsedDate			date not null
);

create table Health_Attribute(
	--Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	Patient_ID 			nvarchar(20),
	BloodSugar 			float not null,
	Pulse 				float not null,
	Systolic_BP 		float not null,
	Diastolic_BP 		float not null,
	Temperature         float not null,
	RecordDatetime 		nvarchar(max) not null
);
drop table health_attribute;
create table DevicePatient(
	DeviceID			nvarchar(20) not null primary key,
	P_ID 				nvarchar(20) not null foreign key(P_ID) references Patient(Patient_ID)
);

---value insertions
--had to insert values in the supplier table although the trigger doesn't require it because without values being inserted into this table 
--values in the medicine table can't be inserted because of foreign key constraints
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
(4,'TEST4',2,'13','120','TESTINFO'),
(5,'TEST5',3,'14','120','TESTINFO'),
(6,'TEST6',4,'12','120','TESTINFO'),
(7,'TEST7',5,'12','120','TESTINFO'),
(8,'TEST8',6,'12','120','TESTINFO'),
(9,'TEST9',6,'12','120','TESTINFO');

--values inserted in department, insurance, bed tables since without them values can't be inserted in patients table
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


--values inserted in patient because without it values can't be inserted in bill tables
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
(9,'TESTF3','TESTL3','M',45,'I','123123123','TEST@test',2,3,3),
(10,'TESTF10','TESTL10','M',10,'I','123123123','TEST@test',2,3,3);

--values inserted in bill values because without it values can't be inserted in bill_details
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

--values inserted in doctor and nurse table because without them values can't be inserted into the medicineuserecord table
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

insert MedicineUseRecord values 
(1,1,1,1,5,1,'2016/01/01'),
(2,2,2,2,5,2,'2016/01/02'),
(3,3,3,3,5,3,'2016/01/03'),
(4,4,4,4,5,4,'2016/01/04'),
(5,5,5,5,5,5,'2016/01/05'),
(6,6,6,6,5,6,'2016/01/06'),
(7,7,7,7,5,7,'2016/01/07'),
(8,8,8,8,5,8,'2016/01/08'),
(9,9,9,9,5,9,'2016/01/09'),
(10,0,0,0,5,0,'2016/01/10');

insert DevicePatient values
('D1','0'),
('D2','2'),
('D3','3'),
('D4','4'),
('D5','5'),
('D6','6'),
('D7','7'),
('D8','8'),
('D9','9'),
('D10','1');

 --all the required value insertions have been done.

 --Now, trigger creation.

 --The trigger will be working with the medicineuserecord table, medicine table and the bill_detail table

 --whenever a medicine is ordered for a patient the record is inserted into the medicineuserecord table and 
 --when that happens a corresponding record should be inserted into the bill_details table
 --for inserting the cost in the bill_details table the unit_cost from the medicine table and the quantity from the medicineuserecord
 --table should have to be multiplied first and then the data is inserted into the bill_details table.
 --the available_qty in the medicine also has to be changed accordingly because if the avaialble_qty before the order had been placed
 --for the patient was 20 and qty of a medicine ordered is 2 then the available qty becomes 20-2=18

 --This trigger takes care of all the above mentioned things
 -- NOTE : AFTER EACH INSERTION INTO THE MEDICINEUSERECORD THE TRIGGER HAS TO BE DROPPED AND RE CREATED...IT IS BECAUSE THE VALUES ARE HARD CODED..ONCE INTEGRATION WITH FRONT END IS DONE WE WONT HAVE THIS PROBLEM

declare @M_ID int;
declare @Ord_Qty int;

go
CREATE PROCEDURE Trig_SP(@M_ID int,@Ord_qty int)
AS
BEGIN TRY
  BEGIN TRAN;
	declare @q int;
	set @q=(select availablequantity from medicine where Medince_ID=@M_ID)
	print 'quantity available : '
	print @q
	if(@q=0)
		print 'unavailable'
	else
	begin
		declare @unit_pr money;
		print 'unit price : '
		print @unit_pr
		set @unit_pr=(select unitprice from medicine where Medince_ID=@M_ID)
		insert into bill_detail (BillDetail_ID,Bill_ID, Medince_ID,Type,Total,Date) values
		(13,3,@M_ID,'Medicine',@Ord_qty*@unit_pr,'2011/02/08')
		update medicine set availablequantity=availablequantity-@Ord_qty where Medince_ID=@M_ID
	end
  COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
END CATCH
go

CREATE TRIGGER mur_trigger
ON medicineuserecord
AFTER insert
AS
print 'TRIGGER FIRED'
BEGIN TRY
  BEGIN TRAN;
    exec Trig_SP @M_ID=4, @Ord_qty=3;
  COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
END CATCH;

insert into medicineuserecord(MUR_ID,Medince_ID,Doctor_ID,Nurse_ID,Quantity,Patient_ID,UsedDate)values
(14,4,7,5,3,7,'2016/02/03') ---medicine id, quantity ordered can't be hard coded like this

--delete from MedicineUseRecord where MUR_ID=14
--drop trigger mur_trigger;

if object_id('dbo.Trig_SP') is not null
begin
	drop procedure Trig_SP;
	print 'Stored procedure Trig_SP dropped'
end
else
begin
	print 'Stored Procedure Trig_SP does not exist'
end

if object_id('dbo.mur_trigger') is not null
begin
	drop trigger mur_trigger;
	print 'Trigger mur_trigger dropped'
end
else
begin
	print 'Trigger mur_trigger does not exist'
end

select * from bill_detail;
select * from medicine;
select * from MedicineUseRecord;