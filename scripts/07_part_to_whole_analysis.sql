--========================
-- Part-to-Whole Analysis
--========================

-- Which categories contribute the most to overall sales?
-- We need to calculate the percentage

-- with CTE
WITH category_sales AS(
SELECT
	p.category,
	SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER()) * 100, 2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC

-- with Sub Function
SELECT
	*,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/ SUM(total_sales) OVER()) * 100, 2), '%' ) AS percentage_change 
FROM(
SELECT
	p.category,
	SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category)t
ORDER BY percentage_change DESC;
