create database test;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    quantity INT NOT NULL,
    color VARCHAR(50),
    description TEXT,
    category VARCHAR(100)
);
INSERT INTO products (name, price, quantity, color, description, category) VALUES
('Laptop', 1500.00, 10, 'Silver', 'High-performance laptop', 'Electronics'),
('Chair', 45.00, 50, 'Black', 'Ergonomic office chair', 'Furniture'),
('Headphones', 120.00, 30, 'Blue', 'Noise-cancelling headphones', 'Electronics');
