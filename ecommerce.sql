SELECT SUM(total_amount) AS total_revenue
FROM orders;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

WITH yearly_revenue AS (
    SELECT YEAR(order_date) AS year,
           SUM(total_amount) AS revenue
    FROM orders
    GROUP BY year
)
SELECT year,
       revenue,
       LAG(revenue) OVER (ORDER BY year) AS prev_year_revenue,
       ROUND((revenue - LAG(revenue) OVER (ORDER BY year)) 
             / LAG(revenue) OVER (ORDER BY year) * 100, 2) AS pct_change
FROM yearly_revenue;

SELECT c.customer_id, c.name AS customer_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 10;

SELECT p.category,
       SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_units_sold DESC;

SELECT c.name AS customer_name,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY avg_order_value DESC;

SELECT ROUND(
    100.0 * SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) 
    / COUNT(*), 2) AS repeat_purchase_pct
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
) AS sub;

SELECT p.product_name,
       ROUND(AVG(oi.unit_price - p.unit_cost), 2) AS avg_margin
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY avg_margin DESC
LIMIT 10;

SELECT MONTH(order_date) AS month,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY revenue DESC;

SELECT c.country,
       SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;

SELECT c.name AS customer_name,
       COUNT(o.order_id) AS orders_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY orders_count DESC;

SELECT p.product_name,
       SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC
LIMIT 10;

SELECT p.product_name,
       ROUND(AVG(oi.quantity), 2) AS avg_units_per_order
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY avg_units_per_order DESC;

SELECT c.name AS customer_name,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY avg_order_value DESC
LIMIT 10;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(DISTINCT customer_id) AS new_customers
FROM orders
GROUP BY month
ORDER BY month;
