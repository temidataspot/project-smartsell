# 🛠 Phase 4: ETL Pipeline — Python to MySQL

This phase focused on establishing a seamless **ETL (Extract, Transform, Load)** pipeline from Python to MySQL. The goal was to enable scalable analytics, centralized data storage, and integration with BI tools such as Power BI or Tableau.

---

## 🔗 Database Connection & Data Upload

The ETL pipeline was built and tested using the [`sql_pipeline.py`](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%3A%20Python%20-%3E%20MySQL/py-sql%20pipeline.py)script. Key steps included:

- ✅ Establishing a secure MySQL connection using `SQLAlchemy`
- 📦 Creating a new database if it didn’t exist
- 📥 Loading cleaned **historical data**
- 📤 Uploading **forecasted data (2025–2027)** from saved CSV
- 🔁 Renaming column headers for SQL compatibility
- 🧪 Running SQL queries to test the pipeline and verify successful uploads
- 
  ![Testing Connection in SQL](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%3A%20Python%20-%3E%20MySQL/testconnection.png)

---

## 🧪 Key SQL Queries & Insights 

Check out ![SQL Query](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%3A%20Python%20-%3E%20MySQL/smartsell_analytics_query.sql)

### 📊 Average Sales by Year (Actual vs. Forecasted)

This query compares average weekly sales across historical and forecasted years, providing a high-level performance trajectory.
```sql
SELECT 
    Year,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Year;
```
---

### 🏆 Top 5 Stores by Forecasted Growth

Identifies stores projected to experience the greatest sales growth from 2025 to 2027.
```sql
WITH yearly_avg AS (
    SELECT 
        Store,
        Year,
        AVG(Weekly_Sales) AS AvgSales
    FROM forecasted_sales_2025_2027
    GROUP BY Store, Year
),
growth AS (
    SELECT
        Store,
        MAX(CASE WHEN Year = 2025 THEN AvgSales END) AS Sales2025,
        MAX(CASE WHEN Year = 2026 THEN AvgSales END) AS Sales2026,
        MAX(CASE WHEN Year = 2027 THEN AvgSales END) AS Sales2027,
        ROUND(((MAX(CASE WHEN Year = 2027 THEN AvgSales END) / MAX(CASE WHEN Year = 2025 THEN AvgSales END)) - 1) * 100, 2) AS GrowthPct
    FROM yearly_avg
    GROUP BY Store
)
SELECT *
FROM growth
ORDER BY GrowthPct DESC
LIMIT 5;
```
---
### Monthly Seasonal Pattern

```sql
SELECT 
    Month,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Month
ORDER BY FIELD(Month, 'January','February','March','April','May','June',
                             'July','August','September','October','November','December');
```

---
### 🎉 Holiday Impact Analysis

Analyzes differences in sales performance during holiday vs. non-holiday weeks.
```sql
SELECT 
    Holiday_Label,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Holiday_Label;
```
---

### 🚨 Outlier Detection: Top 10 Weeks

Extracts the 10 highest-sales weeks across the dataset, typically aligning with peak retail events.
```sql
SELECT Store, Dept, Year, Week_Number, Weekly_Sales
FROM forecasted_sales_2025_2027
ORDER BY Weekly_Sales DESC
LIMIT 10;
```
---

### 📉 Anomaly Detection (Z-Score Method)

Applies a basic Z-score method to flag statistically significant sales anomalies across departments.

```sql
WITH sales_stats AS (
    SELECT 
        Store, Dept, Year, Week_Number, Weekly_Sales,
        AVG(Weekly_Sales) OVER(PARTITION BY Store, Dept) AS avg_sales,
        STDDEV(Weekly_Sales) OVER(PARTITION BY Store, Dept) AS std_sales
    FROM forecasted_sales_2025_2027
),
z_scores AS (
    SELECT *,
        (Weekly_Sales - avg_sales) / std_sales AS z_score
    FROM sales_stats
)
SELECT *
FROM z_scores
WHERE ABS(z_score) > 3
ORDER BY z_score DESC;
```

---

### 📈 Forecast Accuracy Monitoring *(Planned)*

A placeholder SQL view for tracking model accuracy over time once actual 2025–2027 sales become available.
```sql
SELECT 
    h.Store, h.Dept,
    h.Weekly_Sales AS Actual,
    f.Weekly_Sales AS Forecasted,
    ROUND((f.Weekly_Sales - h.Weekly_Sales) / h.Weekly_Sales * 100, 2) AS ErrorPct
FROM history_df h
JOIN forecasted_sales_2025_2027 f
ON h.Store = f.Store AND h.Dept = f.Dept AND h.Week_Number = f.Week_Number
WHERE h.Year = 2024 AND f.Year = 2025;
```
---

## ✅ Summary

This phase connected the dots between **data science models** and **production-ready analytics infrastructure**. By consolidating both historical and forecasted sales in MySQL, we're now ready for:

- Real-time querying
- Dashboard integration
- Deeper business intelligence
