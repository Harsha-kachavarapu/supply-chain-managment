-- Optimal Plant Selection: Find the cheapest plant to fulfill each product order based on freight costs

WITH PlantFreight AS (
    SELECT 
        pp.product_id, 
        pp.plant_code, 
        fr.origin_port,
        fr.destination_port,
        fr.min_cost + (fr.cost_per_unit_weight * fr.min_weight) AS total_freight_cost,
        ROW_NUMBER() OVER (PARTITION BY pp.product_id ORDER BY fr.min_cost + (fr.cost_per_unit_weight * fr.min_weight) ASC) AS rnk
    FROM products_per_plant pp
    JOIN plant_ports pp_ports ON pp.plant_code = pp_ports.plant_code
    JOIN freightrates fr ON pp_ports.port_id = fr.origin_port
)
SELECT 
    distinct plant_code AS cheapest_plant
FROM PlantFreight
WHERE rnk = 1;