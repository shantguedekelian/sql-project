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
SELECT user_id, page_version
FROM page_views
WHERE view_timestamp = (
    SELECT MIN(view_timestamp)
    FROM page_views AS pv2
    WHERE pv2.user_id = page_views.user_id
);
