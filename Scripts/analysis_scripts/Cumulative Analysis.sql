-- Cumulative analysis

-- find the rolling sum of sales over months across all years
-- and find the three month moving average for all years

use gold;
SELECT year, month_number, month_name, sum_sales,
round(AVG(sum_sales) OVER(PARTITION BY year ORDER BY year, month_number ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),2) moving_average,
round(SUM(sum_sales) OVER(PARTITION BY year ORDER BY year, month_number),2) rolling_sum

FROM(
SELECT year(order_date) year, month(order_date) month_number, monthname(order_date) month_name, SUM(sales_amount) sum_sales
FROM fact_sales
WHERE year(order_date) != 0
GROUP BY year, month_number, month_name) AS inner_table;
