-- ============================================================
-- 📊 ANALYSIS (NOW WE ACTUALLY USE THE DATA 😎)
-- ============================================================


-- ============================================================
-- 1. Shipments by country
-- ============================================================

-- QUERY:
mysql> SELECT destination_country, COUNT(*) AS total_shipments
    -> FROM shipments
    -> GROUP BY destination_country;

-- OUTPUT:
+---------------------+-----------------+
| destination_country | total_shipments |
+---------------------+-----------------+
| 100500              |               1 |
| 65000               |               1 |
| 66500               |               1 |
| 69000               |               1 |
| 70500               |               1 |
| 72000               |               1 |
| 73500               |               1 |
| 75000               |               1 |
| 76500               |               1 |
| 78000               |               1 |
| 79500               |               1 |
| 81000               |               1 |
| 82500               |               1 |
| 84000               |               1 |
| 85500               |               1 |
| 87000               |               1 |
| 88500               |               1 |
| 90000               |               1 |
| 91500               |               1 |
| 93000               |               1 |
| 94500               |               1 |
| 96000               |               1 |
| 97500               |               1 |
| 99000               |               1 |
| Australia           |              24 |
| Brazil              |              24 |
| Egypt               |              24 |
| India               |             364 |
| Japan               |              24 |
| Mexico              |              24 |
| Netherlands         |              24 |
| Nigeria             |              24 |
| Saudi Arabia        |              24 |
| South Africa        |              24 |
| UAE                 |              24 |
| UK                  |              26 |
| USA                 |              74 |
+---------------------+-----------------+
37 rows in set (0.00 sec)


-- ============================================================
-- 2. Delivery performance
-- ============================================================

-- QUERY:
mysql> SELECT delivery_status, COUNT(*) AS total_orders
    -> FROM shipments
    -> GROUP BY delivery_status;

-- OUTPUT:
+-----------------+--------------+
| delivery_status | total_orders |
+-----------------+--------------+
| on_time         |          594 |
| delayed         |          110 |
| nan             |           24 |
+-----------------+--------------+
3 rows in set (0.00 sec)


-- ============================================================
-- 3. Cost efficiency
-- ============================================================

-- QUERY:
mysql> SELECT product_category, AVG(cost_ratio)
    -> FROM shipments
    -> GROUP BY product_category;

-- OUTPUT:
+----------------------+-----------------+
| product_category     | AVG(cost_ratio) |
+----------------------+-----------------+
| electronics          |      0.05000000 |
| textiles             |      0.05000000 |
| consumer goods       |      0.05000000 |
| industrial equipment |      0.04304000 |
+----------------------+-----------------+
4 rows in set (0.00 sec)


-- ============================================================
-- 4. Delay routes
-- ============================================================

-- QUERY:
mysql> SELECT origin_country, destination_country, COUNT(*) AS delays
    -> FROM shipments
    -> WHERE is_delayed = 1
    -> GROUP BY origin_country, destination_country;

-- OUTPUT:
(full output same as your original execution log)


-- ============================================================
-- 5. Customer behavior
-- ============================================================

-- QUERY:
mysql> SELECT market_segment, COUNT(order_id), AVG(order_value_usd)
    -> FROM customers
    -> GROUP BY market_segment;

-- OUTPUT:
+----------------+-----------------+----------------------+
| market_segment | COUNT(order_id) | AVG(order_value_usd) |
+----------------+-----------------+----------------------+
| north america  |               1 |         12500.000000 |
+----------------+-----------------+----------------------+
1 row in set (0.00 sec)


-- ============================================================
-- 6. Payment delay
-- ============================================================

-- QUERY:
mysql> SELECT AVG(DATEDIFF(payment_date, order_date))
    -> FROM customers;

-- OUTPUT:
+-----------------------------------------+
| AVG(DATEDIFF(payment_date, order_date)) |
+-----------------------------------------+
|                                 34.0000 |
+-----------------------------------------+
1 row in set (0.00 sec)


-- ============================================================
-- 7. Warehouse performance
-- ============================================================

-- QUERY:
mysql> SELECT region, AVG(warehouse_utilization_percent)
    -> FROM logistics
    -> GROUP BY region;

-- OUTPUT:
+---------------+------------------------------------+
| region        | AVG(warehouse_utilization_percent) |
+---------------+------------------------------------+
| asia-pacific  |                          92.000000 |
| europe        |                          75.000000 |
| north america |                          72.500000 |
+---------------+------------------------------------+
3 rows in set (0.00 sec)


-- ============================================================
-- 8. Carrier performance
-- ============================================================

-- QUERY:
mysql> SELECT carrier,
    ->        AVG(delay_hours_avg),
    ->        SUM(shipments_processed)
    -> FROM logistics
    -> GROUP BY carrier;

-- OUTPUT:
+-------------------+----------------------+--------------------------+
| carrier           | AVG(delay_hours_avg) | SUM(shipments_processed) |
+-------------------+----------------------+--------------------------+
| fastship          |             2.560000 |                    38040 |
| globalconnect     |             1.696000 |                    30900 |
| oceanexpress      |             4.376000 |                    54340 |
| reliablelogistics |             1.172000 |                    22840 |
+-------------------+----------------------+--------------------------+
4 rows in set (0.00 sec)


-- ============================================================
-- 9. High-value shipments
-- ============================================================

-- QUERY:
mysql> SELECT *
    -> FROM shipments
    -> WHERE value > 100000
    -> ORDER BY value DESC;

-- OUTPUT:
(full large table same as your execution log)


-- ============================================================
-- 10. Top routes by average shipment value (ADDED)
-- ============================================================

-- QUERY:
SELECT origin_country, destination_country, AVG(value) AS avg_value
FROM shipments
GROUP BY origin_country, destination_country
ORDER BY avg_value DESC
LIMIT 5;

-- OUTPUT:
(run this query to generate output)