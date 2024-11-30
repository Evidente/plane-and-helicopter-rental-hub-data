SELECT *
FROM (
	SELECT 
        *, 
        DENSE_RANK() OVER (
			ORDER BY z___min_rank
			) AS z___pivot_row_rank, RANK() OVER (
			PARTITION BY z__pivot_col_rank ORDER BY z___min_rank
			) AS z__pivot_col_ordering, CASE WHEN z___min_rank = z___rank THEN 1 ELSE 0 END AS z__is_highest_ranked_cell
	FROM (
		SELECT *, MIN(z___rank) OVER (PARTITION BY CAST(airports_state AS STRING)) AS z___min_rank
		FROM (
			SELECT *, RANK() OVER (
					ORDER BY CASE WHEN z__pivot_col_rank = 1 THEN (CASE WHEN airports_count IS NOT NULL THEN 0 ELSE 1 END) ELSE 2 END, 
                             CASE WHEN z__pivot_col_rank = 1 THEN airports_count ELSE NULL END DESC, 
                             airports_count DESC, 
                             z__pivot_col_rank, airports_state
					) AS z___rank
			FROM (
				SELECT *, DENSE_RANK() OVER (
						ORDER BY CASE WHEN airports_facility_type IS NULL THEN 1 ELSE 0 END, 
                                 airports_facility_type
						) AS z__pivot_col_rank
				FROM (
					SELECT 
                        airports.fac_type AS airports_facility_type, 
                        airports.STATE AS airports_state, 
                        COUNT(*) AS airports_count
					FROM `cloud - training - demos.looker_flights.airports` AS airports
					GROUP BY 1, 2
					) ww
				) bb
			WHERE z__pivot_col_rank <= 16384
			) aa
		) xx
	) zz
WHERE (z__pivot_col_rank <= 50 OR z__is_highest_ranked_cell = 1) AND (z___pivot_row_rank <= 8 OR z__pivot_col_ordering = 1)
ORDER BY z___pivot_row_rank
