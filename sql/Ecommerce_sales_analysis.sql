CREATE DATABASE ecommerce_analytics;



CREATE TABLE customer_master_clean (
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    customer_age INTEGER,
    gender VARCHAR(30),
    customer_segment VARCHAR(50),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    customer_country VARCHAR(100),
    region VARCHAR(100),
    customer_postal_code VARCHAR(20),
    customer_acquisition_cost NUMERIC
);

CREATE TABLE order_items_clean (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity NUMERIC,
    unit_price NUMERIC,
    discount_percentage NUMERIC,
    discount_amount NUMERIC,
    gross_sales NUMERIC,
    tax_amount NUMERIC,
    shipping_cost NUMERIC,
    net_sales NUMERIC,
    product_cost NUMERIC,
    profit NUMERIC
);

CREATE TABLE product_catalog_clean (
    product_id VARCHAR(50),
    product_name VARCHAR(200),
    product_category VARCHAR(100),
    product_subcategory VARCHAR(100),
    brand VARCHAR(100),
    supplier VARCHAR(150),
    unit_price NUMERIC,
    product_cost NUMERIC,
    product_rating NUMERIC
);

CREATE TABLE orders_clean (
    order_id VARCHAR(50),
    order_date DATE,
    order_time TIME,
    order_status VARCHAR(50),
    sales_channel VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    customer_age INTEGER,
    gender VARCHAR(30),
    customer_segment VARCHAR(50),
    customer_type VARCHAR(50),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    customer_country VARCHAR(100),
    region VARCHAR(100),
    customer_postal_code VARCHAR(20),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    currency VARCHAR(10),
    shipping_method VARCHAR(50),
    warehouse VARCHAR(100),
    delivery_days NUMERIC,
    estimated_delivery_days NUMERIC,
    delivery_status VARCHAR(50),
    return_status VARCHAR(50),
    return_reason VARCHAR(150),
    customer_rating NUMERIC,
    review_sentiment VARCHAR(50),
    customer_review TEXT,
    marketing_channel VARCHAR(100),
    loyalty_points_earned NUMERIC,
    loyalty_points_redeemed NUMERIC,
    quantity NUMERIC,
    gross_sales NUMERIC,
    discount_amount NUMERIC,
    tax_amount NUMERIC,
    shipping_cost NUMERIC,
    net_sales NUMERIC,
    product_cost NUMERIC,
    profit NUMERIC,
    profit_margin_percentage NUMERIC,
    customer_lifetime_value NUMERIC,
    is_repeat_customer BOOLEAN,
    customer_order_count INTEGER,
    order_year INTEGER,
    order_month INTEGER,
    order_month_name VARCHAR(20),
    order_quarter VARCHAR(20),
    order_day INTEGER,
    order_day_name VARCHAR(20),
    delivery_variance NUMERIC,
    delivery_performance VARCHAR(30),
    calculated_profit_margin NUMERIC,
    margin_difference NUMERIC
);

SELECT * FROM ORDERS_CLEAN;

-- Step 1 — Check row counts
SELECT 'orders_clean' AS table_name,
       COUNT(*) AS row_count
FROM orders_clean

UNION ALL

SELECT 'order_items_clean',
       COUNT(*)
FROM order_items_clean

UNION ALL

SELECT 'product_catalog_clean',
       COUNT(*)
FROM product_catalog_clean

UNION ALL

SELECT 'customer_master_clean',
       COUNT(*)
FROM customer_master_clean;

-- Step 2 — Check duplicate orders
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders_clean
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Step 3 — Check duplicate customers
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customer_master_clean
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Step 4 — Check duplicate products
SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM product_catalog_clean
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Step 5 — Check referential integrity
-- Orders → Customers
SELECT COUNT(*) AS missing_customer_ids
FROM orders_clean o
LEFT JOIN customer_master_clean c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order Items → Orders
SELECT COUNT(*) AS missing_order_ids
FROM order_items_clean oi
LEFT JOIN orders_clean o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order Items → Products
SELECT COUNT(*) AS missing_product_ids
FROM order_items_clean oi
LEFT JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Step 6 — Check financial data
SELECT
    MIN(net_sales) AS minimum_net_sales,
    MAX(net_sales) AS maximum_net_sales,
    MIN(profit) AS minimum_profit,
    MAX(profit) AS maximum_profit
