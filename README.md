# A/B Testing Analysis: Conversion Rate Experiment

## Project Overview
This project analyzes an A/B test to determine whether different webpage versions led to statistically significant differences in user conversion rates.  

I used **SQLite** for data storage and querying, and **Python** for hypothesis testing and visualization.  
The workflow demonstrates an **end-to-end data analysis pipeline**: from database setup to statistical inference.

---

## Tools & Skills
- **SQL (SQLite, DB Browser)**: Data loading, cleaning, and aggregation  
- **SQL Queries**: Common Table Expressions (CTEs), JOINs, aggregations  
- **Python (Pandas, NumPy, SciPy, Statsmodels)**: Hypothesis testing, statistical analysis  
- **Visualization**: Matplotlib, Seaborn  
- **Statistical Methods**: A/B testing, two-proportion z-test, p-values, confidence intervals  

---

## Data Setup
1. **Load CSV files into SQLite database**  
   - Used **DB Browser for SQLite** to import raw CSV data (`page_views.csv`, `purchases.csv`, `users.csv`, etc.) into database tables.  
   - Ensured correct datatypes (e.g., text in quotes, timestamps as `TEXT` or `DATETIME`, numeric as `INTEGER`).  

2. **Explore tables** in DB Browser:
    ```sql
   SELECT * FROM page_views LIMIT 5;
   SELECT * FROM purchases LIMIT 5;
    ```
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

## Export Results

- Exported query results as CSV from DB Browser.
- Below is the resulting dataframing

|    | page_version   |   total_users |   converted_users |   conversion_rate |
|---:|:---------------|--------------:|------------------:|------------------:|
|  0 | A              |           494 |               156 |            0.3158 |
|  1 | B              |           506 |               157 |            0.3103 |

## Hypothesis Testing in Python

Performed a **two-proportion z-test** to determine if the observed difference was statistically significant.

```python
import pandas as pd
from statsmodels.stats.proportion import proportions_ztest

# Total users, and converted users
n_A, x_A = 494, 156   # Group A
n_B, x_B = 500, 157    # Group B

# Successes and trials
successes = [x_A, x_B]
samples = [n_A, n_B]

# Run z-test
z_stat, p_val = proportions_ztest(successes, samples)

print("Z-statistic:", z_stat)
print("P-value:", p_val)
```

- Null Hypothesis (H₀): Conversion rates are equal between A and B
- Alternative Hypothesis (H₁): Conversion rates differ between A and B
- Reject H₀ if p-value < 0.05

## Visualiztion

Created simple bar plots of conversion rates for A vs B.

```python
import matplotlib.pyplot as plt

labels = ['Group A', 'Group B']
conversion_rates = [x_A/n_A, x_B/n_B]

plt.bar(labels, conversion_rates, color=['skyblue', 'orange'])
plt.title("Conversion Rates by Group")
plt.ylabel("Conversion Rate")
plt.show()
```

## Key Insights

- Group A conversion rate: 0.316%
- Group B conversion rate: 0.310%
- P-value: 0.85 (not significant)
- Interpretation: The results show that there is no significant difference in conversion rates between version A and B.

## Takeaway

- Integrated SQL querying + Python statistical testing
- Built an end-to-end experiment analysis workflow
- Applied real-world data science skills: database management, hypothesis testing, visualization, and business interpretation
