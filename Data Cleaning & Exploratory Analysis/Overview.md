# 📊 Phase 1: Data Cleaning & Exploratory Analysis

The first phase of the **SmartSell** project involved rigorous **data cleaning** and **exploratory data analysis (EDA)** using **R**. This foundational step ensured high-quality inputs for all downstream statistical and machine learning processes.

---

## 🧹 Data Cleaning

The raw sales data underwent several preprocessing steps to prepare it for analysis:

- Removal of duplicates and handling of missing values
- Standardization of column names and data formats
- Conversion of date columns to appropriate types
- Filtering invalid sales entries and extreme outliers

The cleaning steps are documented in the following R scripts:

- [`Retail Optimization I.R`](https://github.com/temidataspot/project-smartsell/blob/main/Data%20Cleaning%20%26%20Exploratory%20Analysis/Retail%20Optimization%20I.R)
- [`eda II.R`](https://github.com/temidataspot/project-smartsell/blob/main/Data%20Cleaning%20%26%20Exploratory%20Analysis/eda%20II.R)

---

## 📈 Exploratory Data Analysis (EDA)

EDA provided insights into the structure and trends in the data. Key aspects explored include:

### 🗓 Monthly Sales Trends
A clear seasonality in sales is visible, with peaks around **Apeil** and **November**, and a sharp drop in **January**.

![Monthly Sales Trends](https://github.com/temidataspot/project-smartsell/blob/main/Data%20Cleaning%20%26%20Exploratory%20Analysis/TotalEDA_SalesTrends.png)

### 🏪 Store Size vs. Average Sales
Larger stores generally exhibit higher average weekly sales.

![Store Size vs Average Sales](https://github.com/temidataspot/project-smartsell/blob/main/Data%20Cleaning%20%26%20Exploratory%20Analysis/StoreSize_AvgSales.png)

### 💸 Economic Indicators
Statistical regression showed a **strong negative correlation** between **unemployment** and weekly sales, and a mild negative correlation with the **CPI** (Consumer Price Index). This highlights the macroeconomic sensitivity of retail sales.

![Effect of Unemployment & CPI](https://github.com/temidataspot/project-smartsell/blob/main/Data%20Cleaning%20%26%20Exploratory%20Analysis/CPI_Unemployment.png)

### 📉 Markdown Impact & Store Types
- Markdowns show limited effect on weekly sales when applied in isolation.
- Store Type **B** showed the highest distribution of sales, while Type **C** had minimal contribution.
---

## ✅ Key Insights

- **Economic Downturns** (high unemployment) significantly reduce sales.
- **Store Size** and **Store Type** are strong predictors of performance.
- **Sales Seasonality** and **Holiday Periods** influence spikes in revenue.
- In terms of weekly sales, Store type **B > A > C**
- Sales are higher during holidays