FROM orders_clean;

-- Step 7 — Check order dates
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders_clean;

-- Core Business KPI Analysis
-- 1. Total Sales
SELECT
    SUM(net_sales) AS total_sales
FROM orders_clean;

-- 2. Total Profit
SELECT
    SUM(profit) AS total_profit
FROM orders_clean;

-- 3. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders_clean;

-- 4. Total Customers
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders_clean;

-- 5. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM orders_clean;

-- 6. Average Order Value (AOV)
SELECT
    SUM(net_sales)
    / NULLIF(COUNT(DISTINCT order_id), 0)
    AS average_order_value
FROM orders_clean;

-- 7. Overall Profit Margin
SELECT
    SUM(profit)
    / NULLIF(SUM(net_sales), 0) * 100
    AS overall_profit_margin
FROM orders_clean;

-- 8. Create One KPI Query
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(net_sales)
        / NULLIF(COUNT(DISTINCT order_id), 0)
        AS average_order_value,
    SUM(profit)
        / NULLIF(SUM(net_sales), 0) * 100
        AS profit_margin
FROM orders_clean;

-- Sales Trend Analysis
-- 9. Yearly Sales
SELECT
    order_year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit)
        / NULLIF(SUM(net_sales), 0) * 100
        AS profit_margin
FROM orders_clean
GROUP BY order_year
ORDER BY order_year;

-- 10. Monthly Sales
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_clean
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 11. Quarterly Performance
SELECT
    order_year,
    order_quarter,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_clean
GROUP BY
    order_year,
    order_quarter
ORDER BY
    order_year,
    order_quarter;

-- Customer Analysis
-- 12. Customer Type
SELECT
    customer_type,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_clean
GROUP BY customer_type
ORDER BY total_sales DESC;

-- 13. Customer Segment
SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(net_sales) AS average_order_value
FROM orders_clean
GROUP BY customer_segment
ORDER BY total_sales DESC;

-- 14. Repeat Customer Rate
SELECT
    COUNT(DISTINCT CASE
        WHEN is_repeat_customer = TRUE
        THEN customer_id
    END) * 100.0
    / NULLIF(COUNT(DISTINCT customer_id), 0)
    AS repeat_customer_rate
FROM orders_clean;

-- 15. Geographic Analysis
SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_clean
GROUP BY region
ORDER BY total_sales DESC;

-- 16. State Performance
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders_clean
GROUP BY customer_state
ORDER BY total_sales DESC;

-- Product Analysis
-- 17. Category Performance
SELECT
    p.product_category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.net_sales) AS total_sales,
    SUM(oi.profit) AS total_profit
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_sales DESC;

-- 18. Top 20 Products by Sales
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.net_sales) AS total_sales,
    SUM(oi.profit) AS total_profit
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand
ORDER BY total_sales DESC
LIMIT 20;

-- Sales Trend Analysis
SELECT
    order_year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY order_year
ORDER BY order_year;
-- What you can say about the results
-- 2021: Highest sales at approximately ₹3.57 crore.
-- 2022: Sales decreased slightly to ₹3.53 crore.
-- 2023: Sales recovered slightly to ₹3.55 crore.
-- 2024: Sales remained almost stable at ₹3.55 crore, while profit margin reached 43.12%, the highest among the five years.
-- 2025: Sales were the lowest at approximately ₹3.51 crore.


-- Monthly Sales Trend
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
-- 2021: November ₹42.35L, December ₹49.01L
-- 2022: November ₹44.06L, December ₹46.35L
-- 2023: November ₹42.62L, December ₹46.75L
-- 2024: November ₹43.52L, December ₹45.33L
-- 2025: November ₹42.70L, December ₹45.55L

