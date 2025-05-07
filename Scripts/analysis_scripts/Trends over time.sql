-- Trends over time

-- Analysis of Yearly total sales across
-- total customers
-- total sales quantity
-- total orders


SELECT year(order_date) year, SUM(sales_amount) sales,
COUNT(DISTINCT customer_key) total_customers, SUM(quantity) total_quantity, COUNT(DISTINCT order_number) total_orders
FROM fact_sales
WHERE month(order_date) != 0
GROUP BY  year(order_date)
ORDER BY sales desc;


-- Same analysis on a monthly basis

SELECT DATE_FORMAT(order_date, '%Y-%m') as yearmonth, SUM(sales_amount) total_sales,
COUNT(DISTINCT customer_key) total_customers, SUM(quantity) total_quantity,
COUNT(DISTINCT order_number) total_orders
FROM fact_sales
WHERE month(order_date) != 0
GROUP BY yearmonth
ORDER BY total_sales desc;