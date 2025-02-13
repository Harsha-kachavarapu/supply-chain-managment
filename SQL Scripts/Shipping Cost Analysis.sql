-- Shipping Cost Analysis: Calculate the average freight cost per order for each warehouse

WITH OrderShipping AS (
					SELECT 
						od.order_id,
						pp.port_id AS origin_port,
						od.destination_port,
						od.weight,
						fr.min_cost,
						fr.cost_per_unit_weight,
						(fr.min_cost + (od.weight * fr.cost_per_unit_weight)) AS total_freight_cost
					FROM
						order_details od
							JOIN
						plant_ports pp ON od.plant_code = pp.plant_code
							JOIN
						freightrates fr ON pp.port_id = fr.origin_port
							AND od.destination_port = fr.destination_port
							AND od.weight BETWEEN fr.min_weight AND fr.max_weight)
SELECT 
    warehouse,
    ROUND(AVG(total_freight_cost), 2) AS avg_freight_cost_per_order
FROM
    OrderShipping
GROUP BY warehouse
ORDER BY avg_freight_cost_per_order DESC;