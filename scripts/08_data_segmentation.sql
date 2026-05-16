--==================================================================================================================
/* Data Segmentation: 
 by taking one measure we can aggregate/segment the data to e.g. Low/High rank/customers/sales
 By using CASE/WHEN statemnt we can create segments.
 Usage: If there are not enough dimensions in the dataset to create insights we take one of the measures and segment the data with CASE/WHEN to derive insoghts*/
--==================================================================================================================

-- Segment products into cost ranges and count ho many products fall into each segment
WITH product_segments AS(
SELECT
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_segment
FROM gold.dim_products)

SELECT
	cost_segment,
	COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_segment
ORDER BY total_products DESC;

/* Group customers into three segments based on their spending behavior:
﻿﻿	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- ﻿Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- ﻿﻿New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
WITH customer_segment AS(
SELECT
	*,
	CASE
		WHEN lifespan > 12 AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan > 12 AND total_sales <= 5000 THEN 'Regular'
		WHEN lifespan < 12 THEN 'New'
	END AS customer_segments
FROM(
SELECT
	c.customer_key,
	SUM(f.sales_amount) AS total_sales,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.dim_customers c
LEFT JOIN gold.fact_sales f
ON c.customer_key = f.customer_key
GROUP BY c.customer_key
)t)


SELECT
	customer_segments,
	COUNT(*) AS customers_number
FROM customer_segment
WHERE customer_segments IS NOT NULL
GROUP BY customer_segments
ORDER BY customers_number DESC
