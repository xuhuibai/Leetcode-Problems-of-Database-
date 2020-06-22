SELECT round(count(m.player_id)/(select count(distinct player_id) from activity), 2) AS fraction
FROM(
SELECT 
    a.player_id, 
    a.event_date, 
    DATE_ADD(b.firstday, INTERVAL 1 DAY) AS DAY2
FROM 
    activity a 
LEFT JOIN
    (SELECT 
        player_id, 
        MIN(event_date) AS firstday 
     FROM activity GROUP BY player_id
    ) b 
ON a.player_id = b.player_id) m
WHERE m.event_date = m.day2;