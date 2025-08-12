-- SQLite
SELECT user_id, page_version
FROM page_views
WHERE view_timestamp = (
    SELECT MIN(view_timestamp)
    FROM page_views AS pv2
    WHERE pv2.user_id = page_views.user_id
);