-- December is therefore consistently one of the strongest sales months.
-- February is consistently a lower-sales month, with sales around ₹19–21L.
-- There is also an unusual recurring pattern in July: sales increase, but profit margin drops to roughly 40%, compared with roughly 47–48% in many other months.
-- November–December also have much lower margins, around 32–33%, despite having the highest sales volumes.

-- Quarterly Performance
SELECT
    order_year,
    order_quarter,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;
-- Q4 is consistently the highest-sales quarter.

-- Across every year:
-- 2021 Q4: ₹1.21 Cr
-- 2022 Q4: ₹1.20 Cr
-- 2023 Q4: ₹1.19 Cr
-- 2024 Q4: ₹1.18 Cr
-- 2025 Q4: ₹1.16 Cr
-- So the November–December increase we identified earlier is reflected strongly at the quarterly level.

-- Customer Analysis
SELECT
    customer_type,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY customer_type
ORDER BY total_sales DESC;
-- 1. Loyal customers dominate the business.
-- 2. New customers are a very small group.
-- 3. Profit margins are remarkably similar.

-- Customer Segment Analysis
SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin,
    ROUND(
        SUM(net_sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM orders_clean
GROUP BY customer_segment
ORDER BY total_sales DESC;
-- 1. Consumer is the largest segment by volume and revenue.
-- 2. Business has the highest AOV.
-- 3. Consumer has the highest profit margin.

-- Repeat Customer Analysis
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,

    COUNT(DISTINCT CASE
        WHEN is_repeat_customer = TRUE
        THEN customer_id
    END) AS repeat_customers,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN is_repeat_customer = TRUE
            THEN customer_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT customer_id), 0),
        2
    ) AS repeat_customer_rate
FROM orders_clean;
-- 98.66% of customers who appear in orders_clean are marked as repeat customers.
-- 334 customers are classified as non-repeat

-- Average orders per customer:
SELECT
    ROUND(
        COUNT(DISTINCT order_id) * 1.0
        / NULLIF(COUNT(DISTINCT customer_id), 0),
        2
    ) AS average_orders_per_customer
FROM orders_clean;
-- approximately 5.54 orders per customer.

-- Validate repeat-customer classification
SELECT
    is_repeat_customer,
    COUNT(DISTINCT customer_id) AS customers,
    MIN(customer_order_count) AS min_order_count,
    MAX(customer_order_count) AS max_order_count,
    ROUND(
        AVG(customer_order_count),
        2
    ) AS avg_order_count
FROM orders_clean
GROUP BY is_repeat_customer
ORDER BY is_repeat_customer;
-- I validated the repeat-customer classification by comparing the is_repeat_customer flag with customer_order_count. 
-- All customers classified as non-repeat had exactly one order, while customers classified as repeat had two or more orders, confirming internal consistency.

-- Customer Lifetime Value
SELECT
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(MIN(customer_lifetime_value), 2) AS minimum_clv,
    ROUND(AVG(customer_lifetime_value), 2) AS average_clv,
    ROUND(MAX(customer_lifetime_value), 2) AS maximum_clv
FROM orders_clean;

SELECT
    customer_id,
    customer_name,
    customer_segment,
    customer_type,
    customer_order_count,
    ROUND(customer_lifetime_value, 2) AS customer_lifetime_value,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders_clean
GROUP BY
    customer_id,
    customer_name,
    customer_segment,
    customer_type,
    customer_order_count,
    customer_lifetime_value
ORDER BY customer_lifetime_value DESC
LIMIT 20;
-- 1. High-value customers are generally frequent purchasers.
-- 2. High-value customers exist across multiple segments.
-- 3. CLV and actual sales aren't always identical.

-- Region Performance
SELECT
    region,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY region
ORDER BY total_sales DESC;
-- South generates the most sales and profit in absolute terms, while North has the highest percentage margin.

