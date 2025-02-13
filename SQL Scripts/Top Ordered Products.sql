-- Identify the top 5 products with the highest order volume.

WITH cte AS (SELECT 
				 product_id, COUNT(1) AS Total_orders_per_product, rank() over(order by count(1) desc) as rnk
			FROM
				order_details
			GROUP BY product_id)

SELECT 
    cte.rnk, cte.product_id, cte.Total_orders_per_product
FROM
    cte
WHERE
    rnk BETWEEN 1 AND 5;