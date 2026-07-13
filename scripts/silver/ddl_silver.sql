/*
===================================================================
Ddl script: Create Silver tables
===================================================================
Script purpose :
These script creates tables in 'Silver' schema, Dropping existing tables 
If they already exist. 
Run this script to redefine the DDL structure of 'bronze' tables.

===================================================================
*/

DROP TABLE IF EXISTS silver.crm_cust_info;
create table silver.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE,
dwh_create_date datetime2 default getdate()
);

GO
drop table silver.crm_sales_details;

DROP TABLE IF EXISTS  silver.crm_prd_info;
create table silver.crm_prd_info(
prd_id INT,
cat_id NVARCHAR(50),
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE,
dwh_create_date datetime2 default getdate()
)

GO 

DROP TABLE IF EXISTS silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT,
dwh_create_date datetime2 default getdate()
)

GO

DROP TABLE IF EXISTS silver.erp_CUST_AZ12;
CREATE TABLE silver.erp_CUST_AZ12(
cid NVARCHAR(50),
bdate DATE,
gen VARCHAR(20),
dwh_create_date datetime2 default getdate()
)

GO


DROP TABLE IF EXISTS silver.erp_LOC_A101;
CREATE TABLE silver.erp_LOC_A101(
cid NVARCHAR(50),
cntry NVARCHAR(50),
dwh_create_date datetime2 default getdate()
)

GO 


DROP TABLE IF EXISTS silver.erp_PX_CAT_G1V2;
CREATE TABLE silver.erp_PX_CAT_G1V2(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50),
dwh_create_date datetime2 default getdate()
)
