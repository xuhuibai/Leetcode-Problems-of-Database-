SELECT id, company, salary
FROM( 
    SELECT 
        a.*, 
        ROW_NUMBER() OVER(
            PARTITION BY a.Company
            ORDER BY a.Salary
            ) AS rank,
        b.count_id,
        b.count_id as count_id2
    FROM 
        Employee a
        left join
        (SELECT company, count(id) as count_id FROM employee GROUP BY Company) as b
        on a.company = b.company
    ) as t
WHERE 
    Rank = FLOOR((count_id + 1) / 2) OR Rank = FLOOR((count_id + 2) / 2)



