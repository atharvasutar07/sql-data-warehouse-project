/*
=======================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
=======================================================================================

Script Purpose:
      This stored procedure performs the ETL (Extract, Transform, Load) process to
      Tonze' schema.populate the 'silver' schema tables from the 'bronze' schema.
Actions Performed:
    - Truncates Silver tables.
    - Inserts transformed and cleansed data from Bronze into Silver tables.

parameters:
None.
This stored procedure does not accept any parameters or return any values.

usage Example:
  EXEC Silver.load_silver;
=======================================================================================
*/


DELIMITER $$

DROP PROCEDURE IF EXISTS silver.load_silver;
CREATE PROCEDURE silver.load_silver()
BEGIN

DECLARE Start_time DATETIME;
DECLARE end_time DATETIME;

-- ===============ERROR HANDLER===================
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
SELECT 'ERROR OCCURED - PROCESS FAILED' AS message;
END;

-- ================GLOBAL TIMER=================
SET START_time = NOW();

SELECT '=================' AS message;
SELECT 'Starting Silver Load..' AS message;
SELECT START_time  AS START_time ;

-- ================CRM CUSTOMERS===================
SET @step_start = NOW();

SELECT  'loading CRM Customers..' AS message;

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info (
			cst_id,
			cst_key,
			cst_lastrname, 
			cst_firstname,
			cst_material_status, 
			cst_Gender,
			Cst_create_date
 )          
select 
cst_id,
cst_key,
TRIM(cst_lastrname),
TRIM(cst_firstname),

CASE when UPPER (TRIM(cst_material_status)) = "S" then "Single" 
     when UPPER (TRIM(cst_material_status)) = "M" then "Married" 
     ELSE 'n/a' 
END cst_material_status,
CASE when UPPER (TRIM(cst_Gender)) = "F" then "Female" 
     when UPPER (TRIM(cst_Gender)) = "M" then "Male" 
     ELSE 'n/a' 
END cst_gender,
Cst_create_date
from (
select *,
  ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY Cst_create_date DESC) 
  as Flag_Last
from bronze.crm_cust_info
where cst_id IS NOT NULL
)t  where Flag_last = 1;

SELECT CONCAT('ROW Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND,@step_start, NOW()) AS Step_duration_sec;

-- ==============CRM SALES==================
SET @step_start = NOW();

SELECT  'loading CRM Sales..' AS message;

TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details(
sls_ord_no, 
sls_prd_key,
sls_cust_id, 
sls_ord_Date,
sls_ship_date,
sls_due_date,
sls_sales,
sls_quantity,
sls_price
)
SELECT 
sls_ord_no,
sls_prd_key,
sls_cust_id,
STR_TO_DATE(
NULLIF(CAST(sls_ord_date AS CHAR), '0000-00-00'),'%Y-%m-%d') AS sls_ord_date,
sls_ship_date,
sls_due_date,
CASE WHEN sls_sales IS null or sls_sales <=0 or sls_sales != sls_quantity * ABS(sls_price)
	      THEN sls_quantity * ABS(sls_price)
	else sls_sales
end AS sls_sales,
sls_quantity,
CASE when sls_price IS NULL or sls_price <=0 
		  THEN sls_sales / NULLIF(sls_quantity, 0) 
	else sls_price
END AS sls_price
FROM bronze.crm_sales_details;

SELECT CONCAT('ROW Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND,@step_start, NOW()) AS Step_duration_sec;

-- ================= CRM PRODUCT =================
SET @step_start = NOW();

SELECT 'Loading CRM Products...' AS message;

TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO  silver.crm_prd_info(
		prd_id , 
		cat_id  ,
        prd_key_Clean ,
		prd_name ,
		prd_cost ,
		prd_line , 
		prd_start_date ,
		prd_End_date 
        
)
select 
prd_id ,
REPLACE(SUBSTRING(prd_key,1,5), '-','_') AS CAT_ID, 
SUBSTRING(prd_key,7,length(prd_key)) AS prd_key_Clean,
prd_name ,
prd_cost , 
CASE  UPPER(TRIM(prd_line))
	 WHEN 'M' THEN 'Mountain'
	 WHEN 'S' THEN 'Other Sales'
	 WHEN 'R' THEN 'Road'
	 WHEN 'T' THEN 'Touring'
ELSE 'n/a'
END AS prd_line ,
prd_start_date AS prd_start_date,
LEAD(Prd_start_date) OVER (PARTITION BY prd_key ORDER BY  prd_start_date  ) -INTERVAL 1 DAY as prd_end_date
FROM bronze.crm_prd_info;

SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND, @step_start, NOW()) AS step_duration_sec;

-- ================= ERP CUSTOMER =================
SET @step_start = NOW();

SELECT 'Loading ERP Customers...' AS message;

TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12(
cid, 
bdate,
Gen
)
select 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid , 4 , LENGTH(cid))
	 else cid 
END cid,

CASE WHEN bdate > NOW() THEN null
     else bdate
END bdate,

CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
   else 'n/a'
END gen
from bronze.erp_cust_az12;

SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND, @step_start, NOW()) AS step_duration_sec;

-- ================= ERP LOCATION =================
SET @step_start = NOW();

SELECT 'Loading ERP Location...' AS message;

TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101
(cid, cntry)
SELECT 
REPLACE(cid, '-', '')cid ,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('USA','US') THEN 'United States'
     WHEN TRIM(cntry) = '' THEN 'n/a'  
     else TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101;

SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND, @step_start, NOW()) AS step_duration_sec;

-- ================= ERP CATEGORY =================
SET @step_start = NOW();

SELECT 'Loading ERP Categories...' AS message;

TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO Silver.erp_px_cat_g1v2(
id,
cat,
subcat,
maintenance
)
SELECT 
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;

SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;
SELECT TIMESTAMPDIFF(SECOND, @step_start, NOW()) AS step_duration_sec;

-- ================= TOTAL TIME =================
SET end_time = NOW();

SELECT '========================' AS message;
SELECT 'Silver Load Completed' AS message;
SELECT end_time AS end_time;

SELECT TIMESTAMPDIFF(SECOND, start_time, end_time) AS total_duration_sec;

END$$

DELIMITER ;

