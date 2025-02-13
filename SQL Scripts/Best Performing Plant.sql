-- Best Performing Plant:
-- Identify the top 3 plants with the highest on-time delivery rate.

SELECT 
    plant_code, COUNT(*) AS total_count
FROM
    order_details
WHERE
    ship_late_day_count = 0
GROUP BY plant_code
LIMIT 3;