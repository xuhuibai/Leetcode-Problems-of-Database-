WITH cte AS
    (SELECT a.seller_id, b.item_brand AS second_sell, a.sec_sell FROM
        (SELECT 
            order_date, 
            item_id, 
            seller_id,
            rank() OVER(PARTITION BY seller_id ORDER BY order_date) AS sec_sell
         FROM Orders
         WHERE seller_id IN (SELECT seller_id FROM Orders GROUP BY seller_id HAVING count(seller_id) > 1)
         ) a
     LEFT JOIN Items b 
     ON a.item_id = b.item_id
     WHERE a.sec_sell = 2
    ),
    
    compare AS 
    (SELECT a.user_id, 
            a.favorite_brand, 
            b.second_sell,
            CASE WHEN a.favorite_brand = b.second_sell THEN 'yes'
            ELSE 'no' END AS `2nd_item_fav_brand`
     FROM Users a LEFT JOIN cte b ON a.user_id = b.seller_id
    )
    
    SELECT user_id AS seller_id, `2nd_item_fav_brand` from compare ORDER BY seller_id 
