SELECT aircraft_origin_city
	, aircraft_origin_state
	, flights_cancelled_count
	, flights_count
FROM (
	SELECT aircraft_origin.city AS aircraft_origin_city
		, aircraft_origin.STATE AS aircraft_origin_state
		, COUNT(CASE WHEN flights.cancelled THEN 1 ELSE NULL END) AS flights_cancelled_count
		, COUNT(*) AS flights_count
		, COUNT(*) AS flights_count_0
	FROM `cloud - training - demos.looker_flights.flights` AS flights
	LEFT JOIN `cloud - training - demos.looker_flights.airports` AS aircraft_origin ON flights.origin = (rtrim(aircraft_origin.code))
	GROUP BY 1
		, 2
	HAVING flights_count_0 > 10000
	) AS t2
ORDER BY 3 DESC LIMIT 500
