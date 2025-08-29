-- CREATE ALL THE TABLES I NEED AND THE SCHEMAS
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    signup_date TEXT,
    country TEXT
);

CREATE TABLE page_views (
    view_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    page_version TEXT,
    view_timestamp TEXT
);

CREATE TABLE purchases (
    purchase_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    purchase_amount REAL,
    purchase_timestamp TEXT
);

-- SHOWS EACH USERS' FIRST PAGE VERSION THEY VIEWED. 
-- ASSIGNS EACH USER TO THEIR EXPERIMENT GROUP 
WITH ab_groups AS (
    SELECT user_id, page_version
    FROM page_views
    WHERE view_timestamp = (
        SELECT MIN(view_timestamp)
        FROM page_views AS pv2
        WHERE pv2.user_id = page_views.user_id
    )
),
conversions AS (
    SELECT user_id, COUNT(*) AS num_purchases
    FROM purchases
    GROUP BY user_id
)

SELECT 
    g.page_version,
    COUNT(DISTINCT g.user_id) AS total_users,
    COUNT(DISTINCT c.user_id) AS converted_users,
    ROUND(COUNT(DISTINCT c.user_id) * 1.0 / COUNT(DISTINCT g.user_id), 4) AS conversion_rate
FROM ab_groups g
LEFT JOIN conversions c ON g.user_id = c.user_id
GROUP BY g.page_version;


