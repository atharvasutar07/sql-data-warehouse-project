/*
================================================================================
DDL Script: Create Gold Views
================================================================================
Script Purpose:
This script creates views for the Gold layer in the data warehouse.
The Gold layer represents the final dimension and fact tables (Star Schema)

Each view performs transformations and combines data from the Silver layer
to produce a clean, enriched, and business-ready dataset.

Usage:
- These views can be queried directly for analytics and reporting.
*/

--================================================================================
-- Create Dimension: gold.dim_customers
--================================================================================

create view gold.dim_customers AS
SELECT
ROW_NUMBER() OVER(order by cst_id) AS row_id,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name ,
ci.cst_lastrname AS Last_name,
la.cntry AS country,
ci.cst_material_status AS Marital_status,

CASE WHEN ci.cst_Gender != 'n/a' THEN ci.cst_Gender
ELSE COALESCE(ca.gen, 'n/a')
END AS gender,

ca.bdate AS birthdate,
ci.cst_create_date AS create_date
  
FROM Silver.crm_cust_info ci
LEFT JOIN Silver.erp_cust_az12 ca
ON        ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON        ci.cst_key = la.cid


-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

create view gold.dim_products as 
select
row_number() over(order by pn.prd_start_date , pn.prd_key_clean) as product_key,
pn.prd_id AS product_id,
pn.prd_key_clean AS product_number,
pn.prd_name AS product_name,
pn.cat_id AS category_id,
pc.cat AS product_category,
pc.subcat AS product_subcategory,
pc.maintenance AS manintenance,
pn.prd_cost AS product_cost,
pn.prd_line AS product_line,
pn.prd_start_date AS start_date

from silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_End_date IS NULL  -- FILTER OUT ALL  HISTORICAL DATA 


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================

create view gold.fact_sales as
select
sls_ord_no as order_number,
pr.product_key,
cu.customer_id,
sls_ord_Date as order_date,
sls_ship_date as shipping_date,
sls_due_date as due_date,
sls_sales as sales_amount,
sls_quantity as quantity,
sls_price as price 
from silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr 
ON sd.sls_prd_key = pr.product_number 
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id
