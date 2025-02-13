-- Stock Availability Check:
-- Compare ordered quantities with available stock per plant and
-- identify cases where demand exceeds supply.

SELECT
od.plant_code, COUNT(1) AS num_of_orders, wh. order_capacity
FROM
order_details od
JOIN
whcapacities wh ON od.plant_code = wh.plant_code
GROUP BY plant_code , Wh. order_capacity
HAVING num_of_orders > wh. order_capacity;