WITH source AS (
    SELECT * FROM {{ source('raw', 'matches') }}
)

SELECT
    CAST(id AS INT64)                          AS match_id,
    CAST(season AS INT64)                      AS season,
    city,
    PARSE_DATE('%Y-%m-%d', date)               AS match_date,
    team1,
    team2,
    toss_winner,
    toss_decision,
    winner,
    CAST(win_by_runs AS INT64)                 AS win_by_runs,
    CAST(win_by_wickets AS INT64)              AS win_by_wickets,
    player_of_match,
    venue
FROM source
WHERE id IS NOT NULL