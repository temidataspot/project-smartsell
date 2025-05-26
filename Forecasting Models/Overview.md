# 📈 Phase 3: Forecasting & Projection

In this phase of the **SmartSell** project, we shifted from historical analysis to **predictive modeling**. Using Python and machine learning, we developed a robust forecasting pipeline to **predict weekly sales from 2025 to 2027**, helping SmartSell prepare for future demand and resource planning.

📓 View the full notebook here: [`SmartSell_Analysis.ipynb`](https://github.com/temidataspot/project-smartsell/blob/main/Forecasting%20Models/SmartSell_Analysis.ipynb)

---

## 🧠 Goals of This Stage

- Forecast **weekly sales** for every `Store` and `Dept` combination from 2025 to 2027  
- Identify **seasonal trends**, **holiday effects**, and **monthly growth patterns**  
- Build a forecasting system using **core business features** while treating economic indicators as static

---

## ⚙️ Methodology Summary

- Model: **XGBoost Regressor** with time-aware cross-validation  
- Key features: `Store`, `Dept`, `Week_Number`, `Month`, `Type`, `IsHoliday`  
- Lag features created from `Weekly_Sales`  
- Time-based holdout set used for model validation

---

## 📈 Actual vs Predicted Sales (Validation Phase)

Evaluated the model on data from 2022–2024 before making future projections.  
The figure below shows that the model accurately tracks the general trend and seasonal fluctuations.

![Actual vs Predicted Sales](https://github.com/temidataspot/project-smartsell/blob/main/Forecasting%20Models/actual_predicted_sales.png)

- Low-sales periods (e.g., early Q1) align closely with actuals  
- Minor underestimation during extreme peaks, which is common in gradient boosting models

---

## 🗓 Weekly Sales Forecast (2025–2027)

The figure below displays weekly sales forecasts at the aggregated level from 2025 through 2027.

![Weekly Forecasted Sales](https://github.com/temidataspot/project-smartsell/blob/main/Forecasting%20Models/weekly_sales_forecasted.png)

- Forecasts indicate **consistent year-over-year growth**  
- Weekly fluctuations reflect operational cycles, holidays, and expected shopping behavior

---

## 📅 Monthly Sales Forecast (2025–2027)

To better visualize long-term planning and trends, aggregated weekly forecasts into monthly totals.

![Monthly Forecasted Sales](https://github.com/temidataspot/project-smartsell/blob/main/Forecasting%20Models/monthly_sales_forecasted.png)

- Predictable peaks in **December** each year  
- Monthly forecasts reveal a **strong upward trend**, suggesting organic growth or expanded store impact  
- Useful for **budgeting, marketing calendar planning**, and supply chain coordination

---

- **Holiday effects** remain the most dominant factor in sales surges  

Check out [Medium](https://medium.com/@temiloluwa.jokotola/a-glimpse-into-smartsell-future-sales-2025-2027-4ceadc947305) for further documentation and model evaluation.

