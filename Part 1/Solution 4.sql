SELECT registration 
FROM vehicle
	JOIN trip ON vehicle.vehicle_id = trip.vehicle_id
WHERE registration NOT IN 
	(SELECT registration FROM vehicle 
	JOIN trip ON vehicle.vehicle_id = trip.vehicle_id
	WHERE departure_date <= '2012-04-05'
	AND return_date >= '2012-04-01')
GROUP BY registration;