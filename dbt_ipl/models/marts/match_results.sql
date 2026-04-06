WITH matches AS (
    SELECT * FROM {{ ref('stg_matches') }}
),

toss_analysis AS (
    SELECT
        match_id,
        CASE WHEN toss_winner = winner THEN TRUE ELSE FALSE END AS toss_winner_won_match
    FROM matches
)

SELECT
    m.match_id,
    m.season,
    m.match_date,
    m.city,
    m.venue,
    m.team1,
    m.team2,
    m.toss_winner,
    m.toss_decision,
    m.winner,
    m.win_by_runs,
    m.win_by_wickets,
    m.player_of_match,
    t.toss_winner_won_match,
    CASE
        WHEN m.win_by_runs > 0 THEN 'batting_first'
        ELSE 'chasing'
    END AS winning_style
FROM matches m
LEFT JOIN toss_analysis t USING (match_id)