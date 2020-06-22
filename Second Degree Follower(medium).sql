SELECT 
    f.followee AS follower,
    COUNT(DISTINCT follower) AS num
FROM follow f
GROUP BY f.followee
HAVING f.followee IN (SELECT DISTINCT follower FROM follow)
ORDER BY f.followee