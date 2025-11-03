USE master;
GO

-- Drop and recreate the 'DataWarehouse' database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'MediVault Analytics Warehouse')
BEGIN
    -- Force single user mode and rollback open transactions, then drop
    ALTER DATABASE [MediVault Analytics Warehouse] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [MediVault Analytics Warehouse];
END;
GO

CREATE DATABASE [MediVault Analytics Warehouse];
GO

USE [MediVault Analytics Warehouse];
GO

-- CREATE SCHEMA FOR DATA-LAYER SEPERATION
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
