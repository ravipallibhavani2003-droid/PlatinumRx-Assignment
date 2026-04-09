SELECT sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel; 

SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10; 

SELECT 
    r.month,
    r.revenue,
    e.expense,
    (r.revenue - e.expense) AS profit,
    CASE 
        WHEN (r.revenue - e.expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM (
    SELECT DATE_FORMAT(datetime, '%Y-%m') AS month,
           SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
) r
JOIN (
    SELECT DATE_FORMAT(datetime, '%Y-%m') AS month,
           SUM(amount) AS expense
    FROM expenses
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
) e
ON r.month = e.month;

SELECT city, cid, profit
FROM (
    SELECT c.city, cs.cid,
           SUM(cs.amount) - IFNULL(SUM(e.amount),0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.city, cs.cid
) t1
WHERE profit = (
    SELECT MAX(profit)
    FROM (
        SELECT c.city, cs.cid,
               SUM(cs.amount) - IFNULL(SUM(e.amount),0) AS profit
        FROM clinic_sales cs
        JOIN clinics c ON cs.cid = c.cid
        LEFT JOIN expenses e ON cs.cid = e.cid
        GROUP BY c.city, cs.cid
    ) t2
    WHERE t2.city = t1.city
);


SELECT state, cid, profit
FROM (
    SELECT c.state, cs.cid,
           SUM(cs.amount) - IFNULL(SUM(e.amount),0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    GROUP BY c.state, cs.cid
) t1
WHERE profit = (
    SELECT DISTINCT profit
    FROM (
        SELECT c.state, cs.cid,
               SUM(cs.amount) - IFNULL(SUM(e.amount),0) AS profit
        FROM clinic_sales cs
        JOIN clinics c ON cs.cid = c.cid
        LEFT JOIN expenses e ON cs.cid = e.cid
        GROUP BY c.state, cs.cid
    ) t2
    WHERE t2.state = t1.state
    ORDER BY profit ASC
    LIMIT 1 OFFSET 1
);
