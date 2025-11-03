USE [MediVault Analytics Warehouse];
GO

-- Drop and recreate bronze.patients_info
IF OBJECT_ID('bronze.patients_info', 'U') IS NOT NULL
	DROP TABLE bronze.patients_info;
GO

CREATE TABLE bronze.patients_info (
	patient_id INT,
	patient_name NVARCHAR(100),
	age INT,
	gender_id INT,
	location_id INT

);
GO

-- Drop and recreate bronze.doctors_info
IF OBJECT_ID('bronze.doctors_info', 'U') IS NOT NULL
	DROP TABLE bronze.doctors_info;
GO

CREATE TABLE bronze.doctors_info (
	doctor_id INT,
	doctor_name NVARCHAR(100),
	specialization NVARCHAR(100),
	hospital_id INT

);
GO

-- Drop and recreate bronze.hospitals_info
IF OBJECT_ID('bronze.hospitals_info', 'U') IS NOT NULL
	DROP TABLE bronze.hospitals_info;
GO

CREATE TABLE bronze.hospitals_info (
	hospital_id INT,
	hospital_name NVARCHAR(100),
	location_id INT
);
GO

-- Drop and recreate bronze.gender_info
IF OBJECT_ID('bronze.gender_info', 'U') IS NOT NULL
	DROP TABLE bronze.gender_info;
GO

CREATE TABLE bronze.gender_info (
	gender_id INT,
	gender NVARCHAR(100)

);
GO

-- Drop and recreate bronze.location_info
IF OBJECT_ID('bronze.location_info', 'U') IS NOT NULL
	DROP TABLE bronze.location_info;
GO

CREATE TABLE bronze.location_info (
	location_id INT,
	city NVARCHAR(100),
	state NVARCHAR(100)

);
GO

-- Drop and recreate bronze.visiting_info
IF OBJECT_ID('bronze.visiting_info', 'U') IS NOT NULL
	DROP TABLE bronze.visiting_info;
GO
CREATE TABLE bronze.visiting_info (
	visit_id INT,
	patient_id INT,
	doctor_id INT,
	hospital_id INT,
	service_type NVARCHAR(100),
	appointment_date NVARCHAR(100),
	admission_date NVARCHAR(100),
	discharge_date NVARCHAR(100),
	diagnosis NVARCHAR(100),
	treatment NVARCHAR(100),
	service_cost FLOAT
);
GO

