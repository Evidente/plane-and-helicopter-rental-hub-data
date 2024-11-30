SELECT
    flights_origin_and_destination,
    average_distance_miles
FROM
    (SELECT
            aircraft_origin.full_name  || ' to ' || aircraft_destination.full_name  AS flights_origin_and_destination,
            AVG(CASE WHEN (flights.distance  > 0) THEN flights.distance  ELSE NULL END) AS average_distance_miles,
            AVG(CASE WHEN (flights.distance  > 0) THEN flights.distance  ELSE NULL END) AS average_distance_miles_0
        FROM `cloud-training-demos.looker_flights.flights`  AS flights
LEFT JOIN `cloud-training-demos.looker_flights.airports`  AS aircraft_origin ON flights.origin = (rtrim(aircraft_origin.code))
LEFT JOIN `cloud-training-demos.looker_flights.airports`  AS aircraft_destination ON flights.destination = (rtrim(aircraft_destination.code))
        GROUP BY
            1
        HAVING average_distance_miles_0 > 0) AS t2
ORDER BY
    2
LIMIT 7
