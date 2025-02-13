import pandas as pd
import os
DATA_FOLDER = r"D:\Portfolio-website\Portfolio-1\supply-chain-managment\Data"
CLEANED_FOLDER = os.path.join(DATA_FOLDER, "Cleaned")  # Save cleaned files inside Data/Cleaned

# Ensure the cleaned data folder exists
os.makedirs(CLEANED_FOLDER, exist_ok=True)

# List of CSV files and their key columns
files = {
    "Order_details.csv": ["order_id", "customer_id", "product_id", "order_date", "unit_quantity"],
    "FreightRates.csv": ["origin_port", "destination_port", "min_weight", "max_weight", "min_cost", "cost_per_unit_weight"],
    "Plant_ports.csv": ["plant_code", "port_id"],
    "Products_per_plant.csv": ["product_id", "plant_code"],
    "VMI_customers.csv": ["customer_id", "region"],
    "WhCapacities.csv": ["warehouse_id", "plant_code", "order_capacity"],
    "Whcosts.csv": ["warehouse_id", "handling_cost"]
}

def clean_data(file_name, columns):
    file_path = os.path.join(DATA_FOLDER, file_name)
    df = pd.read_csv(file_path)

    print(f"Cleaning {file_name}...")

    # Remove duplicates
    df.drop_duplicates(inplace=True)

    # Handle missing values
    for col in columns:
        if col in df.columns:
            if df[col].dtype == 'object':
                df[col].fillna("Unknown", inplace=True)  # Fill missing text values with "Unknown"
            elif df[col].dtype in ['int64', 'float64']:
                df[col].fillna(df[col].median(), inplace=True)  # Fill missing numeric values with median

    # Convert order_date to YYYY-MM-DD format (Only for Order_details.csv)
    if "order_date" in df.columns:
        df["order_date"] = pd.to_datetime(df["order_date"], errors='coerce').dt.date

    # Convert numeric columns to proper data types
    numeric_cols = ["unit_quantity", "min_weight", "max_weight", "min_cost", "cost_per_unit_weight", "order_capacity", "handling_cost"]
    for col in numeric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')

    # Standardize column names (lowercase, replace spaces with underscores)
    df.columns = df.columns.str.lower().str.replace(" ", "_")

    # Save cleaned file
    cleaned_file_path = os.path.join(CLEANED_FOLDER, f"cleaned_{file_name}")
    df.to_csv(cleaned_file_path, index=False)
    
    print(f"✅ Cleaned {file_name} saved as {cleaned_file_path}")

# Run cleaning function for all files
for file, cols in files.items():
    clean_data(file, cols)

print("\n Data Cleaning Completed for All Files!")