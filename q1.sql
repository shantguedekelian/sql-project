-- SQLite
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