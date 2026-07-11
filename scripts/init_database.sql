/*
Create database and schemas

Script purpose:
This script creates a new database named 'Datawarehouse' after checking if it already exists.
if the database exists, It is dropped and recreated. Additionally, The script sets up three schemas 
within the database 'bronze', 'Silver', and 'Gold'.

Warning:
Running this script will drop the entire data warehouse database if it exists.
All Tata in Tata base will be permanently deleted. Proceed with caution
And ensure you have proper backups before running this script.
*/

use master;
GO

-- Drop and we create 'Datawarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DATAWAREHOUSE
END;
GO
--CREATE DATABASE DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--CREATE schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO





