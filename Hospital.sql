--author:XD
--Date: 03/26/2016
create database Hospital

use Hospital;

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

create table Doctor(
	Doctor_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age					int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID 			nvarchar(20), --changed by aakruthi
	password			nvarchar(256) not null
);

create table Nurse(
	Nurse_ID			nvarchar(20) not null primary key,
	FirstName 			nvarchar(30) not null,
	LastName 			nvarchar(30) not null,
	Title				nvarchar(20) not null,
	Age					int not null check(Age >= 0),
	Gender				char(1) not null check(Gender = 'F' or Gender = 'M'),
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
	Phone 				nvarchar(15) not null,
	Email				nvarchar(20) not null,
	ReportToID			nvarchar(20), --changed by aakruthi
	password			nvarchar(256) not null
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
	DepartmentID		nvarchar(20) not null foreign key(DepartmentID) references Department(DepartmentID),--changed by aakruthi
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
	Medince_ID			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Type				nvarchar(20),
	Total 				money,
	Date 				date
);

create table Contract(
	Contract_ID			nvarchar(20) not null primary key,
	Supplier_ID			nvarchar(20) not null foreign key(Supplier_ID) references Supplier(Supplier_ID),
	Medince_ID			nvarchar(20) not null foreign key(Medince_ID) references Medicine(Medince_ID),
	Quantity			int not null check(Quantity > 0),--changed by aakruthi
	UnitPrice		    money not null check(UnitPrice >= 0),--changed by aakruthi
	Invoice				as (UnitPrice*Quantity),--changed by aakruthi
	Date			    datetime not null default getdate(),--changed by aakruthi
	ArriveDate			datetime
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
	UsedDate			datetime not null default getdate()
);


create table Health_Attribute(
	Health_ID 			nvarchar(20) not null primary key,
	Patient_ID 			nvarchar(20) not null foreign key(Patient_ID) references Patient(Patient_ID),
	Systolic_BP 		nvarchar(30) not null,
	Diastolic_BP 		nvarchar(30) not null,
	BloodSugar 			nvarchar(30) not null,
	Pulse 				nvarchar(30) not null,
	Date 				datetime  not null default getdate()
);

create table Register(
	Register_ID 		nvarchar(20) not null primary key,
	FirstName 			nvarchar(50) not null,
	LastName 			nvarchar(50) not null,
	Doctor_ID 			nvarchar(20) not null foreign key(Doctor_ID) references Doctor(Doctor_ID),
	Date 				date not null 
);

create table NurseSchedule(
	Schedule_ID 		nvarchar(20) not null primary key,
	Nurse_ID 			nvarchar(20) not null foreign key(Nurse_ID) references Nurse(Nurse_ID),
	StartTime			datetime not null,
	EndTime 			datetime not null,
	Bed_ID 				nvarchar(20) foreign key(Bed_ID) references Bed(Bed_ID)
);
