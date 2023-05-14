SELECT trip_id, 
CONCAT(ROUND(SUM(CASE
	WHEN category = "A" THEN 1
	ELSE 0
END) / COUNT(trip_id) * 100), "%") AS A,
CONCAT(ROUND(SUM(CASE
	WHEN category = "B" THEN 1
	ELSE 0
END) / COUNT(trip_id) * 100), "%") AS B,
CONCAT(ROUND(SUM(CASE
	WHEN category = "C" THEN 1
	ELSE 0
END) / COUNT(trip_id) * 100), "%") AS C
FROM manifest
WHERE trip_id IN (SELECT trip_id FROM manifest WHERE category = "C")
GROUP BY trip_id
ORDER BY ROUND(SUM(CASE
	WHEN category = "C" THEN 1
	ELSE 0
END) / COUNT(trip_id) * 100) DESC;