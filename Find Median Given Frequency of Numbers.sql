SELECT SUM(Number) / (COUNT(Number) + 0.0) AS median
FROM (SELECT Number, Frequency,
SUM(Frequency) OVER (ORDER BY Number) AS cumulative_num,
SUM(Frequency) OVER () AS total_num
FROM Numbers) sub
WHERE total_num / 2.0 BETWEEN cumulative_num - Frequency AND cumulative_num