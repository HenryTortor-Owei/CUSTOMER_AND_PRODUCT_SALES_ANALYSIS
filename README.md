# CUSTOMER_AND_PRODUCT_SALES_ANALYSIS
This is an analysis of customer and product sales data to uncover key insights. In total, 
there are ten questions which were desired to be answered:
1 What are monthly total sales
2 What are monthly total orders
3 What is the monthly total quantity
4 What is the total number of monthly customers
5 What is the monthly running total of sales
6 What is the 3-month moving average of sales
7 Analyze the performance of products by comparing each product’s sales to both its average sales performance over the whole period and the previous year's performance
8 Analyse product categories to find which contributes the most to product sales
9 Segment products into cost ranges and find out how many products fall into each segment
10 Group customers into three segments based on their spending behaviour:
  - VIP: At least 12 months of spending and total spend of more than 5000 Euros
  - Regular: At least 12 months of spending but total spend is 5000 Euros or less
  - New: Less than 12 months of spending


** A caveat for the data is that data for 2010 and 2014 were incomplete

What are monthly total sales?
Here are the results of running the queries. 2013 had the highest sales
| Year | Sales |
|------|-------|
| 2013 | 16,344,878 |
| 2011 | 7,075,088 |
| 2012 | 5,842,231 |
| 2014 | 45,642 |
| 2010 | 43,419 |


Total customers:
This displayed an interesting trend that even though total sales in 2011 were greater than 2012, 2011 had less customers

| Year | Total Customers |
|------|-----------------|
| 2013 | 17,427 |
| 2012 | 3,255 |
| 2011 | 2,216 |
| 2014 | 834 |
| 2010 | 14 |

Total orders:
This displayed a year on year increase and spiked in 2013

| Year | Total Orders |
|------|--------------|
| 2013 | 21,287 |
| 2012 | 3,269 |
| 2011 | 2,216 |
| 2014 | 871 |
| 2010 | 14 |

Total quantity:
The results are as follows:

| Year | Total Quantity |
|------|----------------|
| 2013 | 52,807 |
| 2012 | 3,397 |
| 2011 | 2,216 |
| 2014 | 1,970 |
| 2010 | 14 |

The trend here is similar to other high level metrics i.e spiking in 2013


CUMULATIVE ANALYSIS
Rolling sum:
The rolling sum gives an idea of the change in sales every month and tells a similar story to the total sales.
From january to december ever year is a fairly straight line meaning a fairly linear sales function.
From january - december 2013 has the greatest slope meaning that the month to month change in sales was the greatest during that period.
This tallies with 2013 having the largest sales numbers.

Moving Average:
Moving averages are good for identifying underlying trends when there are fluctuations.
In this instance, it shows that the 3-month average in 2011 and 2012 were relatively flat
This means that as the year went on the genral monthly trend averages to a  


PERFORMANCE ANALYSIS


