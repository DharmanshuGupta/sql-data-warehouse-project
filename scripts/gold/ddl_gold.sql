/*
===================================================================
Ddl script: Create Gold Views
===================================================================
Script purpose :
This script creates views for the Gold Layer in the data warehouse.
The Gold layer represents the final dimension and fact tables(Star Schema)

Each view performs transformations and combines data from the silver layer
to produce a clean,enriched, and business-ready dataset.

Usage:
- These views can be queried directly for analytics and reporting.
===================================================================
*/

/*
===================================================================
CREATE Dimension: gold.dim_customers
===================================================================
*/
CREATE VIEW gold.dim_customers AS

SELECT 
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,     --SURROGATE KEY
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr	
		ELSE COALESCE(ca.gen,'n/a')
	END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_LOC_A101 la 
ON ci.cst_key= la.cid




/*
===================================================================
CREATE Dimension: gold.dim_products
===================================================================
*/
CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pn.prd_cost AS cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
	ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL

/*
===================================================================
CREATE Fact Table : gold.fact_sales
===================================================================
*/
CREATE VIEW gold.fact_sales AS 
SELECT 
	sd.sls_ord_num AS order_number,
	pr.product_key ,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_prd_key = cu.customer_key


