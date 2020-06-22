SELECT student_id, student_name FROM Student
 WHERE student_id NOT IN (SELECT 
    student_id 
FROM exam 
WHERE (exam_id, score) IN (
    SELECT 
        exam_id, MAX(score) AS score 
    FROM exam 
    GROUP BY exam_id
    )
UNION ALL
SELECT 
    student_id 
FROM exam 
WHERE (exam_id, score) IN (
    SELECT 
        exam_id, MIN(score) AS score 
    FROM exam 
    GROUP BY exam_id
    )
 )
 AND student_id IN (SELECT student_id FROM Exam)
