--author: XD
use Hospital


go
create trigger RegisterToPatient
on Patient
after insert
as
begin
delete Register where Register_ID = (select Patient_ID from inserted)
end

go
create function GetRegisterInfor(@Doctor_ID nvarchar(20),@Date date)
returns table
as return(
select * from Register where Doctor_ID = @Doctor_ID and Date = @Date
)

go
create trigger PatientInsert
on Patient
instead of insert
as
begin
begin transaction
declare @Used bit
set @Used = (select Used from Bed where Bed_ID = (select Bed_ID from inserted))
if @Used = 1
	begin
	raiserror('Bed used',10,1)
	rollback transaction
	end
else
begin
update Bed set Used = 1 where Bed_ID = (select Bed_ID from inserted)
insert into Patient select * from inserted
commit transaction
end
end

go
create trigger ContractToInventory
on Contract
after update
as
begin
declare @ArriveDate date
set @ArriveDate = (select ArriveDate from inserted)
if @ArriveDate is not null
	begin
	declare @Quantities int
	declare @CID nvarchar(20)
	declare @MID nvarchar(20)
	declare @CurrentQuantitiy int
	set @CID = (select Contract_ID from inserted)
	set @Quantities= (select Quantity from Contract where Contract_ID = @CID)
	set @MID = (select Medince_ID from Contract where Contract_ID = @CID)
	set @CurrentQuantitiy = (select AvailableQuantity from Medicine where Medince_ID = @MID)
	update Medicine set AvailableQuantity = @Quantities+@CurrentQuantitiy where Medince_ID = @MID
	end
end

go
create procedure GetMyEmployees
(@NID nvarchar(20)
)
as
select distinct E.Nurse_ID,E.FirstName,E.LastName from Nurse E join Nurse B
on E.ReportToID = B.Nurse_ID
where B.Nurse_ID = @NID

--test query
select * from Patient
insert Register values(123123123,'TEST','TEST',1,getdate())
insert Patient values(123123123,'test','test','M',32,'I',1231321,'tett',1,6,1)
select * from Register

select * from GetRegisterInfor(1,'2016-01-01')

insert Patient values(12311111,'test','test','M',32,'I',1231321,'tett',1,1,1)
insert Patient values(123111111,'test','test','M',32,'I',1231321,'tett',1,1,1)

update Contract set Quantity = 20 where Contract_ID = 2
update Contract set ArriveDate = getdate() where Contract_ID = 3
select * from Medicine

exec GetMyEmployees @NID = 2