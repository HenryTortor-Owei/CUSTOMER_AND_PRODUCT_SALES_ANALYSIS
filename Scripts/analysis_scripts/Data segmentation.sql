-- Data segmentation
use gold;
SET sql_mode = 'ALLOW_INVALID_DATES';

-- categorise products into segments by cost ranges
SELECT min(cost), max(cost) FROM dim_products;
SELECT product_name, cost
FROM dim_products
ORDER BY 2;

SELECT product_name, cost, product_categories,
COUNT(*) OVER(PARTITION BY product_categories) cat_count
FROM(
SELECT product_name, cost,
CASE
	WHEN cost = 0 THEN 'zero'
	WHEN cost > 0 AND cost <= 100 THEN 'low'
    WHEN cost > 100 AND cost <= 500 THEN 'medium'
    WHEN cost > 500 AND cost < 1000 THEN 'high'
    ELSE 'very high'
END product_categories
FROM dim_products 
ORDER BY 2) AS inner_table;

-- -- segment customers into three categories by their lifespan >= 12 months
-- and their total spend >= 5000
-- And count them too

SELECT customer_key, total_sales, CASE
WHEN total_sales > 5000 AND lifespan >= 365 THEN 'VIP'
WHEN total_sales < 5000 AND lifespan >= 365 THEN 'Regular'
Else 'New'
End Status,
COUNT(*) OVER(PARTITION BY (SELECT CASE
WHEN total_sales > 5000 AND lifespan >= 365 THEN 'VIP'
WHEN total_sales < 5000 AND lifespan >= 365 THEN 'Regular'
Else 'New' End)) cat_count
FROM(
SELECT customer_key, SUM(sales_amount) total_sales, MIN(order_date) min_date, MAX(order_date) max_date,
DATEDIFF(MAX(order_date), MIN(order_date)) lifespan
FROM fact_sales INNER JOIN dim_customers
USING(customer_key)
GROUP BY customer_key) AS inner_table;


-- Or, if you use a group by instead
SELECT CASE
	WHEN total_sales > 5000 AND lifespan >= 365 THEN 'VIP'
	WHEN total_sales < 5000 AND lifespan >= 365 THEN 'Regular'
	Else 'New'
End Status,
COUNT(*) cat_count
FROM(
SELECT customer_key, SUM(sales_amount) total_sales, MIN(order_date) min_date, MAX(order_date) max_date,
DATEDIFF(MAX(order_date), MIN(order_date)) lifespan
FROM fact_sales INNER JOIN dim_customers
USING(customer_key)
GROUP BY customer_key) AS inner_table
GROUP BY Status;

-- Categorise products by sales
SELECT p.product_key, product_name, category, SUM(sales_amount) total_sales,
CASE
	WHEN SUM(sales_amount) < 50000 THEN 'Low_sales'
    WHEN SUM(sales_amount) BETWEEN 50000 AND 200000 THEN 'medium_sales'
    WHEN SUM(sales_amount) BETWEEN 200000 AND 500000 THEN 'high_sales'
    WHEN SUM(sales_amount) BETWEEN 500000 AND 800000 THEN 'very_high_sales'
    ELSE 'Top_performer'
END sales_categories
FROM fact_sales f INNER JOIN dim_products p
USING(product_key)
GROUP BY product_key
ORDER BY 4 desc