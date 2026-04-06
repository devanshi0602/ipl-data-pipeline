WITH deliveries AS (
    SELECT * FROM {{ ref('stg_deliveries') }}
)

SELECT
    batsman,
    COUNT(DISTINCT match_id)              AS matches,
    SUM(batsman_runs)                     AS total_runs,
    MAX(batsman_runs)                     AS highest_score,
    ROUND(AVG(batsman_runs), 2)           AS avg_runs_per_ball,
    SUM(CASE WHEN batsman_runs = 4 THEN 1 ELSE 0 END) AS fours,
    SUM(CASE WHEN batsman_runs = 6 THEN 1 ELSE 0 END) AS sixes,
    ROUND(SUM(batsman_runs) / NULLIF(
        SUM(CASE WHEN dismissal_kind != 'not_out' THEN 1 ELSE 0 END), 0
    ), 2)                                 AS batting_average
FROM deliveries
GROUP BY batsman
HAVING total_runs > 500
ORDER BY total_runs DESC