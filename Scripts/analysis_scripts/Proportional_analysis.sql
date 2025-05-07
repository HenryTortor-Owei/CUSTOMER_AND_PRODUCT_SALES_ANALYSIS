-- Part to whole analysis

-- find the percentages of different product categories that contributed to sales.
SELECT * FROM dim_products;
WITH inner_table AS(
SELECT category, SUM(sales_amount) total_sales
FROM fact_sales INNER JOIN dim_products
USING(product_key)
GROUP BY category)

SELECT category, total_sales, CONCAT(total_sales/SUM(total_sales) OVER()*100,'%') percent
FROM inner_table
ORDER BY 3 desc;