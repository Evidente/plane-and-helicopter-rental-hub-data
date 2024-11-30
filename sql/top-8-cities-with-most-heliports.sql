SELECT
    airports.city  AS airports_city,
    airports.state  AS airports_state,
    airports.fac_type  AS airports_facility_type,
    COUNT(*) AS airports_count
FROM `cloud-training-demos.looker_flights.airports`  AS airports
WHERE (airports.fac_type ) = 'HELIPORT      '
GROUP BY
    1,
    2,
    3
ORDER BY
    4 DESC
LIMIT 8
