/*
============================================================================
Stored procedure: Load bronze layer (Source -> Bronze)
============================================================================
 Script purpose:
 These stored procedure loads data into the bronze schema from external CSV files.
 It performs the following actions:
 -Truncates the bronze tables before loading data. 
 -Uses Bulk insert Command to load data from csv files to browns tables. 

 Parameters:
 None.
 These stored procedure does not accept any parameters or written any values.

 Usage example:
 EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
BEGIN TRY
	print '====================';
	print'Loading Bronze Layer';
	print '====================';
	print'----------------------';
	print'Loading CRM Tables';


	print'>> Truncating Table: bronze.crm_cust_info';;
	print'>> Inserting data into : bronze.crm_cust_info'
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
	firstrow = 2,
	fieldterminator =',',
	tablock
	);


	
	print'>> Truncating Table: bronze.crm_prd_info';
	print'>> Inserting data into : bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	BULK INSERT bronze.crm_prd_info
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	tablock 
	);

	

	
	print'>> Truncating Table: bronze.crm_sales_details';
	print'>> Inserting data into : bronze.crm_sales_details'
	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	tablock 
	);
	
	print'---------------------------';
	print'Loading ERP Tables';
	print'---------------------------';

	
	print'>> Truncating Table: bronze.erp_CUST_AZ12'
	print'>> Inserting data into : bronze.erp_CUST_AZ12'
	TRUNCATE TABLE bronze.erp_CUST_AZ12;
	BULK INSERT bronze.erp_CUST_AZ12
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	tablock 
	);

	
	print'>> Truncating Table: bronze.erp_LOC_A101'
	print'>> Inserting data into : bronze.erp_LOC_A101'
	TRUNCATE TABLE bronze.erp_LOC_A101;
	BULK INSERT bronze.erp_LOC_A101
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	tablock 
	);


	
	print'>> Truncating Table: bronze.erp_PX_CAT_GIV2'
	print'>> Inserting data into : bronze.erp_PX_CAT_GIV2'
	TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
	BULK INSERT bronze.erp_PX_CAT_G1V2
	from 'C:\Users\hites\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	tablock 
	);
END TRY
	BEGIN CATCH
	
	print '====================';
	print'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'ERROR Message'+ ERROR_MESSAGE();
	PRINT 'ERROR Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	
	PRINT 'ERROR Message'+ CAST(ERROR_STATE() AS NVARCHAR);
    print '====================';
	END CATCH
END
