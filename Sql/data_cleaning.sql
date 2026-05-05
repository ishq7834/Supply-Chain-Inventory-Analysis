-- ============================================================
-- 🧹 DATA CLEANING (final polish… like makeup 💄😄)
-- ============================================================


-- CUSTOMERS

-- QUERY:
mysql> UPDATE customers
    -> SET market_segment = LOWER(TRIM(market_segment));

-- OUTPUT:
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0


-- SHIPMENTS

-- QUERY:
mysql> UPDATE shipments
    -> SET
    ->     delivery_status = LOWER(TRIM(delivery_status)),
    ->     origin_country = TRIM(origin_country),
    ->     destination_country = TRIM(destination_country),
    ->     product_category = LOWER(TRIM(product_category));

-- OUTPUT:
Query OK, 728 rows affected (0.03 sec)
Rows matched: 728  Changed: 728  Warnings: 0


-- QUERY:
mysql> UPDATE shipments
    -> SET is_delayed = CASE
    ->     WHEN delivery_status = 'delayed' THEN 1
    ->     ELSE 0
    -> END;

-- OUTPUT:
Query OK, 110 rows affected (0.01 sec)
Rows matched: 728  Changed: 110  Warnings: 0


-- LOGISTICS

-- QUERY:
mysql> UPDATE logistics
    -> SET
    ->     region = LOWER(TRIM(region)),
    ->     carrier = LOWER(TRIM(carrier));

-- OUTPUT:
Query OK, 100 rows affected (0.00 sec)
Rows matched: 100  Changed: 100  Warnings: 0


-- QUERY:
mysql> UPDATE logistics
    -> SET high_utilization = CASE
    ->     WHEN warehouse_utilization_percent > 85 THEN 1
    ->     ELSE 0
    -> END;

-- OUTPUT:
Query OK, 35 rows affected (0.01 sec)
Rows matched: 100  Changed: 35  Warnings: 0