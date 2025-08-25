# build mysql pipeline
import pandas as pd
from sqlalchemy import create_engine, text

from sqlalchemy import create_engine, text

# MySQL Credentials
username = 'root'
password = '*****'
host = 'localhost'
port = 3306
system_db = 'mysql'  # System database used to create new databases

# 🛠 Create database if it doesn't exist
with engine.connect() as conn:
    conn.execute(text("CREATE DATABASE IF NOT EXISTS smart_retail"))
    print("Database 'smart_retail' created or already exists")

# Build connection string with port and credentials
connection_string = f'mysql+pymysql://{username}:{password}@{host}:{port}/{system_db}'
engine = create_engine(connection_string)

# Load updated forecast
forecast_df = pd.read_csv('weekly_sales_forecast_2025_to_2027.csv')

# Upload to MySQL
forecast_df.to_sql('forecasted_sales_2025_2027', engine, if_exists='replace', index=False)
print("Forecast table updated in MySQL")
