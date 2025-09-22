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