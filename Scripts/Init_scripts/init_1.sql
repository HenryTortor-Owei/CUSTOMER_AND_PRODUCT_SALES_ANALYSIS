/*
=============================================================
Create Database
=============================================================
*/

-- Create the 'gold' database
SET GLOBAL local_infile=1;

CREATE DATABASE IF NOT EXISTS gold;

USE gold;

CREATE TABLE IF NOT EXISTS gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);

CREATE TABLE IF NOT EXISTS gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);

CREATE TABLE IF NOT EXISTS gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);

TRUNCATE TABLE gold.dim_customers;

LOAD DATA LOCAL INFILE 'C:/Users/DELL/PORTFOLIO NEW/sql-data-analytics-project/datasets/csv-files/gold.dim_customers.csv'
INTO TABLE gold.dim_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

TRUNCATE TABLE gold.dim_products;

LOAD DATA LOCAL INFILE 'C:/Users/DELL/PORTFOLIO NEW/sql-data-analytics-project/datasets/csv-files/gold.dim_products.csv'
INTO TABLE gold.dim_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

TRUNCATE TABLE gold.fact_sales;

LOAD DATA LOCAL INFILE 'C:/Users/DELL/PORTFOLIO NEW/sql-data-analytics-project/datasets/csv-files/gold.fact_sales.csv'
INTO TABLE gold.fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;