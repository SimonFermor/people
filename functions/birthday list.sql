SELECT month_name, 
	dayname(CONCAT('2025-', 
		lpad(cast(month_number as CHAR), 2, 0), '-',
		lpad(cast(day_of_month AS CHAR), 2, 0))) AS day_of_week,
			day_of_month,
	concat(known_name, ' ', last_name) AS full_name
FROM 
(SELECT MONTHNAME(p.date_of_birth) AS month_name,
	p.id, p.first_name, p.last_name,
	IFNULL(p.date_of_birth, 0) AS date_of_birth, 
	IFNULL(p.known_name, p.first_name) AS known_name,
	MONTH(p.date_of_birth) AS month_number,
	DAY(p.date_of_birth) AS day_of_month
FROM people.group_people AS g

INNER JOIN people.people AS p ON g.people_id = p.id

WHERE (g.group_id = 17) 
AND p.id NOT in (14,190)
AND p.date_of_birth IS NOT NULL) AS A
ORDER BY month_number, day_of_month, known_name