/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

USE [MediVault Analytics Warehouse];
GO

CREATE OR ALTER PROCEDURE bronze.load_procedure 
AS
BEGIN
    BEGIN TRY

        DECLARE
            @start_time        DATETIME,
            @end_time          DATETIME,
            @duration          NVARCHAR(100),
            @batch_start_time  DATETIME,
            @batch_end_time    DATETIME,
            @batch_duration    NVARCHAR(100);

        SET @batch_start_time = GETDATE();

        PRINT '===============================================================';
        PRINT ' STARTING BRONZE LAYER DATA LOAD PROCESS';
        PRINT '===============================================================';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Hospitals Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.hospitals_info ...';
        TRUNCATE TABLE bronze.hospitals_info;

        BULK INSERT bronze.hospitals_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\hospitals.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.hospitals_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Patients Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.patients_info ...';
        TRUNCATE TABLE bronze.patients_info;

        BULK INSERT bronze.patients_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\patients.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.patients_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Doctors Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.doctors_info ...';
        TRUNCATE TABLE bronze.doctors_info;

        BULK INSERT bronze.doctors_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\doctors.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.doctors_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Visiting Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.visiting_info ...';
        TRUNCATE TABLE bronze.visiting_info;

        BULK INSERT bronze.visiting_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\visits_fact.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.visiting_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Gender Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.gender_info ...';
        TRUNCATE TABLE bronze.gender_info;

        BULK INSERT bronze.gender_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\gender_dim.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.gender_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Load Location Info
        ---------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Loading bronze.location_info ...';
        TRUNCATE TABLE bronze.location_info;

        BULK INSERT bronze.location_info
        FROM 'C:\Users\Aakash Vishwakarma\Desktop\HEALTH CARE\datasets\location_dim.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        SET @duration = CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(100));
        PRINT 'Loaded bronze.location_info in ' + @duration + ' seconds.';
        PRINT CHAR(13);

        ---------------------------------------------------------------------
        -- Summary
        ---------------------------------------------------------------------
        PRINT '---------------------------------------------------------------';
        PRINT 'All Bronze Tables Loaded Successfully';
        PRINT '===============================================================';
        PRINT CHAR(13);

        PRINT '===============================================================';
        PRINT 'BRONZE LAYER DATA LOAD SUMMARY';

        SET @batch_end_time = GETDATE();
        SET @batch_duration = CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR(100));

        PRINT '     - Total Load Duration : ' + @batch_duration + ' seconds.';
        PRINT '===============================================================';
        PRINT CHAR(13);

    END TRY

    BEGIN CATCH
        PRINT 'An error occurred during Bronze layer load.';
        PRINT 'Error Message   : ' + ERROR_MESSAGE();
        PRINT 'Error Number    : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Line      : ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        PRINT 'Error Procedure : ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
    END CATCH

END;
GO
