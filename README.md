# Simulating AB Testing using SQL

## got dataframes, put them into SQL database and then wrote queries. After getting the final table which looks like this ___ , I saved it as a csv file and loaded it up in python to run a hypothesis test to determine if the difference in conversion rate was just due to chance. The results showed that ___ , indicating that version A and version B didn't differ in performance.


# 📊 A/B Testing Analysis: Conversion Rate Experiment

## 📌 Project Overview
This project analyzes an A/B test to determine whether different webpage versions led to statistically significant differences in user conversion rates.  

I used **SQLite** for data storage and querying, and **Python** for hypothesis testing and visualization.  
The workflow demonstrates an **end-to-end data analysis pipeline**: from database setup to statistical inference.

---

## ⚙️ Tools & Skills
- **SQL (SQLite, DB Browser)**: Data loading, cleaning, and aggregation  
- **SQL Queries**: Common Table Expressions (CTEs), JOINs, aggregations  
- **Python (Pandas, NumPy, SciPy, Statsmodels)**: Hypothesis testing, statistical analysis  
- **Visualization**: Matplotlib, Seaborn  
- **Statistical Methods**: A/B testing, two-proportion z-test, p-values, confidence intervals  

---

## 📂 Data Setup
1. **Load CSV files into SQLite database**  
   - Used **DB Browser for SQLite** to import raw CSV data (`page_views.csv`, `purchases.csv`, `users.csv`, etc.) into database tables.  
   - Ensured correct datatypes (e.g., text in quotes, timestamps as `TEXT` or `DATETIME`, numeric as `INTEGER`).  

2. **Explore tables** in DB Browser:
   ```sql
   SELECT * FROM page_views LIMIT 5;
   SELECT * FROM purchases LIMIT 5;

## Queries

1. Assign Users to A/B Groups:
    ```sql
    WITH ab_groups AS (
        SELECT user_id, page_version
        FROM page_views
        WHERE view_timestamp = (
            SELECT MIN(view_timestamp)
            FROM page_views AS pv2
            WHERE pv2.user_id = page_views.user_id
        )
    )
    ```

2. Count Conversions:
    ```sql
    conversions AS (
        SELECT user_id, COUNT(*) AS num_purchases
        FROM purchases
        GROUP BY user_id
    )
    ```

3. Compute Conversion Rates:
    ```sql
    SELECT 
        g.page_version,
        COUNT(DISTINCT g.user_id) AS total_users,
        COUNT(DISTINCT c.user_id) AS converted_users,
        ROUND(COUNT(DISTINCT c.user_id) * 1.0 / COUNT(DISTINCT g.user_id), 4) AS conversion_rate
    FROM ab_groups g
    LEFT JOIN conversions c ON g.user_id = c.user_id
    GROUP BY g.page_version;
    ```

### Output

In the output we have:

- the page_version (A or B)
- total_users in each group
- converted_users (those who made a purchase)
- conversion_rate (converted / total)

___ insert photo of the dataframe outputted

## Export Results

## Hypothesis Testing in Python

## Visualiztion

## Key Insights

## Takeaway

