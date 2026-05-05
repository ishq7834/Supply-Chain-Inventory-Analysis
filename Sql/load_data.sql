-- QUERY:
-> -- ============================================================
-> -- 📥 DATA LOADING (THIS TIME NO MISTAKES 😤)
-> -- ============================================================
->
-> USE supply_chain_analysis;

-- OUTPUT:
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '============================================================
SQL\ LOAD DATA



' at line 1


-- 🧍 Loading customers

-- QUERY:
mysql> LOAD DATA LOCAL INFILE 'C:/Ishika/Supply-Chain-Inventory-Analysis/Data/Cleaned/customers_cleaned_v2.csv'
    -> INTO TABLE customers
    -> FIELDS TERMINATED BY ','
    -> OPTIONALLY ENCLOSED BY '"'
    -> LINES TERMINATED BY '\n'
    -> IGNORE 1 ROWS
    -> (customer_id, acquisition_date, acquisition_cost_usd, market_segment,
    ->  supplier_id, order_id, order_date, order_value_usd,
    ->  payment_date, satisfaction_score, support_tickets, lead_time_days);

-- OUTPUT:
Query OK, 1 row affected, 2999 warnings (0.01 sec)
Records: 750  Deleted: 0  Skipped: 749  Warnings: 2999


-- 🚚 Loading shipments (THIS FIX SAVES YOUR LIFE 🔥)

-- QUERY:
mysql> LOAD DATA LOCAL INFILE 'C:/Ishika/Supply-Chain-Inventory-Analysis/Data/Cleaned/shipments_cleaned_v2.csv'
    -> INTO TABLE shipments
    -> FIELDS TERMINATED BY ','
    -> OPTIONALLY ENCLOSED BY '"'
    -> LINES TERMINATED BY '\n'
    -> IGNORE 1 ROWS
    -> (shipment_id, type, date, product_category, origin, origin_country,
    ->  destination, destination_country, value, freight_cost,
    ->  customs_clearance_time_days, delivery_status, cost_ratio, is_delayed);

-- OUTPUT:
Query OK, 728 rows affected, 1504 warnings (0.03 sec)
Records: 728  Deleted: 0  Skipped: 0  Warnings: 1504


-- 🏭 Loading logistics

-- QUERY:
mysql> LOAD DATA LOCAL INFILE 'C:/Ishika/Supply-Chain-Inventory-Analysis/Data/Cleaned/logistics_cleaned_v2.csv'
    -> INTO TABLE logistics
    -> FIELDS TERMINATED BY ','
    -> OPTIONALLY ENCLOSED BY '"'
    -> LINES TERMINATED BY '\n'
    -> IGNORE 1 ROWS
    -> (date, region, carrier, shipments_processed, delay_hours_avg,
    ->  fuel_price_usd_per_barrel, warehouse_utilization_percent,
    ->  damage_claims_count, high_utilization);

-- OUTPUT:
Query OK, 100 rows affected, 100 warnings (0.01 sec)
Records: 100  Deleted: 0  Skipped: 0  Warnings: 100