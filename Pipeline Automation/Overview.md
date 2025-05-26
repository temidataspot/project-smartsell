# 🔄 Pipeline Automation Overview

This phase focuses on fully **automating the entire SmartSell pipeline** — from data ingestion and forecasting to storage and dashboard refresh. The automation ensures your analytics workflow runs seamlessly without manual intervention, keeping reports up-to-date and decision-makers informed in real-time.

---

## 📂 Automation Script

The automation process is handled by the following script:


---

## ⚙️ What the Automation Script Does

The automation script consolidates all key stages of the project into a single runnable workflow:

1. **Load latest data**
   - Automatically imports updated historical data and forecast-ready data.

2. **Run preprocessing pipeline**
   - Cleans and prepares the dataset (feature engineering, date handling, etc.).

3. **Train or reload model**
   - Option to train a new model or use saved versions based on a config flag.

4. **Generate forecasts**
   - Uses the Random Forest Regressor model to predict future sales across Store–Department pairs.

5. **Export to MySQL**
   - Automatically writes updated forecast results to the connected SQL database.

6. **Log and Notify**
   - Logs completion steps and can be extended to send email/Slack notifications in future updates.

---

## ✅ Why This Matters

Automation turns SmartSell into a **production-ready analytics engine**. Instead of manually rerunning notebooks or dashboards, this pipeline:

- Reduces human error
- Saves analyst time
- Ensures that Power BI and Streamlit dashboards are **always current**
- Prepares your solution for future deployment via cron jobs, Task Scheduler, or Airflow

---

## 🔁 Future Enhancements

- Schedule to run daily or weekly via **cron jobs** (Linux/Mac) or **Task Scheduler** (Windows)
- Add logging alerts via **email or messaging apps**
- Integrate with **cloud storage** for off-site backup

---



