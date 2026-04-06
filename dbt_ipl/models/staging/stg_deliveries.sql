WITH source AS (
    SELECT * FROM {{ source('raw', 'deliveries') }}
)

SELECT
    CAST(match_id AS INT64)                    AS match_id,
    CAST(inning AS INT64)                      AS inning,
    batting_team,
    bowling_team,
    CAST(over AS INT64)                        AS over_number,
    CAST(ball AS INT64)                        AS ball_number,
    batsman,
    non_striker,
    bowler,
    CAST(batsman_runs AS INT64)                AS batsman_runs,
    CAST(extra_runs AS INT64)                  AS extra_runs,
    CAST(total_runs AS INT64)                  AS total_runs,
    COALESCE(player_dismissed, 'not_out')      AS player_dismissed,
    COALESCE(dismissal_kind, 'not_out')        AS dismissal_kind
FROM source