-- Insert Customers
INSERT INTO customers (customer_id, full_name, gender, age, city, join_date) VALUES
(1, 'Ali Rezaei', 'Male', 28, 'Sydney', '2024-01-10'),
(2, 'Sara Mohammadi', 'Female', 32, 'Melbourne', '2024-02-15'),
(3, 'John Smith', 'Male', 40, 'Sydney', '2024-03-01'),
(4, 'Emma Brown', 'Female', 25, 'Brisbane', '2024-03-05');

-- Insert Products
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1500),
(2, 'Phone', 'Electronics', 900),
(3, 'Chair', 'Furniture', 120),
(4, 'Table', 'Furniture', 300);

-- Insert Orders
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-03-10'),
(2, 2, '2024-03-11'),
(3, 1, '2024-03-12'),
(4, 3, '2024-03-15');

-- Insert Order Items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 1500),
(2, 1, 2, 1, 900),
(3, 2, 3, 2, 120),
(4, 3, 4, 1, 300),
(5, 4, 2, 1, 900);
