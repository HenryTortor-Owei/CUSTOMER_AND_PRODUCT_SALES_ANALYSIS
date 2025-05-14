# CUSTOMER_AND_PRODUCT_SALES_ANALYSIS

- This is an analysis of customer and product sales data to uncover key insights. 
- The dataset consisted of three tables, two dimension tables (dim_products and dim_customers) as well as a sales fact table(fact_sales)
- The fact table consisted of 60,398 rows of sales data
- The customer and products tables had 18484 and 295 products respectively. 
- This means that over the roughly 4 year period over which the data was collectd, the compant had 18484 unique customers and sold 295 products.

### DATA LOADING
- A database, called gold, was created along with three tables to hold the data. The columns were exactly the same as those in the csv flat files
- Appropriate data types were chosen for each column. Dates for date columns, vachars for text columns and an int for the numerics.

#### A caveat for the data is that data for 2010 and 2014 were incomplete


### Analysis

In total, there are ten questions which were desired to be answered:
#### Trends over time
1. What are Yearly sales totals?
2. What is the number of yearly total customers
3. What are yearly order totals:
4. What are yearly quantity totals:

#### Cumulative analysis
1. Find the 3-month moving average of sales
2. Find the monthly running total of sales

#### Performance Analysis
1. Analyze the performance of products by comparing each product’s sales to both its average sales performance over the whole period and the previous year's performance

#### Proportional Analysis
1. Analyse product categories to find which contributes the most to product sales

#### Data Segmenntation
1. What is the contribution of each products to sales, group them into segments.
2. Group customers into three segments based on their spending behaviour:
  - VIP: At least 12 months of spending and total spend of more than 5000 Euros
  - Regular: At least 12 months of spending but total spend is 5000 Euros or less
  - New: Less than 12 months of spending



As with all data analytics projects, countless aspects of the data could be explored. 
However the questions above were chosen and this is how the analysis was conducted
<br>

1. What are Yearly sales totals?

Here are the total sales numbers. 2013 had the highest sales

![Yearly sales](https://github.com/user-attachments/assets/9f8ce615-fea0-4a29-94a3-00ae58046b13)


| Year | Sales |
|------|-------|
| 2013 | 16,344,878 |
| 2011 | 7,075,088 |
| 2012 | 5,842,231 |
| 2014 | 45,642 |
| 2010 | 43,419 |


2. What is the number of yearly total customers

This displayed an interesting trend that even though total sales in 2011 were greater than 2012, 2011 had less customers

| Year | Total Customers |
|------|-----------------|
| 2013 | 17,427 |
| 2012 | 3,255 |
| 2011 | 2,216 |
| 2014 | 834 |
| 2010 | 14 |

3. What are yearly order totals:
This displayed a year on year increase and spiked in 2013

| Year | Total Orders |
|------|--------------|
| 2013 | 21,287 |
| 2012 | 3,269 |
| 2011 | 2,216 |
| 2014 | 871 |
| 2010 | 14 |

4. What are yearly quantity totals:
The results are as follows:

| Year | Total Quantity |
|------|----------------|
| 2013 | 52,807 |
| 2012 | 3,397 |
| 2011 | 2,216 |
| 2014 | 1,970 |
| 2010 | 14 |

The trend here is similar to other high level metrics i.e spiking in 2013

5 & 6. Find the rolling sum and 3-month moving average of sales

Rolling sum:

![rolling_sum](https://github.com/user-attachments/assets/fca647c9-de86-4b7d-a0ed-d07e23e17b38)

- The rolling sum gives an idea of the change in sales every month/year
- It gives an idea of growth/decline
- From january to december between 2011 and 2012 is a fairly straight line meaning a fairly linear sales function.
- This means on average for these two years, roughly similar amounts were sold each month
- From january - december 2013 is the most non-linear and has the greatest average slope
- Meaning that the month to month change in sales was the greatest during that period.
- This tallies with 2013 having the largest sales numbers.
- In general, this shows month-to-month growth in 2013

Moving Average:

![Moving_average](https://github.com/user-attachments/assets/2a680223-f780-406f-86f5-58ec19e2d697)

- Moving averages are good for identifying underlying trends when there are fluctuations.
- In this instance, it shows that the 3-month average in 2011 and 2012 were relatively flat
- This means that as the year went on any spikes were cancelled out by declines and it averages to a relatively flat pattern
- Also, the average sales numbers of 2012 were less than 2011 numbers which tallies with the total
- For 2013, the moving average had a clear upward momentum which showed a steady, periodic sales gain
- Except between july and august which had a slight decline compared to other periods in the year.



7. Analyze the performance of products by comparing each product’s sales to both its average sales performance over the whole period and the previous year's performance
There are more products than can be shown here but here are the first 2 product results:

| Year | Product Name | Yearly Sales | Average Sales | Previous Comparison | PY Status | Average Comparison | Average Status |
|------|--------------|-------------|--------------|-------------------|-----------|-------------------|---------------|
| 2012 | All-Purpose Bike Stand | 159 | 13,197.0000 | NULL | neutral | 0.0000 | neutral |
| 2013 | All-Purpose Bike Stand | 37,683 | 13,197.0000 | 37,524 | better | 18,762.0000 | Above_average |
| 2014 | All-Purpose Bike Stand | 1,749 | 13,197.0000 | -35,934 | worse | -11,448.0000 | Lower_than_average |
| 2012 | AWC Logo Cap | 72 | 6,570.0000 | NULL | neutral | 0.0000 | neutral |
| 2013 | AWC Logo Cap | 18,891 | 6,570.0000 | 18,819 | better | 9,409.5000 | Above_average |
| 2014 | AWC Logo Cap | 747 | 6,570.0000 | -18,144 | worse | -5,823.0000 | Lower_than_average |


8. Analyse product categories to find which contributes the most to product sales
   There are three product categories here: Accesories, bikes and clothing. Here is a donut chart of the contribution to sales:

   ![Product categories](https://github.com/user-attachments/assets/37860891-18dd-48c2-9369-cc2e4ace86d3)

   - This shows that overwhelmingly, bikes contribute the most with 96.46% contribution or 28,316,272 sales.
   - This is followed by accessories with 2.39% or 700,262 sales
   - Lastly is clothing with 1.16% or 339,716 sales

9. What is the contribution of each products to sales, group them into segments.
   Here are the results
    ![Sales categories](https://github.com/user-attachments/assets/8aaef8b6-6583-4820-85e1-f5a3be6de88a)



10. Group customers into three segments based on their spending behaviour:
  - VIP: At least 12 months of spending and total spend of more than 5000 Euros
  - Regular: At least 12 months of spending but total spend is 5000 Euros or less
  - New: Less than 12 months of spending

    ![Customer segments](https://github.com/user-attachments/assets/843f6596-959b-421a-9e4e-c4f6ea5c1fe1)

    - This shows that there are 14829 customers who have not made purchases for at least 12 months.
    - Of the rest, 2038 have spent 5000 Euros or less and 1617 have spent over 5000 Euros

    
