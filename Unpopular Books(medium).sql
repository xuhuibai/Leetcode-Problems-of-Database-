WITH candidate_book AS
    (SELECT *
     FROM Books 
     WHERE TIMESTAMPDIFF(MONTH,available_from,'2019-06-23') >= 1
    ), 
    
    last_year AS
    (SELECT *
    FROM Orders
    WHERE TIMESTAMPDIFF(DAY,dispatch_date,'2019-06-23') <= 365
    )
    
    SELECT 
        a.book_id,
        a.name
    FROM candidate_book a
    LEFT JOIN last_year b
    ON a.book_id = b.book_id
    GROUP BY a.book_id
    HAVING IFNULL(SUM(b.quantity),0) < 10
    ORDER BY a.book_id