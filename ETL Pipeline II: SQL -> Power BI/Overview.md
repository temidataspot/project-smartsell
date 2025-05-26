# 🔗 Phase 5: Building a Data Pipeline from MySQL to Power BI

This stage of the **SmartSell** project focuses on creating a seamless pipeline to visualize our forecasted and historical sales data in **Power BI**, directly from our **MySQL database**. This integration ensures near real-time reporting and interactive dashboards for decision-makers.

---

## 🧰 Environment Setup

To begin, the required tools were set up to enable the MySQL–Power BI connection:

- Installed the **MySQL ODBC 64-bit Connector** to match the Power BI version.
- Opened the **ODBC Data Source Administrator (64-bit)** using `Win + R` → `odbcad32`.
  ![`Win + R` → `odbcad32`](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/WinR.png)
  
📷 *ODBC Administrator View*  
![ODBC Admin](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/ODBC%20driver.png)

---

## 🧩 Creating a System DSN

A new **System Data Source Name (DSN)** was created:

- Selected the `MySQL ODBC 8.0 Unicode Driver`.
- Entered connection details: Data Source Name, TCP/IP Server, Port, Username, Password, and selected the database (e.g., `smartsell_db`).
- Tested the connection successfully.

📷 *ODBC DSN Configuration*  
![ODBC Config](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/Configure%20connection.png)

![Confirm Connection](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/test%20connection%20ensure%20it%20exist.png)

---

## 💻 Configuring via Command Prompt

To ensure driver compatibility and access credentials:

- Opened **Command Prompt** to configure the driver manually.
- Ensured username matches the ODBC setup.

---

## 📊 Connecting in Power BI

Once the ODBC driver was configured:

- Opened **Power BI**, clicked **Get Data → ODBC**.
- Selected the system DSN name created earlier.
- Entered MySQL credentials again when prompted.
- Successfully accessed and previewed the MySQL tables.

📷 *Power BI ODBC Connection*  
![Power BI Connection](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/get%20data%20odbc.png)

![Select table from existing database](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/select%20table%20from%20database.png)

---

## 🧹 Data Transformations in Power Query

- Loaded the data into **Power Query Editor** for cleaning and transformation.
- This step prepares the data for visualizations such as:
  - Forecast trend tracking
  - Year-over-year sales comparison
  - Store-wise performance dashboards

📷 *Power Query Interface*  
![Power Query](https://github.com/temidataspot/project-smartsell/blob/main/ETL%20Pipeline%20II%3A%20SQL%20-%3E%20Power%20BI/transform%20in%20power%20query.png)

---

## ✅ Summary

At this stage:

- A **live data pipeline** from MySQL to Power BI has been established.
- Power BI can now query and visualize updated data from the database.
- The setup paves the way for interactive reporting and executive dashboards that can evolve as new sales data becomes available.

Read Medium post for further evaluation.

