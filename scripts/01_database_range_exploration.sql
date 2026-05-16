--==============================================================================
-- Object Exploration: Tables, Columns, DISTINCT values, etc.
--==============================================================================

-- Explore All Objects in the Database
SELECT*FROM INFORMATION_SCHEMA.TABLES 

-- Explore All Columns in the Database
SELECT*FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

-- Explore All Countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories "The Major Divisions"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3

--==============================================================================
-- Date Exploration: Boundaries, time span, oldest/youngest customer etc.
--==============================================================================

-- Find the date of the first and last order
SELECT 
	MIN(order_date) first_order_date,
	MAX(order_date) last_order_date,
	DATEDIFF(year/*or month*/, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Find the youngest and oldest customer
SELECT
	MIN(birthdate) AS oldest_customer,
	MAX(birthdate) AS youngest_customer,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_customer,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_customer
	--DATEDIFF(year, birthdate, GETDATE()) AS customer_age
FROM gold.dim_customers