-- State-Level Analysis
SELECT
    customer_state,
    region,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(net_sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY customer_state, region
ORDER BY total_sales DESC;
-- 1. Pennsylvania has the highest sales in the result you provided.
-- 2. California and New York are also major contributors.
-- 3. The highest-volume states aren't necessarily the highest-margin states.

-- Product Analysis
SELECT
    p.product_category,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.net_sales) AS total_sales,
    SUM(oi.profit) AS total_profit,
    ROUND(
        SUM(oi.profit) / NULLIF(SUM(oi.net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_sales DESC;
-- 1. Electronics is the largest sales category
-- 2. Grocery has the highest margin
-- 3. Office Supplies is another high-margin category

-- Top 20 Products
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.net_sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(
        SUM(oi.profit) / NULLIF(SUM(oi.net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand
ORDER BY total_sales DESC
LIMIT 20;
-- Product-level analysis showed that the highest-revenue products were concentrated in Electronics.
-- However, profitability varied significantly across products, indicating that revenue alone is not sufficient for evaluating product performance

-- Top 20 Products by Profit
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.net_sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(
        SUM(oi.profit) / NULLIF(SUM(oi.net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.product_category,
    p.brand
ORDER BY total_profit DESC
LIMIT 20;
-- The comparison between sales and profitability showed that the highest-revenue products were not always the highest-profit products. 
-- For example, OnePlus Gaming Consoles generated ₹9.47 lakh in sales and ₹3.77 lakh profit, while some products with higher sales generated lower absolute profit. 
-- This highlights the importance of evaluating both revenue and profit when assessing product performance.

-- Brand Analysis
SELECT
    p.brand,
    COUNT(DISTINCT p.product_id) AS products,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.net_sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(
        SUM(oi.profit) / NULLIF(SUM(oi.net_sales), 0) * 100,
        2
    ) AS profit_margin
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_sales DESC;
-- The brands generating the most revenue are not necessarily the brands generating the highest margin.

-- Return & Cancellation Analysis
SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN LOWER(return_status) = 'returned'
        THEN order_id
    END) AS returned_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN LOWER(return_status) = 'returned'
            THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS return_rate
FROM orders_clean;
-- approximately 6.85% of orders were returned in the dataset.

-- Return Reasons
SELECT
    return_reason,
    COUNT(DISTINCT order_id) AS returned_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0
        / NULLIF(
            SUM(COUNT(DISTINCT order_id)) OVER (),
            0
        ),
        2
    ) AS percentage_of_returns
FROM orders_clean
WHERE LOWER(return_status) = 'returned'
GROUP BY return_reason
ORDER BY returned_orders DESC;
-- There isn't a single overwhelmingly dominant return reason. The largest category, Wrong Product, represents only 13.07% of returns.

-- Cancellation Analysis
SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN LOWER(order_status) = 'cancelled'
        THEN order_id
    END) AS cancelled_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN LOWER(order_status) = 'cancelled'
            THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS cancellation_rate
FROM orders_clean;
-- Return rate: 6.85%
-- Cancellation rate: 6.08%

-- Cancellation by Customer Type
SELECT
    customer_type,
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN LOWER(order_status) = 'cancelled'
        THEN order_id
    END) AS cancelled_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN LOWER(order_status) = 'cancelled'
            THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS cancellation_rate,

    ROUND(SUM(net_sales), 2) AS total_sales
FROM orders_clean
GROUP BY customer_type
ORDER BY cancellation_rate DESC;
-- New customers have the highest cancellation rate — 6.89%.
-- Loyal customers have the lowest — 6.05%.
-- The difference between the highest and lowest rate is only 0.84 percentage points, so cancellation rates are relatively close across customer types.
-- Loyal customers account for most cancellations in absolute numbers (7,838) because they represent the overwhelming majority of orders.
-- The customer type analysis therefore shows a difference in cancellation rate, while the absolute number of cancellations is largely driven by order volume.

-- Cancellation by Sales Channel
SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN LOWER(order_status) = 'cancelled'
        THEN order_id
    END) AS cancelled_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN LOWER(order_status) = 'cancelled'
            THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS cancellation_rate,

    ROUND(SUM(net_sales), 2) AS total_sales

FROM orders_clean
GROUP BY sales_channel
ORDER BY cancellation_rate DESC;
-- Marketplace: highest cancellation rate at 6.19%.

-- Cancellation by Payment Method
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN LOWER(order_status) = 'cancelled'
        THEN order_id
    END) AS cancelled_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN LOWER(order_status) = 'cancelled'
            THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS cancellation_rate,

    ROUND(SUM(net_sales), 2) AS total_sales

FROM orders_clean
GROUP BY payment_method
ORDER BY cancellation_rate DESC;
-- PayPal: highest cancellation rate at 6.39%.
-- Credit Card: lowest at 5.96%.

-- Delivery Performance Analysis
SELECT
    delivery_performance,
    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(
        COUNT(DISTINCT order_id) * 100.0
        / SUM(COUNT(DISTINCT order_id)) OVER (),
        2
    ) AS order_percentage,

    ROUND(AVG(delivery_variance), 2) AS avg_delivery_variance,

    ROUND(SUM(net_sales), 2) AS total_sales

FROM orders_clean
GROUP BY delivery_performance
ORDER BY total_orders DESC;

-- Late Delivery by Shipping Method
SELECT
    shipping_method,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN delivery_performance = 'Late'
        THEN order_id
    END) AS late_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN delivery_performance = 'Late'
            THEN order_id
        END) * 100.0
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN delivery_performance IN ('Early', 'On Time', 'Late')
                THEN order_id
            END),
            0
        ),
        2
    ) AS late_rate,

    ROUND(AVG(
        CASE
            WHEN delivery_performance = 'Late'
            THEN delivery_variance
        END
    ), 2) AS avg_late_days

