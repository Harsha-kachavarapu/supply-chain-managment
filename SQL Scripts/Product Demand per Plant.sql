-- Product Demand per Plant: Identify the top 5 most ordered products from each plant.

WITH cte AS (SELECT 
				od.product_id,
				COUNT(od.product_id) AS orders_per_product,
				pp.plant_code,
				RANK() OVER (PARTITION BY pp.plant_code ORDER BY COUNT(od.product_id) DESC) AS rnk
			FROM
				order_details od
					JOIN
				products_per_plant pp ON od.product_id = pp.product_id
			GROUP BY pp.plant_code , od.product_id)
            
SELECT
    cte.plant_code,
    cte.product_id,
    cte.orders_per_product,
    cte.rnk
FROM
    cte
WHERE
    cte.rnk BETWEEN 1 AND 5;