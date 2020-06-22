WITH 
    CTE AS
    (SELECT * FROM
                (SELECT 
                    fail_date AS date,
                    'failed' AS result
                FROM Failed
                UNION ALL
                SELECT 
                    success_date AS date,
                    'succeeded' AS result
                FROM Succeeded) t
    WHERE date BETWEEN '2019-01-01' AND '2019-12-31'
    ORDER BY date)

SELECT 
    result AS period_state,
    min(date) AS start_date,
    max(date) AS end_date
FROM
    (SELECT 
        result,
        date,
        (DAYOFYEAR(date) - row_number() OVER(partition by result order by date)) AS period 
    FROM CTE) t
GROUP BY period, result
ORDER BY start_date