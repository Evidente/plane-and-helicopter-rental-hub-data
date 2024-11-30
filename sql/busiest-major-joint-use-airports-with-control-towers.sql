--Flights
SELECT
    aircraft_origin.city  AS aircraft_origin_city,
    aircraft_origin.state  AS aircraft_origin_state,
    rtrim(aircraft_origin.code)  AS aircraft_origin_code,
    COUNT(*) AS flights_count
FROM `cloud-training-demos.looker_flights.flights`  AS flights
LEFT JOIN `cloud-training-demos.looker_flights.airports`  AS aircraft_origin ON flights.origin = (rtrim(aircraft_origin.code))
GROUP BY
    1,
    2,
    3
ORDER BY
    4 DESC
LIMIT 10

--Airports
SELECT
    airports.state  AS airports_state,
    airports.city  AS airports_city,
    rtrim(airports.code)  AS airports_code
FROM `cloud-training-demos.looker_flights.airports`  AS airports
WHERE (airports.cntl_twr = TRUE ) AND (airports.joint_use = "Y" ) AND (airports.major = TRUE )
GROUP BY
    1,
    2,
    3
ORDER BY
    1
LIMIT 10
