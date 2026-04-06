WITH match_results AS (
    SELECT * FROM {{ ref('match_results') }}
),

team_wins AS (
    SELECT season, winner AS team, COUNT(*) AS wins
    FROM match_results
    WHERE winner IS NOT NULL
    GROUP BY season, winner
),

team_played AS (
    SELECT season, team1 AS team FROM match_results
    UNION ALL
    SELECT season, team2 AS team FROM match_results
),

team_totals AS (
    SELECT season, team, COUNT(*) AS matches_played
    FROM team_played
    GROUP BY season, team
)

SELECT
    t.season,
    t.team,
    t.matches_played,
    COALESCE(w.wins, 0)                                     AS wins,
    t.matches_played - COALESCE(w.wins, 0)                 AS losses,
    ROUND(COALESCE(w.wins, 0) / t.matches_played * 100, 1)  AS win_percentage
FROM team_totals t
LEFT JOIN team_wins w USING (season, team)
ORDER BY season, win_percentage DESC