-- Most Expensive Routes: Find the top 3 most expensive freight routes based on historical data.

SELECT 
    origin_port,
    destination_port,
    (ROUND(SUM(min_cost + (cost_per_unit_weight * min_weight)),2)) AS cost_per_route
FROM
    freightrates
GROUP BY origin_port , destination_port
ORDER BY cost_per_route DESC
LIMIT 3;