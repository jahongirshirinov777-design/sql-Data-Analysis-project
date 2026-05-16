--============================================
-- Analysis of sales by date year/month/date
--============================================

-- Sales Analysis groupped by date/month/year 
SELECT
-- YEAR(order_date)  AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- With DATETRUNC() function
SELECT
DATETRUNC(YEAR, order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
ORDER BY DATETRUNC(YEAR, order_date)

-- If we want it in a different format
SELECT
FORMAT(order_date, 'yyyy-MMM') AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')

--============================================
-- Cumulative Analysis using Window Functions
--============================================

-- Calculate the total sales per month 
-- and the Running Total of sales over time (for each year [PARTITION BY])

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) AS moving_avg_price
FROM(
SELECT
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date))t;
