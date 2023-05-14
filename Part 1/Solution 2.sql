SELECT reference, company_name, COUNT(DISTINCT t.trip_id) AS Pickups 
FROM manifest m
	JOIN customer c ON pickup_customer_ref = reference
	JOIN trip t ON m.trip_id = t.trip_id
WHERE MONTH(departure_date) = 6
GROUP BY reference, company_name
ORDER BY Pickups DESC
LIMIT 4;