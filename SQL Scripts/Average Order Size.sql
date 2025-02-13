-- Calculate the average order quantity per customer and 
-- categorize them into small, medium, and large order sizes.

WITH cte AS (
    SELECT 
        customer_id,
        ROUND(SUM(unit_quantity) / COUNT(order_id), 0) AS avg_order_quan_per_cx,
        NTILE(3) OVER (ORDER BY ROUND(SUM(unit_quantity) / COUNT(order_id), 0) ASC) AS size
    FROM order_details
    GROUP BY customer_id
)
SELECT 
    customer_id, 
    avg_order_quan_per_cx,
    CASE 
        WHEN size = 1 THEN 'Small'
        WHEN size = 2 THEN 'Medium'
        WHEN size = 3 THEN 'Large'
    END AS category
FROM cte;