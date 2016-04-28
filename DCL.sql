CREATE LOGIN Doctor
	WITH PASSWORD = 'Inovator',
	DEFAULT_DATABASE = Hospital ;

CREATE LOGIN Nurse
	WITH PASSWORD = 'Inovator',
	DEFAULT_DATABASE = Hospital;

CREATE LOGIN Manager
	WITH PASSWORD = 'Inovator',
	DEFAULT_DATABASE = Hospital;


USE Hospital;

CREATE USER Doctor
For Login Doctor;

CREATE USER Nurse
For Login Nurse;

CREATE USER Manager
For Login Manager;



CREATE ROLE Doctor;
CREATE ROLE Nurse;




-- Grant permission to doctor
GRANT SELECT, UPDATE, INSERT, DELETE
ON Doctor 
TO DOCTOR;

GRANT SELECT, UPDATE, INSERT, DELETE
ON MedicineUseRecord 
TO DOCTOR;

GRANT SELECT, UPDATE, INSERT, DELETE
ON TreatmentTeam 
TO DOCTOR;

GRANT SELECT
ON Health_Attribute
TO DOCTOR;

GRANT SELECT, DELETE
ON Register
TO Doctor;

-- Grant permissions for Nurse
GRANT SELECT, UPDATE, INSERT, DELETE
ON NurseSchedule
TO Nurse;

GRANT SELECT, UPDATE
ON MedicineUseRecord
TO Nurse;


GRANT SELECT, UPDATE, INSERT, DELETE
ON Nurse
TO Nurse;

-- Add members to roles
ALTER ROLE Doctor
ADD MEMBER DOCTOR;

ALTER ROLE Nurse
ADD MEMBER NURSE;

ALTER ROLE db_accessadmin
ADD MEMBER MANAGER;











