/*
=================================================================
Stored Proceduer : Load Bronze Layer 
=================================================================
Description: Loads data into Bronze layer tables.
             Truncates existing data and imports fresh data
             from source CSV files (CRM & ERP).
             Includes execution tracking and row count logging.
Purpose: Automates raw data ingestion into the Bronze schema.
====================================================================

*/

SET @start_time = NOW();
SELECT '========================' AS message;
SELECT 'Starting Data Load...' AS message;
SELECT @start_time AS start_time;
SELECT '========================' AS message;


SELECT 'Truncating CRM Customers...' AS message;
TRUNCATE TABLE bronze.crm_cust_info;
  
SELECT 'Loading CRM Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;

SELECT 'Truncating CRM Customers...' AS message;
TRUNCATE TABLE bronze.crm_prd_info;

SELECT 'Loading CRM Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;
SELECT 'Truncating CRM Customers...' AS message;
TRUNCATE TABLE bronze.crm_sales_details;

SELECT 'Loading CRM Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;

SELECT 'Truncating ERP Customers...' AS message;
TRUNCATE TABLE bronze.erp_cust_az12;

SELECT 'Loading ERP Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;

SELECT 'Truncating ERP Customers...' AS message;
TRUNCATE TABLE bronze.erp_loc_a101;

SELECT 'Loading ERP Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;

SELECT 'Truncating ERP Customers...' AS message;
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

SELECT 'Loading ERP Customers...' AS message;
LOAD DATA LOCAL INFILE 'C:/Users/Atharva Sutar/OneDrive/Desktop/data warehouse/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT CONCAT('Rows Loaded: ', ROW_COUNT()) AS message;

SET @end_time = NOW();

SELECT '========================' AS message;
SELECT 'Data Load Completed' AS message;
SELECT @end_time AS end_time;
SELECT '========================' AS message;

SELECT 
    TIMESTAMPDIFF(SECOND, @start_time, @end_time) AS total_time_seconds;
