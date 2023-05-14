SELECT make, m.model, registration, COUNT(trip_id) AS trips 
FROM model m
	JOIN vehicle v ON m.model = v.model
	JOIN trip t ON v.vehicle_id = t.vehicle_id
GROUP BY make, model, registration
ORDER BY trips
LIMIT 5;