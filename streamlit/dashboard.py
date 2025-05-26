import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

st.set_page_config(page_title="📈 SmartSell Forecast Dashboard", layout="wide")
st.title("📊 SmartSell Forecast Dashboard")

# 🔐 MySQL Connection
engine = create_engine('mysql+pymysql://root:para3saca1@localhost:3306/smart_retail')

# Sidebar filters
st.sidebar.header("🔍 Filters")
store = st.sidebar.selectbox("Select Store", options=pd.read_sql("SELECT DISTINCT Store FROM forecasted_sales_2025_2027", engine)['Store'])
dept = st.sidebar.selectbox("Select Dept", options=pd.read_sql(f"SELECT DISTINCT Dept FROM forecasted_sales_2025_2027 WHERE Store = {store}", engine)['Dept'])

# Load data
query = f"""
SELECT Year, Month, AVG(Weekly_Sales) AS AvgSales
FROM forecasted_sales_2025_2027
WHERE Store = {store} AND Dept = {dept}
GROUP BY Year, Month
ORDER BY Year, FIELD(Month, 'January','February','March','April','May','June',
                             'July','August','September','October','November','December');
"""

df = pd.read_sql(query, engine)

# Display chart
st.subheader(f"📅 Forecast for Store {store}, Dept {dept}")
st.line_chart(df.set_index('Month').pivot(columns='Year', values='AvgSales'))

# Show raw data
if st.checkbox("Show Raw Data"):
    st.write(df)