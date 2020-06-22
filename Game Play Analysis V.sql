WITH 
    first_install AS
    (
    SELECT 
        player_id, 
        MIN(event_date) AS install_dt 
    FROM Activity
    GROUP BY player_id),
    
    retention AS
    (SELECT a.player_id, a.install_dt 
     FROM
        first_install AS a
     JOIN
        activity AS b
     ON 
        a.player_id = b.player_id AND DATE_ADD(a.install_dt, INTERVAL 1 DAY) = b.event_date   
    )
    
    SELECT a.install_dt, a.installs, ROUND(IFNULL(b.retended/a.installs, 0),2) AS Day1_retention
    FROM
        (
        SELECT 
            install_dt, 
            COUNT(player_id) AS installs 
        FROM first_install 
        GROUP BY install_dt
        ) a
    LEFT JOIN 
        (
        SELECT 
            install_dt, 
            COUNT(player_id) AS retended
        FROM retention 
        GROUP BY install_dt
        ) b
    ON a.install_dt = b.install_dt
    