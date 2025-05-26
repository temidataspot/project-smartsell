# compare avg sales by yr
SELECT 
    Year,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Year;

# Top 5 Stores by Forecasted Growth
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

# Monthly Seasonal Pattern
SELECT 
    Month,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Month
ORDER BY FIELD(Month, 'January','February','March','April','May','June',
                             'July','August','September','October','November','December');

# Holiday Impact
SELECT 
    Holiday_Label,
    ROUND(AVG(Weekly_Sales), 2) AS AvgSales
FROM forecasted_sales_2025_2027
GROUP BY Holiday_Label;

# Creating a Versioned History of Forecasts in SQL to
# Compare old vs new forecasts
# Track changes over time
# Analyze model drift or performance degradation

WITH ranked_forecasts AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY Store, Dept ORDER BY version_id DESC) AS ver_rank
    FROM forecast_history
)
SELECT *
FROM ranked_forecasts
WHERE ver_rank <= 2;

DESCRIBE forecasted_sales_2025_2027;

# Detect Outliers (Top 10 Weeks with Highest Sales)
SELECT Store, Dept, Year, Week_Number, Weekly_Sales
FROM forecasted_sales_2025_2027
ORDER BY Weekly_Sales DESC
LIMIT 10;

# Anomaly Detection (Z-Score Method)
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

# forecast accuracy over time once we get the actual sales
SELECT 
    h.Store, h.Dept,
    h.Weekly_Sales AS Actual,
    f.Weekly_Sales AS Forecasted,
    ROUND((f.Weekly_Sales - h.Weekly_Sales) / h.Weekly_Sales * 100, 2) AS ErrorPct
FROM history_df h
JOIN forecasted_sales_2025_2027 f
ON h.Store = f.Store AND h.Dept = f.Dept AND h.Week_Number = f.Week_Number
WHERE h.Year = 2024 AND f.Year = 2025;

