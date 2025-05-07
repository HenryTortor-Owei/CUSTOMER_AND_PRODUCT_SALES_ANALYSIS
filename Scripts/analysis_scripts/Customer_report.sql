/*
=====================================================================================================
Customer report
=====================================================================================================
Purpose:
	This report summarizes key customer metrics and behaviours
    
Highlights:
	1. Gathers essential fields such as names, ages and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups
    3. Aggregates Customer level metrics
		- total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan (months)
        
	4. Calculates valuable KPIs:
		- recency (months since last order)
        - average order value
        - average monthly spend
    
=====================================================================================================
*/
SET sql_mode = 'ALLOW_INVALID_DATES';

SELECT *
FROM fact_sales INNER JOIN dim_customers
USING(customer_key);

CREATE VIEW customer_report_view AS
WITH base_table AS(
/* BASE TABLE
=========================================================================================
*/
SELECT customer_key, order_number, order_date, sales_amount, quantity, product_key, customer_number, concat(first_name, '  ', last_name) name,
timestampdiff(year, birthdate, (SELECT max(order_date) FROM fact_sales)) age
FROM fact_sales INNER JOIN dim_customers
USING(customer_key)
INNER JOIN dim_products
USING(product_key)
WHERE order_date != '0000-00-00'
ORDER BY order_date),

customer_details AS(
/* Higher level TABLE with several aggregations
=========================================================================================
*/
SELECT customer_key ,name, age, COUNT(DISTINCT order_number) num_orders,
SUM(sales_amount) total_sales, SUM(quantity)total_quantity, COUNT(product_key) num_products,
MAX(order_date) AS last_order,
timestampdiff(month, min(order_date), max(order_date)) lifespan
FROM base_table
GROUP BY customer_key
ORDER BY total_sales desc, lifespan desc)

/* 	Final query with all key customer details as well as several KPIs and agrregations
=========================================================================================
*/
SELECT customer_key,name, age, num_orders, total_sales, total_quantity, num_products,
CASE
	WHEN age < 50 THEN '<50'
	WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50 and above'
END age_groups,
CASE
	WHEN total_sales > 5000 AND lifespan >= 12 THEN 'VIP'
	WHEN total_sales < 5000 AND lifespan >= 12 THEN 'Regular'
	Else 'New'
End Status,
timestampdiff(month, last_order, (SELECT MAX(order_date) FROM fact_sales)) recency,
CASE
WHEN num_orders = 0 THEN 0
ELSE round((total_sales/num_orders),2)
END average_order_value,
lifespan,
CASE
	WHEN lifespan = 0 THEN 0
	ELSE round((total_sales/lifespan),2)
END average_monthly_spend
FROM customer_details
ORDER BY total_sales desc;

