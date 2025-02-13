-- Plant Demand Analysis:
-- Identify which plants fulfill the highest number of unique product orders and 
-- analyze their contribution to overall supply chain efficiency.

WITH PlantProductOrders AS (
    SELECT
        plant_code, 
        COUNT(DISTINCT product_id) AS unique_products_fulfilled,
        COUNT(order_id) AS total_orders
    FROM order_details
    GROUP BY plant_code
)
SELECT
    plant_code, 
    total_orders,
    unique_products_fulfilled,
    ROUND((unique_products_fulfilled / SUM(unique_products_fulfilled) OVER()) *100, 2) AS contribution_percentage
FROM PlantProductOrders
ORDER BY unique_products_fulfilled DESC;