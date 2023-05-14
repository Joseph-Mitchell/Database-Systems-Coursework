SELECT MONTHNAME(departure_date) AS Month, CONCAT(first_name, ' ', last_name) AS Name, 
	SUM(DATEDIFF(return_date, departure_date)) AS Days, SUM(DATEDIFF(return_date, departure_date)) - 22 AS Bonus_days 
FROM driver
	JOIN trip ON driver.employee_no = trip.employee_no
GROUP BY Month, Name
HAVING Days > 22
ORDER BY MONTH(departure_date), Days DESC;