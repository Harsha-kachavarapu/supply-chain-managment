-- Determine how each product's demand varies across different customers.

SELECT 
	customer_id,
    product_id,
	SUM(unit_quantity) AS total_orders_per_product
FROM
    order_details
GROUP BY product_id , customer_id
ORDER BY total_orders_per_product DESC;