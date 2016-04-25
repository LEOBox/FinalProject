/*
1)Login view ----function
2)Payment view ----Dynamic SQl or function,trigger
3)Register view -----Dynamic SQL
6)Patient Health attribute view ---stored procedure
7)Appointment view under doctor view ---Trigger for patient table,function
*/

/*
This function is used for login view which select the DOCTOR's ID 
and password in database.
*/
CREATE FUNCTION findDoctor
(@id NVARCHAR,
@password NVARCHAR)
RETURNS NVARCHAR
BEGIN
	DECLARE @result nvarchar;
	IF EXISTS(
		SELECT *
		FROM doctor
		WHERE Doctor_ID = @ID AND password = @password 
		)
		SET @result = 'true'; 
	ELSE
	BEGIN
		SET @result = 'false'
	END
RETURN @result
END

GO

/*
This function is used for login view which select the patient's ID 
and password in database.
*/
CREATE FUNCTION findPatient
(@id NVARCHAR,
@password NVARCHAR)
RETURNS NVARCHAR
BEGIN
	DECLARE @result nvarchar;
	IF EXISTS(
		SELECT *
		FROM Patient
		WHERE Patient_ID = @ID AND password = @password
		)
		SET @result = 'true'; 
	ELSE
	BEGIN
		SET @result = 'false'
	END
RETURN @result
END

GO
/*
This function is used for login view which select the Manager's ID 
and password in database.
*/
CREATE FUNCTION findManager
(@id NVARCHAR,
@password NVARCHAR)
RETURNS NVARCHAR
BEGIN
	DECLARE @result nvarchar;
	IF EXISTS(
		SELECT *
		FROM Manager
		WHERE Patient_ID = @ID AND password = @password
		)
		SET @result = 'true'; 
	ELSE
	BEGIN
		SET @result = 'false'
	END
RETURN @result
END

GO
/*
This function is used for login view which select the Nurse's ID 
and password in database.
*/
CREATE FUNCTION findnNurse
(@id NVARCHAR,
@password NVARCHAR)
RETURNS NVARCHAR
BEGIN
	DECLARE @result nvarchar;
	IF EXISTS(
		SELECT *
		FROM Nurse
		WHERE Patient_ID = @ID AND password = @password
		)
		SET @result = 'true'; 
	ELSE
	BEGIN
		SET @result = 'false'
	END
RETURN @result
END


GO

-- 2)Payment view ----Dynamic SQl or function,trigger
/*
This function is used for payment view
user can see his payment detail and taotal fee on this view
When user click 'pay' button, system will delete her/his
reocrd in Patient table and the trigger on patient table will
delete his payment and payment detail record 
*/ 
GO
CREATE PROC showPayment
@ID NVARCHAR
AS
DECLARE @SQL NVARCHAR(MAX);
SET @SQL = 
N'SELECT Date, Type, Total AS Fee, BillTotal, PaymentTotal, InsuranceTotal
FROM Bill AS B INNER JOIN Bill_Detail AS BD
	ON B.Bill_ID = BD.Bill_ID
WHERE Patient_ID = @Patient_ID
ORDER BY DATE';
DECLARE @ParameterDefinition NVARCHAR(MAX);
SET @ParameterDefinition = N'@Patient_ID Nvarchar';
EXECUTE sp_executesql @SQL, @ParameterDefinition, @id;

GO


-- 3)Register view -----Dynamic SQL
/*
This proc is for the register view
if the user input the valid new user name and password, 
a new record will be inserted into register table 
*/
DROP PROC newRegister;
GO
CREATE PROC newRegister
@ID NVARCHAR(20),
@Name NVARCHAR(50),
@Doctor_ID NVARCHAR(20)
AS
DECLARE @SQL NVARCHAR(MAX)
SET @SQL = 
N'INSERT INTO Register
VALUES(@User_ID, @User_Name, @Doctor_ID, GETDATE());
'
DECLARE @ParameterDefinition NVARCHAR(MAX);
SET @ParameterDefinition = 
'@User_ID NVARCHAR(20), 
@User_Name NVARCHAR(50),
@Doctor_ID NVARCHAR(20)';

EXEC sp_executesql @SQL, @ParameterDefinition, @ID, @Name, @Doctor_ID
GO

-- 6)Patient Health attribute view ---stored procedure
/*
This procedure selete all attributes in Health_Attribute table 
*/
CREATE PROC showHealth
@ID NVARCHAR(20)
AS
SELECT * 
FROM Health_Attribute
WHERE Patient_ID = @ID; 
GO


-- 7)Appointment view under doctor view ---Trigger for patient table,function
/*
This procedure is used for doctor to check the appointments she/he has 
*/
CREATE PROC showAppointment
@ID NVARCHAR(20)
AS
SELECT * 
FROM Register
WHERE Doctor_ID = @ID;

/*
After meeting with the person, if the doctor decide that this person show stay in
hospital, he will fill a form to add more information to the patient's profile and
hit the 'submit' button, then this person's record in regitser table will be moved
into patient table
*/
IF OBJECT_ID('addPatient') IS NOT NULL
	DROP PROC addPatient;

GO
CREATE PROC addPatient
@Register_ID NVARCHAR(20),
@ID NVARCHAR(20),
@FirstName NVARCHAR(30),
@LastName NVARCHAR(30),
@Gender CHAR(1),
@Age INT,
@Status CHAR(3),
@Phone VARCHAR(15),
@Email NVARCHAR(20),
@Department_ID NVARCHAR(20),
@Bed_ID NVARCHAR(20),
@Insurance_ID NVARCHAR(20)
AS 
DELETE Register
WHERE Register_ID = @Register_ID;  -- Delete the person's record in Register Table

INSERT INTO Patient
VALUES(@ID, @FirstName, @LastName, @Gender, @Age, @status, @Phone,
@Email, @Department_ID, @Bed_ID, @Insurance_ID);

GO





