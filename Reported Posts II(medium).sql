SELECT ROUND(AVG(num_removed/num_reported)*100,2) AS average_daily_percent FROM
    (SELECT 
        SUM(CASE WHEN post_id IN (SELECT post_id FROM Removals) THEN 1 ELSE 0 END) AS num_removed,
        count(*) AS num_reported,
        action_date
    FROM (
        SELECT 
            DISTINCT post_id, action_date 
        FROM Actions 
        WHERE (action, extra) = ('report', 'spam')
        )b
    GROUP BY action_date
    ) a
    