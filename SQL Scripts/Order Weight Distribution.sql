-- Order Weight Distribution:
-- Analyze the distribution of order weights and
-- identify the most common weight range for shipments.

SELECT
CASE
WHEN weight*unit_quantity BETWEEN 0 AND 50 THEN '0-50 kg'
WHEN weight*unit_quantity BETWEEN 51 AND 100 THEN '51-100 kg'
WHEN weight*unit_quantity BETWEEN 101 AND 200 THEN '101-200 kg'
WHEN weight*unit_quantity BETWEEN 201 AND 500 THEN '201-500 kg'
ELSE '500+ kg'
END AS weight_range,
COUNT(*) AS order_count
FROM order_details
GROUP BY weight_range
ORDER BY order_count DESC;