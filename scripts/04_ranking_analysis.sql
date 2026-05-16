--==============================================================================
-- Ranking Analysis: e.g. Ranking Top/Low achievers
--==============================================================================

-- Which 5 products generate the highest revenue?
SELECT TOP 5
	dp.product_name,
	SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_products AS dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC;

-- With Window Function
SELECT*
FROM (
	SELECT 
		dp.product_name,
		SUM(fs.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(fs.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales AS fs
	INNER JOIN gold.dim_products AS dp
	ON fs.product_key = dp.product_key
	GROUP BY dp.product_name)t
WHERE rank_products <= 5;

-- Which are the 5 worst-performing products in terms of sales?
SELECT TOP 5
	dp.product_name,
	SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_products AS dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue;
