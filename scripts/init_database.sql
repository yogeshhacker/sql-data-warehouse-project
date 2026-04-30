-- create database warehouse

USE master;
GO

IF EXISTS ( SELECT 1 FROM sys.DATABASES WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO


Create schema bronze;
GO
Create schema silver;
GO
Create schema gold;
GO


