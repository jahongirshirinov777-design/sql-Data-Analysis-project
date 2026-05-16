--===============================================================================================
-- Performance Analysis: Comparing the results (e.g. current sales vs average or last year sales)
--===============================================================================================

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS(
SELECT
	YEAR(fs.order_date) AS order_year,
	dp.product_name,
	SUM(fs.sales_amount) AS current_sales
FROM gold.fact_sales fs
LEFT JOIN gold.dim_products dp
ON fs.product_key = dp.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(fs.order_date), dp.product_name
)
SELECT
	*,
	LAG(current_sales, 1, NULL) OVER(PARTITION BY product_name ORDER BY order_year) AS last_year_sales,
	current_sales - LAG(current_sales, 1, NULL) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_py,
	CASE	
		WHEN current_sales - LAG(current_sales, 1, NULL) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales, 1, NULL) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS py_change,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	CASE	
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
		ELSE 'Avg'
	END AS avg_change
FROM yearly_product_sales;
