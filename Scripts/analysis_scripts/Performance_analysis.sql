-- Performance analysis

-- Compare the sales of products across years with previous year sales 
-- and average sales over all years

use gold;

WITH inner_table AS(
SELECT year(order_date) year, product_name, SUM(sales_amount) yearly_sales
FROM fact_sales INNER JOIN dim_products
USING(product_key)
WHERE year(order_date) != 0
GROUP BY year(order_date), product_name
ORDER BY 2)

SELECT year, product_name, yearly_sales, AVG(yearly_sales) OVER(PARTITION BY product_name) Average_sales,
yearly_sales - LAG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) previous_comparison,

CASE
	WHEN yearly_sales - LAG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) > 0 THEN 'better'
    WHEN yearly_sales - LAG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) < 0 THEN 'worse'
    ELSE 'neutral'
END py_status,
yearly_sales - AVG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) average_comparison,
CASE
	WHEN yearly_sales - AVG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) > 0 THEN 'Above_average'
    WHEN yearly_sales - AVG(yearly_sales) OVER(PARTITION BY product_name ORDER BY year) < 0 THEN 'Lower_than_average'
    ELSE 'neutral'
END average_status
FROM inner_table
ORDER BY 2;