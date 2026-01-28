"""
SQL Server to S3 Data Load Script
Reads all tables from SQL Server and uploads them as CSV files to AWS S3
"""

import pyodbc
import pandas as pd
import boto3 
import io
from dotenv import load_dotenv
import os

# --- CONFIGURATION ---
SQL_CONFIG = {
    'driver': '{ODBC Driver 18 for SQL Server}',
    'server': os.getenv('SQL_SERVER'), 
    'database': os.getenv('SQL_DATABASE'),
    'user': os.getenv('SQL_USER'),
    'password': os.getenv('SQL_PASSWORD')
}

S3_CONFIG = {
    'bucket': os.getenv('AWS_BUCKET'),
    'aws_access_key': os.getenv('AWS_ACCESS_KEY'),
    'aws_secret_key': os.getenv('AWS_SECRET_KEY'),
    'region': os.getenv('AWS_REGION')
}

def upload_all_tables():

    try:
        # Create database connection
        conn_string = (
            f"Driver={SQL_CONFIG['driver']};"
            f"Server={SQL_CONFIG['server']};"
            f"Database={SQL_CONFIG['database']};"
            f"UID={SQL_CONFIG['user']};"
            f"PWD={SQL_CONFIG['password']};"
            f"TrustServerCertificate=yes"
        )
        conn = pyodbc.connect(conn_string)
        
        # Create S3 client
        s3_client = boto3.client(
            's3',
            aws_access_key_id=S3_CONFIG['aws_access_key'],
            aws_secret_access_key=S3_CONFIG['aws_secret_key'],
            region_name=S3_CONFIG['region']
        )
        
        # Get list of all tables
        table_query = "SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME"
        tables_df = pd.read_sql(table_query, conn)
        
        # Upload each table to S3
        for index, row in tables_df.iterrows():
            schema = row['TABLE_SCHEMA']
            table = row['TABLE_NAME']
            full_table_name = f"{schema}.{table}"
            s3_key = f"{table}.csv"
            
            # Read table data from SQL Server
            data_df = pd.read_sql(f"SELECT * FROM {full_table_name}", conn)
            
            # Convert to CSV and upload to S3
            csv_buffer = io.StringIO()
            data_df.to_csv(csv_buffer, index=False)
            csv_content = csv_buffer.getvalue()
            
            s3_client.put_object(
                Bucket=S3_CONFIG['bucket'],
                Key=s3_key,
                Body=csv_content
            )
            
            print(f"Uploaded {full_table_name} to s3://{S3_CONFIG['bucket']}/{s3_key}")
        
        conn.close()
        print("\n All tables uploaded successfully!")
        
    except pyodbc.Error as e:
        print(f"Database connection error: {e}")
    except Exception as e:
        print(f"Error uploading tables: {e}")
        

if __name__ == "__main__":
    upload_all_tables()

