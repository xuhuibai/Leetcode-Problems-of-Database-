WITH cte AS (
    SELECT id, day = 1, login_date FROM Logins
    UNION ALL
    SELECT l.id, c.day+1, l.login_date FROM
        cte AS c
    INNER JOIN
        Logins AS l
    ON c.id = l.id AND DATEADD(day, 1, c.login_date) = l.login_date
    )
    
    SELECT * FROM Accounts
    WHERE id IN (SELECT id FROM cte WHERE day = 5)
    ORDER BY id
    