/*
=====================================================================================================
Product report
=====================================================================================================
Purpose:
	This report summarizes key product metrics and behaviours
    
Highlights:
	1. Gathers essential fields such as name, category, subcategory and cost
    2. Segments products into categories
    3. Aggregates Customer level metrics
		- total orders
        - total sales
        - total quantity sold
        - total unique customers
        - total products
        - product lifespan (months)
        
	4. Calculates valuable KPIs:
		- recency (months since last order)
        - average order revenue
        - average monthly revenue
    
=====================================================================================================
*/

SET sql_mode = 'ALLOW_INVALID_DATES';

CREATE VIEW product_report_view AS

WITH base_table AS(
/* BASE TABLE collecting basic product details
=========================================================================================
*/
SELECT product_key, order_number, customer_key, order_date, product_name, category, subcategory, sales_amount, quantity
FROM fact_sales INNER JOIN dim_products
USING(product_key)
WHERE order_date != '0000-00-00'),

product_aggregations AS(
/* product aggregations table with several aggregations to facilitate final query
=========================================================================================
*/
SELECT product_key, product_name, category, subcategory, COUNT(order_number) total_orders, SUM(sales_amount) total_sales, MAX(order_date) activity,COUNT(DISTINCT customer_key) unique_customers, TIMESTAMPDIFF(month, MIN(order_date),MAX(order_date)) product_lifespan
FROM base_table
GROUP BY product_key
ORDER BY 4 desc)

/* Final query selecting all key product details as well as valid KPIs and aggregations
=========================================================================================
*/
SELECT product_key, product_name, category, subcategory, total_orders, total_sales, unique_customers, product_lifespan,
CASE
	WHEN total_sales < 50000 THEN 'Low_sales'
    WHEN total_sales BETWEEN 50000 AND 200000 THEN 'medium_sales'
    WHEN total_sales BETWEEN 200000 AND 500000 THEN 'high_sales'
    WHEN total_sales BETWEEN 500000 AND 800000 THEN 'very_high_sales'
    ELSE 'Top_performer'
END sales_categories, TIMESTAMPDIFF(month, activity, (SELECT MAX(order_date) FROM fact_sales)) recency_months,

CASE 
	WHEN total_orders = 0 THEN 0
    ELSE round((total_sales/total_orders),2)
END average_order_revenue,
CASE
	WHEN product_lifespan = 0 THEN 0
    ELSE round((total_sales/ product_lifespan),2)
END average_monthly_revenue
FROM product_aggregations;

