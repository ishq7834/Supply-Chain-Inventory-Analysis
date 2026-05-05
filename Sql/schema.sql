-- ============================================================
-- FULL MYSQL EXECUTION (QUERY + OUTPUT)
-- ============================================================

-- ============================================================
-- CONNECTION SETUP
-- ============================================================

-- QUERY:
mysql> SET GLOBAL local_infile = 1;

-- OUTPUT:
Query OK, 0 rows affected (0.00 sec)


-- ============================================================
-- 🚀 PROJECT: Supply Chain & Inventory Optimization
-- 🧠 WHAT AM I DOING HERE?
-- Creating the "skeleton" of my database (tables before data)
-- ============================================================

-- Step 1: Create database (fresh start, no drama)

-- QUERY:
mysql> CREATE DATABASE supply_chain_analysis;

-- OUTPUT:
Query OK, 1 row affected (0.01 sec)


-- Tell MySQL: "bhai yahi kaam karna hai"

-- QUERY:
mysql> USE supply_chain_analysis;

-- OUTPUT:
Database changed


-- ============================================================
-- 👤 CUSTOMERS TABLE
-- This stores customer + order info (yes, combo pack 😄)
-- ============================================================

-- QUERY:
mysql> CREATE TABLE customers (
    ->     customer_id INT,                      -- who is the customer
    ->     acquisition_date DATE,                -- when they came into our life
    ->     acquisition_cost_usd DECIMAL(10,2),  -- how expensive was it to get them 😬
    ->     market_segment VARCHAR(50),           -- type of customer
    ->     supplier_id INT,
    ->     order_id INT,                         -- main hero (unique order)
    ->     order_date DATE,
    ->     order_value_usd DECIMAL(10,2),
    ->     payment_date DATE,
    ->     satisfaction_score DECIMAL(3,1),      -- mood rating 😄 (0–5)
    ->     support_tickets INT,                  -- complaints count 😅
    ->     lead_time_days INT,                   -- delivery time
    ->
    ->     PRIMARY KEY (order_id)
    -> );

-- OUTPUT:
Query OK, 0 rows affected (0.02 sec)


-- ============================================================
-- 🚚 SHIPMENTS TABLE
-- Tracks deliveries (basically “kahan se kahan gaya”)
-- ============================================================

-- QUERY:
mysql> CREATE TABLE shipments (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,    -- internal id (safe side)
    ->     shipment_id INT,
    ->     type VARCHAR(50),                     -- import/export
    ->     date DATE,
    ->     product_category VARCHAR(100),
    ->     origin VARCHAR(100),
    ->     origin_country VARCHAR(50),
    ->     destination VARCHAR(100),
    ->     destination_country VARCHAR(50),
    ->     value DECIMAL(10,2),                  -- value of goods 💰
    ->     freight_cost DECIMAL(10,2),           -- shipping cost 🚚
    ->     customs_clearance_time_days INT,
    ->     delivery_status VARCHAR(20),          -- on_time / delayed
    ->     cost_ratio DECIMAL(10,4),
    ->     is_delayed BOOLEAN
    -> );

-- OUTPUT:
Query OK, 0 rows affected (0.02 sec)


-- ============================================================
-- 🏭 LOGISTICS TABLE
-- Tracks operations (warehouse + carriers + delays)
-- ============================================================

-- QUERY:
mysql> CREATE TABLE logistics (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     date DATE,
    ->     region VARCHAR(50),
    ->     carrier VARCHAR(100),                 -- logistics company
    ->     shipments_processed INT,
    ->     delay_hours_avg DECIMAL(5,2),
    ->     fuel_price_usd_per_barrel DECIMAL(10,2),
    ->     warehouse_utilization_percent DECIMAL(5,2),
    ->     damage_claims_count INT,
    ->     high_utilization BOOLEAN
    -> );

-- OUTPUT:
Query OK, 0 rows affected (0.02 sec)


-- ============================================================
-- ⚡ INDEXES (making queries faster like 5G internet 😎)
-- ============================================================

-- QUERY:
mysql> CREATE INDEX idx_customers_segment ON customers(market_segment);

-- OUTPUT:
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0


-- QUERY:
mysql> CREATE INDEX idx_shipments_country ON shipments(destination_country);

-- OUTPUT:
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0


-- QUERY:
mysql> CREATE INDEX idx_logistics_region ON logistics(region);

-- OUTPUT:
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0


-- ============================================================
-- END OF SCHEMA EXECUTION
-- ============================================================