FROM orders_clean
GROUP BY shipping_method
ORDER BY late_rate DESC;
-- I compared late-delivery performance across shipping methods. 
-- The late rate was quite consistent, ranging from 14.49% to 14.96%, with an average delay of around 2.5 days. 
-- This indicates that the dataset does not show a large difference in late-delivery rates across shipping methods.


-- Delivery Performance by Region
SELECT
    region,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN delivery_performance = 'Late'
        THEN order_id
    END) AS late_orders,

    COUNT(DISTINCT CASE
        WHEN delivery_performance = 'On Time'
        THEN order_id
    END) AS on_time_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN delivery_performance = 'Late'
            THEN order_id
        END) * 100.0
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN delivery_performance IN ('Early', 'On Time', 'Late')
                THEN order_id
            END),
            0
        ),
        2
    ) AS late_rate,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN delivery_performance = 'On Time'
            THEN order_id
        END) * 100.0
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN delivery_performance IN ('Early', 'On Time', 'Late')
                THEN order_id
            END),
            0
        ),
        2
    ) AS on_time_rate

FROM orders_clean
GROUP BY region
ORDER BY late_rate DESC;
-- I analyzed delivery performance across regions and found that late-delivery rates were relatively consistent, ranging from 14.63% in the West to 15.02% in the Central region. 
-- The difference was only 0.39 percentage points, suggesting that there is no large regional variation in late-delivery rates within this dataset.

-- Delivery Performance vs Customer Rating
SELECT
    delivery_performance,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(AVG(customer_rating), 2) AS average_rating,

    ROUND(AVG(net_sales), 2) AS average_order_value,

    ROUND(AVG(profit), 2) AS average_profit

FROM orders_clean
WHERE customer_rating IS NOT NULL
GROUP BY delivery_performance
ORDER BY
    CASE delivery_performance
        WHEN 'Early' THEN 1
        WHEN 'On Time' THEN 2
        WHEN 'Late' THEN 3
        WHEN 'Not Available' THEN 4
    END;
