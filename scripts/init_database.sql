/*
===================================================================
Create Database and Schemas 
===================================================================
Script Purpose:
       This script creats a new databse named 'DataWarehouse' the script sets up three schemas
       within the database : 'broze','silver',and 'gold'
*/

--create the 'DataWarehouse' database 
create Database DataWarehouse;

USE DataWarehouse;

--create Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
