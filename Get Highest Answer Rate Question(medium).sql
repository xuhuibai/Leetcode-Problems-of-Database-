SELECT question_id AS survey_log FROM
    (SELECT a.question_id, a.num_ask, b.num_answer,0
    FROM
        (SELECT question_id, COUNT(action) AS num_ask
        FROM survey_log
        WHERE action = "show"
        GROUP BY question_id) a
    LEFT JOIN
        (SELECT question_id, COUNT(action) AS num_answer
        FROM survey_log
        WHERE action = "answer"
        GROUP BY question_id) b
    ON a.question_id = b.question_id) c
ORDER BY (num_answer/num_ask) DESC
LIMIT 1;