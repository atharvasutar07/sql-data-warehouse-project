/*
====================================================================================
DDL Script: Create Silver Tables
====================================================================================
Script Purpose:
This script creates tables in the 'silver' schema, 
Run this script to re-define the DDL structure of 'bronze' Table
====================================================================================
*/


CREATE TABLE Silver.crm_cust_info(
				cst_id int ,
				cst_key varchar(50),
				cst_firstname varchar(50),
				cst_lastrname varchar(50),
				cst_material_status varchar(50), 
				cst_Gender varchar(50),
				Cst_create_date date,  
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Silver.crm_prd_info(
				prd_id int, 
				prd_key varchar(50), 
				prd_name varchar(50),
				prd_cost int,
				prd_line varchar(50),
				prd_start_date date,
				prd_End_date date,
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP    
 );

CREATE TABLE Silver.crm_sales_details(
				sls_ord_no varchar(50), 
				sls_prd_key varchar(50), 
				sls_cust_id int, 
				sls_ord_Date date, 
				sls_ship_date date, 
				sls_due_date date,
				sls_sales int, 
				sls_quantity int,
				sls_price int,
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE Silver.erp_cust_az12(
				cid varchar(50), 
				bdate date, 
				Gen varchar(50),
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Silver.erp_loc_a101(
				cid varchar(50), 
				cntry varchar(50),
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Silver.erp_px_cat_g1v2(
				id varchar(50), 
				cat varchar(50), 
				subcat varchar(50), 
				maintenance varchar(50),
                dwd_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);




