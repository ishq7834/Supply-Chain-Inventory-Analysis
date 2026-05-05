# ============================================================
# 📦 Supply Chain Data Processing Script
# ============================================================

"""
🧠 Description:
This script performs data cleaning and feature engineering
on supply chain datasets.

🎯 Purpose:
Prepare clean, structured, and enriched data for analysis
and dashboarding.

Steps:
1. Load cleaned datasets
2. Standardize text & formats
3. Create new features
4. Save processed datasets
"""

# ============================================================
# 📥 IMPORT LIBRARIES
# ============================================================

import pandas as pd
import os

# ============================================================
# 📂 SET BASE PATH (FIXED FOR YOUR FOLDER STRUCTURE)
# ============================================================

# Get project root directory
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ⚠️ IMPORTANT: Your actual folder is Data/Cleaned (not data/cleaned)
data_path = os.path.join(BASE_DIR, 'Data', 'Cleaned')

# ============================================================
# 📂 LOAD DATA
# ============================================================

print("📥 Loading data...")

# ⚠️ If your files have _v2, change names here accordingly
customers = pd.read_csv(os.path.join(data_path, 'customers_cleaned_v2.csv'))
shipments = pd.read_csv(os.path.join(data_path, 'shipments_cleaned_v2.csv'))
logistics = pd.read_csv(os.path.join(data_path, 'logistics_cleaned_v2.csv'))

print("✅ Data loaded successfully")


# ============================================================
# 👤 CUSTOMERS DATA PROCESSING
# ============================================================

print("🔄 Processing customers data...")

# 🧹 Clean text columns
customers['market_segment'] = customers['market_segment'].astype(str).str.lower().str.strip()

# ⏳ Feature: Payment delay (days)
customers['payment_delay_days'] = (
    pd.to_datetime(customers['payment_date'], errors='coerce') -
    pd.to_datetime(customers['order_date'], errors='coerce')
).dt.days

# 🛠 Fix negative or missing values
customers['payment_delay_days'] = customers['payment_delay_days'].apply(
    lambda x: x if pd.notnull(x) and x >= 0 else 0
)


# ============================================================
# 🚚 SHIPMENTS DATA PROCESSING
# ============================================================

print("🔄 Processing shipments data...")

# 🧹 Clean text fields
shipments['product_category'] = shipments['product_category'].astype(str).str.lower().str.strip()
shipments['delivery_status'] = shipments['delivery_status'].astype(str).str.lower().str.strip()

# 🚨 Feature: Delay flag
shipments['is_delayed'] = shipments['delivery_status'].apply(
    lambda x: 1 if x == 'delayed' else 0
)

# 🔢 Convert to numeric safely
shipments['value'] = pd.to_numeric(shipments['value'], errors='coerce')
shipments['freight_cost'] = pd.to_numeric(shipments['freight_cost'], errors='coerce')

# 💰 Feature: Cost efficiency (avoid division error)
shipments['cost_efficiency'] = shipments.apply(
    lambda row: row['value'] / row['freight_cost'] if row['freight_cost'] not in [0, None] else None,
    axis=1
)

# 🧹 Remove invalid rows
shipments = shipments.dropna(subset=['value', 'freight_cost'])


# ============================================================
# 🏭 LOGISTICS DATA PROCESSING
# ============================================================

print("🔄 Processing logistics data...")

# 🧹 Clean text columns
logistics['region'] = logistics['region'].astype(str).str.lower().str.strip()
logistics['carrier'] = logistics['carrier'].astype(str).str.lower().str.strip()

# 📊 Feature: High utilization flag
logistics['high_utilization_flag'] = logistics['warehouse_utilization_percent'].apply(
    lambda x: 1 if pd.notnull(x) and x > 85 else 0
)


# ============================================================
# 💾 SAVE PROCESSED DATA
# ============================================================

print("💾 Saving processed data...")

customers.to_csv(os.path.join(data_path, 'customers_processed.csv'), index=False)
shipments.to_csv(os.path.join(data_path, 'shipments_processed.csv'), index=False)
logistics.to_csv(os.path.join(data_path, 'logistics_processed.csv'), index=False)

print("📊 Final Dataset Shapes:")
print("Customers:", customers.shape)
print("Shipments:", shipments.shape)
print("Logistics:", logistics.shape)

print("🎉 Data processing complete!")