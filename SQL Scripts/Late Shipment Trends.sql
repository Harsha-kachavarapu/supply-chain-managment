-- Late Shipment Trends: Analyze which plants or 
-- warehouses cause the most shipping delays.

SELECT 
    plant_code AS Warehouse,
    COUNT(ship_late_day_count) AS Total_count_of_delays
FROM
    order_details
WHERE
    ship_late_day_count >= 1
GROUP BY plant_code
ORDER BY COUNT(ship_late_day_count) DESC;