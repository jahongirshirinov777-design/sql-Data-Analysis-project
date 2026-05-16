--==============================================================================
-- Measure Exploration: SUM(), AVG(), COUNT(), etc.
--==============================================================================

-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales -- 60k items generated almost 30mln sales

-- Find the average selling price
SELECT AVG(price) AS average_price FROM gold.fact_sales

-- Find the Total number of Orders
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales -- to get the actual order number we use DISTINCT

--Find the Total number of Products
SELECT COUNT(DISTINCT product_key) AS total_products FROM gold.fact_sales

--Find the Total number of Customers
SELECT COUNT(customer_key) AS total_customers FROM gold.fact_sales

--Find the Total number of Customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales


--Generate a Report that shows all key metrics of the business
DECLARE @start Datetime, @end Datetime
	SET @start = GETDATE()
		SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
		UNION ALL
		SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales -- 60k items generated almost 30mln sales
		UNION ALL
		SELECT 'Average Price', AVG(price) FROM gold.fact_sales
		UNION ALL
		SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales -- to get the actual order number we use DISTINCT
		UNION ALL
		SELECT 'Total Nr. Products', COUNT(DISTINCT product_key) AS total_products FROM gold.fact_sales
		UNION ALL
		SELECT 'Total Customers', COUNT(customer_key) AS total_customers FROM gold.fact_sales
	SET @end = GETDATE()
PRINT 'Load Time: ' + CAST(DATEDIFF(second, @start, @end) AS NVARCHAR) + ' seconds'