-- I compared customer ratings across delivery-performance categories. 
-- Orders delivered early had an average rating of 4.02, on-time orders had 3.73, and late orders had 3.22. 
-- This shows a strong descriptive relationship between delivery performance and customer ratings, although I would need further analysis to establish causality.

-- Delivery Performance by Warehouse
SELECT
    warehouse,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN delivery_performance = 'Late'
        THEN order_id
    END) AS late_orders,

    COUNT(DISTINCT CASE
        WHEN delivery_performance = 'On Time'
        THEN order_id
    END) AS on_time_orders,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN delivery_performance = 'Late'
            THEN order_id
        END) * 100.0
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN delivery_performance IN ('Early', 'On Time', 'Late')
                THEN order_id
            END),
            0
        ),
        2
    ) AS late_rate,

    ROUND(
        AVG(
            CASE
                WHEN delivery_performance = 'Late'
                THEN delivery_variance
            END
        ),
        2
    ) AS avg_late_days

FROM orders_clean
GROUP BY warehouse
ORDER BY late_rate DESC;
-- WH-009 has the highest late rate: 15.76%.
-- WH-010 has the lowest: 14.15%.
-- The difference is 1.61 percentage points.
-- Average delay is fairly consistent, ranging from 2.45 to 2.63 days.
-- WH-019 has the highest average delay among late orders at 2.63 days, despite not having the highest late rate.
-- Warehouse order volumes are quite similar, so the comparison is less affected by major differences in volume.


-- Payment Analysis
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) * 100.0 / NULLIF(SUM(net_sales), 0),
        2
    ) AS profit_margin
FROM orders_clean
GROUP BY payment_method
ORDER BY total_sales DESC;
-- Credit Card is the largest payment method by both orders and sales.
-- Credit Card generated ₹5.34 Cr sales and ₹2.29 Cr profit.
-- Digital Wallet has the highest observed margin at 43.11%.
-- Debit Card has the lowest at 42.92%.
-- The entire margin range is only 0.19 percentage points, so profitability is extremely consistent across payment methods.
-- This is consistent with what we saw earlier: payment method also showed only a small difference in cancellation rates.

-- Marketing Channel Analysis
SELECT
    marketing_channel,

    COUNT(DISTINCT customer_id) AS customers,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(SUM(net_sales), 2) AS total_sales,

    ROUND(SUM(profit), 2) AS total_profit,

    ROUND(
        SUM(profit) * 100.0 / NULLIF(SUM(net_sales), 0),
        2
    ) AS profit_margin

FROM orders_clean
GROUP BY marketing_channel
ORDER BY total_sales DESC;
-- 1. Organic Search has the highest sales.
-- It generated ₹3.57 Cr across 27,742 orders.

-- 2. Google Ads is second by sales.
-- It generated ₹2.65 Cr.

-- 3. YouTube has the lowest sales volume.
-- It generated approximately ₹0.52 Cr.

-- 4. Profit margins are remarkably consistent.
-- They range from 42.79% to 43.19%, only 0.40 percentage points apart.

-- 5. Direct has the highest margin among these channels at 43.19%.
-- TikTok follows at 43.15%, while Google Ads has the lowest at 42.79%.

-- Customer Rating Analysis
SELECT
    customer_rating,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0
        / SUM(COUNT(DISTINCT order_id)) OVER (),
        2
    ) AS order_percentage,
    ROUND(AVG(net_sales), 2) AS average_order_value,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders_clean
WHERE customer_rating IS NOT NULL
GROUP BY customer_rating
ORDER BY customer_rating;
-- I analyzed the distribution of customer ratings and found that ratings were concentrated mainly between 3.5 and 4.0, with 3.7 being the most frequent rating at 8.24% of rated orders. 
-- I also compared ratings with delivery performance and observed that late-delivery orders had a lower average rating than early and on-time orders.

-- Review Sentiment Analysis
SELECT
    review_sentiment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0
        / SUM(COUNT(DISTINCT order_id)) OVER (),
        2
    ) AS order_percentage,
    ROUND(AVG(customer_rating), 2) AS average_rating,
    ROUND(AVG(net_sales), 2) AS average_order_value,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders_clean
