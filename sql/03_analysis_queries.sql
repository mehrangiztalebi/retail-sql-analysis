-- =========================
-- RETAIL SALES ANALYSIS
-- =========================

-- 1. TOTAL REVENUE
SELECT 
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


-- 2. TOTAL ORDERS
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- 3. TOTAL CUSTOMERS
SELECT 
    COUNT(*) AS total_customers
FROM customers;


-- 4. REVENUE BY CATEGORY
SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- 5. TOP 5 PRODUCTS BY REVENUE
SELECT 
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- 6. TOP CUSTOMERS
SELECT 
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.full_name
ORDER BY total_spent DESC;


-- 7. NUMBER OF ORDERS PER CUSTOMER
SELECT 
    c.full_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_orders DESC;


-- 8. AVERAGE ORDER VALUE (AOV)
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) t;


-- 9. DAILY SALES TREND
SELECT 
    o.order_date,
    SUM(oi.quantity * oi.unit_price) AS daily_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;


-- 10. CUSTOMER RANKING (WINDOW FUNCTION)
SELECT 
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS customer_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.full_name;
