WITH rankk AS (
    SELECT 
    *, 
    RANK() OVER(PARTITION BY username ORDER BY startDate DESC) AS ranking,
    COUNT(*) OVER(PARTITION BY username) AS total
    FROM UserActivity
    )
SELECT username,activity,startDate,endDate FROM rankk
WHERE (
    CASE
        WHEN total = 1 THEN ranking = 1
        WHEN total > 1 THEN ranking = 2
    END) 
ORDER BY username