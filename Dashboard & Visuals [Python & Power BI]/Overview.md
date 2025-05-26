# 📊 Phase 6: Interactive Dashboards in Streamlit and Power BI

This stage of the **SmartSell** forecasting project focuses on making insights and predictions easily accessible and interactive for stakeholders. Developed two dashboards:

1. A **Streamlit dashboard in Python** for quick web-based access.
2. A **Power BI dashboard** for richer business intelligence and advanced analytics.

---

## 🚀 Streamlit Dashboard (Python)

To rapidly prototype and share insights from forecasted sales data, **Streamlit**, a Python-based web app framework was used.

- ✅ Built with: `streamlit`, `pandas`, `plotly`
- 📂 Python File: [`streamlit_dashboard.py`](https://github.com/temidataspot/project-smartsell/blob/main/Dashboard%20%26%20Visuals%20%5BPython%20%26%20Power%20BI%5D/dashboard.py)

### 📷 Dashboard Screenshot

![Streamlit Dashboard Overview](https://github.com/temidataspot/project-smartsell/blob/main/Dashboard%20%26%20Visuals%20%5BPython%20%26%20Power%20BI%5D/streamlit%20dashboard.png)

---

## 📊 Power BI Dashboard

For the final business-facing dashboard, we used **Power BI** due to its powerful data modeling, DAX capabilities, and user-friendly interface.

### 🧹 Power Query: Data Transformation

- Ensured correct data types across all columns.
- Renamed and standardized column names for consistency.
- Loaded clean dataset into Power BI data model.

![Power Query Editor](https://github.com/temidataspot/project-smartsell/blob/main/Dashboard%20%26%20Visuals%20%5BPython%20%26%20Power%20BI%5D/transform%20in%20power%20query.png)

---

## 📐 DAX Measures and Calculated Fields

Used **DAX (Data Analysis Expressions)** to define metrics and business logic.

### ➕ Key Measures

```DAX
Total Predicted Sales = SUM(forecasted_sales_2025_2027[Weekly_Sales])
Departments = DISTINCTCOUNT(forecasted_sales_2025_2027[Dept])
Total Stores = DISTINCTCOUNT(forecasted_sales_2025_2027[Store])
```
To enable quarterly trend visuals, we created a new column using:
```DAX
Quarter = 
VAR MonthNum = 
    SWITCH(
        TRUE(),
        [Month] = "January", 1,
        [Month] = "February", 2,
        [Month] = "March", 3,
        [Month] = "April", 4,
        [Month] = "May", 5,
        [Month] = "June", 6,
        [Month] = "July", 7,
        [Month] = "August", 8,
        [Month] = "September", 9,
        [Month] = "October", 10,
        [Month] = "November", 11,
        [Month] = "December", 12,
        BLANK()
    )
RETURN
    "Q" & FORMAT(ROUNDUP(MonthNum / 3, 0), "0") & " " & [Year]
```
This aided the easy calculation of Total Sales per Quarter:
```DAX
TotalSalesPerQuarter = 
CALCULATE(
    SUM('forecasted_sales_2025_2027'[Weekly_Sales]),
    ALLEXCEPT('forecasted_sales_2025_2027', 'forecasted_sales_2025_2027'[Dept], 'forecasted_sales_2025_2027'[Quarter])
)
```
Department performance was also categorized by price bucket tiers: High, middle, and low. However, the focus is on viewing low performance.
This was visualised using the ribbon chart anf it shows how these buckets move over quarters rather than each individual 
department.

To view this bucket, a new column for SalesBucket was created via the calculated field: 
```DAX
SalesBucket = 
VAR CurrentSales = [TotalSalesPerQuarter]
VAR SalesTable = 
    CALCULATETABLE(
        ADDCOLUMNS(
            SUMMARIZE('forecasted_sales_2025_2027', 'forecasted_sales_2025_2027'[Dept], 'forecasted_sales_2025_2027'[Quarter]),
            "TotalSales", CALCULATE(SUM('forecasted_sales_2025_2027'[Weekly_Sales]))
        ),
        ALL('forecasted_sales_2025_2027'[Store])
    )
VAR Percentile90 = PERCENTILEX.INC(SalesTable, [TotalSales], 0.9)
VAR Percentile30 = PERCENTILEX.INC(SalesTable, [TotalSales], 0.3)

RETURN
SWITCH(
    TRUE(),
    CurrentSales >= Percentile90, "High",
    CurrentSales <= Percentile30, "Low",
    "Medium"
)
```
# 📈 Published Dashboard
Interact with the dashboard via this [link](https://app.powerbi.com/view?r=eyJrIjoiMDRlZTZiMTgtNzczOS00MWVjLWFhNmUtMDQ3ODdmZWU3MTIzIiwidCI6IjVhYjI0MzA0LWY3NWItNDlkZS04Y2RkLTAyZGMyOGNkNDU5YiJ9). Check out the [Medium post](https://medium.com/@temiloluwa.jokotola/turning-forecasts-into-action-building-interactive-sales-dashboards-with-streamlit-power-bi-d4be0c1b40b0) for further explanations.
![BI Dashboard](https://github.com/temidataspot/project-smartsell/blob/main/Dashboard%20%26%20Visuals%20%5BPython%20%26%20Power%20BI%5D/bi%20dashboard%20snippet.png)
