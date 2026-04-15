/*
===================================================================================
DDL SCRIPT : CREATE BRONZE TABLE 
===================================================================================
Script purpose:
     Creates Bronze layer tables to store raw data from source systems (CRM & ERP)
===================================================================================
*/

-------------CRM TABLE------------
CREATE TABLE bronze.crm_cust_info(
				cst_id int ,
				cst_key varchar(50),
				cst_firstname varchar(50),
				cst_lastrname varchar(50),
				cst_material_status varchar(50), 
				cst_Gender varchar(50),
				Cst_create_date date       
);

CREATE TABLE bronze.crm_prd_info(
				prd_id int, 
				prd_key varchar(50), 
				prd_name varchar(50),
				prd_cost int,
				prd_line varchar(50),
				prd_start_date date,
				prd_End_date date     
 );

CREATE TABLE bronze.crm_sales_details(
				sls_ord_no varchar(50), 
				sls_prd_key varchar(50), 
				sls_cust_id int, 
				sls_ord_Date date, 
				sls_ship_date date, 
				sls_due_date date,
				sls_sales int, 
				sls_quantity int,
				sls_price int 
);


------------ERP TABLE-----------
CREATE TABLE bronze.erp_cust_az12(
				cid varchar(50), 
				bdate date, 
				Gen varchar(50)
);

CREATE TABLE bronze.erp_loc_a101(
				cid varchar(50), 
				cntry varchar(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2(
				id varchar(50), 
				cat varchar(50), 
				subcat varchar(50), 
				maintenance varchar(50)
);
