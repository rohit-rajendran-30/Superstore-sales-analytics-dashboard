-- ==========================================
-- SUPERSTORE SALES ANALYTICS PROJECT
-- Database: superstore_db
-- Table: superstore_clean
-- ==========================================

-- 1. Total Records
SELECT COUNT(*) AS total_records
FROM superstore_clean;

-- 2. Overall Business Performance
   SELECT
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(
        (SUM(profit) / NULLIF(SUM(sales), 0) * 100)::numeric,
        2
    ) AS profit_margin,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_clean;

-- 3. Category Performance
SELECT
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(
        (SUM(profit) / NULLIF(SUM(sales), 0) * 100)::numeric,
        2
    ) AS profit_margin
FROM superstore_clean
GROUP BY category
ORDER BY total_sales DESC;

-- 4. Regional Performance
SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY region
ORDER BY total_sales DESC;

-- 5. Yearly Sales Performance
SELECT
    EXTRACT(YEAR FROM order_date) AS sales_year,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY sales_year
ORDER BY sales_year;

-- 6. Segment Performance
SELECT
    segment,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY segment
ORDER BY total_sales DESC;

-- 7. Subcategory Profit Analysis
SELECT
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY sub_category
ORDER BY total_profit ASC;

-- 8. Discount Impact on Profit
SELECT
    discount,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY discount
ORDER BY discount;

-- 9. Monthly Sales Trend
SELECT
    DATE_TRUNC('month', order_date)::date AS sales_month,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY sales_month
ORDER BY sales_month;

-- 10. State-wise Profit Analysis
SELECT
    state,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore_clean
GROUP BY state
ORDER BY total_profit ASC;

-- 11. Data Quality Check
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT row_id) AS unique_rows,
    COUNT(*) - COUNT(DISTINCT row_id) AS duplicate_rows
FROM superstore_clean;