WHERE review_sentiment <> 'No Review'
GROUP BY review_sentiment
ORDER BY total_orders DESC;
-- I analyzed review sentiment and found that 68.76% of reviewed orders were classified as positive, 30.54% as neutral, and 0.70% as negative. 
-- Average ratings aligned with sentiment, at 3.93 for positive, 3.14 for neutral, and 2.28 for negative. 
-- I also observed differences in average order value and profit across sentiment groups, but I would treat those as descriptive associations rather than causal relationships.

-- Profitability Analysis
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN profit < 0 THEN order_id
    END) AS loss_orders,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN profit < 0 THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS loss_order_rate,
    ROUND(SUM(
        CASE
            WHEN profit < 0 THEN profit
            ELSE 0
        END
    ), 2) AS total_loss,
    ROUND(MIN(profit), 2) AS largest_single_order_loss
FROM orders_clean;
-- I performed a profitability quality check and identified 1,296 loss-making orders out of 138,116, representing 0.94% of total orders. 
-- These orders generated a combined loss of ₹2.01 lakh, with the largest individual loss being ₹1,281.59. 
-- I then planned a deeper analysis to identify the characteristics of these loss-making orders.

-- Losses by Product Category
SELECT
    p.product_category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN oi.profit < 0 THEN oi.order_id
    END) AS loss_orders,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN oi.profit < 0 THEN oi.order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT oi.order_id), 0),
        2
    ) AS loss_order_rate,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(SUM(
        CASE
            WHEN oi.profit < 0 THEN oi.profit
            ELSE 0
        END
    ), 2) AS total_loss
FROM order_items_clean oi
JOIN product_catalog_clean p
    ON oi.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_loss ASC;
-- 1. Electronics is the main loss area.
-- 2. Automotive also has a relatively high loss rate — 3.50%.
-- 3. Some high-margin categories have very few loss orders.
-- 4. Loss rate and total loss tell different stories.


-- What is causing the losses?
SELECT
    CASE
        WHEN gross_sales = 0 THEN 'No Gross Sales'
        WHEN discount_amount = 0 THEN 'No Discount'
        WHEN (discount_amount / gross_sales) * 100 <= 10 THEN '0-10%'
        WHEN (discount_amount / gross_sales) * 100 <= 20 THEN '10-20%'
        WHEN (discount_amount / gross_sales) * 100 <= 30 THEN '20-30%'
        ELSE '30%+'
    END AS discount_bucket,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN profit < 0 THEN order_id
    END) AS loss_orders,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN profit < 0 THEN order_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS loss_order_rate,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(
            CASE
                WHEN profit < 0 THEN profit
                ELSE 0
            END
        ),
        2
    ) AS total_loss
FROM orders_clean
GROUP BY 1
ORDER BY loss_order_rate DESC;
-- All observed loss-making orders occurred in the 30%+ discount bucket, indicating a strong association between high discount levels and negative profitability in this dataset.
-- ₹17.02 Cr+? — don't use an unverified aggregate here; use your SQL output for the exact total.
-- Business performance remained relatively stable from 2021–2025.
-- Q4 had the highest sales but substantially lower profit margins than Q1–Q3.
-- 98.66% of customers with orders were repeat customers.
-- South generated the highest sales volume, while North had a higher margin.
-- Electronics generated the highest category sales but had a comparatively low margin.
-- Overall cancellation rate = 6.08%.
-- Overall return rate = 6.85%.
-- 63.30% of orders with delivery classification were on time when considering all orders as reported; 17.78% had unavailable delivery information.
-- Late deliveries had an average customer rating of 3.22, versus 4.02 for early deliveries.
-- All 1,296 loss-making orders occurred in the 30%+ discount bucket, with a 7.08% loss-order rate in that bucket. This is an observed association, not proof of causality.
-- Marketing and payment-channel profit margins were relatively consistent.


