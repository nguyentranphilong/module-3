create database demo;
-- tạo bảng products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_code INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    product_price DECIMAL(10 , 2 ) NOT NULL,
    product_amount INT NOT NULL,
    product_description TEXT,
    product_status VARCHAR(20) NOT NULL
);
-- thêm dữ liệu vào bảng products
INSERT INTO products (id, product_code, product_name, product_price, product_amount, product_description, product_status)
VALUES
(1, 1001, 'Sản phẩm A', 150000.00, 50, 'Mô tả sản phẩm A', 'Còn hàng'),
(2, 1002, 'Sản phẩm B', 250000.00, 30, 'Mô tả sản phẩm B', 'Còn hàng'),
(3, 1003, 'Sản phẩm C', 120000.00, 100, 'Mô tả sản phẩm C', 'Hết hàng'),
(4, 1004, 'Sản phẩm D', 350000.00, 20, 'Mô tả sản phẩm D', 'Còn hàng'),
(5, 1005, 'Sản phẩm E', 450000.00, 0, 'Mô tả sản phẩm E', 'Hết hàng');

-- 1. Tạo Unique Index trên bảng Products (sử dụng cột product_code để tạo chỉ mục)
CREATE UNIQUE INDEX idx_product_code ON products(product_code);
-- 2. Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
CREATE INDEX idx_product_name_price ON products (product_name, product_price);
-- 3. Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN SELECT * FROM products WHERE product_name = 'Sản phẩm A' AND product_price = 150000.00;
-- 4. So sánh câu truy vấn trước và sau khi tạo index
-- khi ta sử dụng explain để biết câu lệnh thực thi ntn thì sẽ thấy: trước khi có index câu truy vấn sẽ quét qua toàn bộ bảng để kiếm các dòng phù hợp, còn sau khi sử dụng index ta chỉ thấy nó quét qua đúng 1 lần của dòng đó
-- 4. Tạo view lấy về các thông tin: product_code, product_name, product_price, product_status từ bảng products.
create view products_info as
select product_code, product_name, product_price, product_status
from products;
-- 5. Tiến hành sửa đổi view

-- 6. Tiến hành xoá view
drop view products_info;
-- 7. Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM products;
END //

DELIMITER ;

-- 8. Tạo store procedure thêm một sản phẩm mới
DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_product_code INT,
    IN p_product_name VARCHAR(50),
    IN p_product_price DECIMAL(10,2),
    IN p_product_amount INT,
    IN p_product_description TEXT,
    IN p_product_status VARCHAR(20)
)
BEGIN
    INSERT INTO products (product_code, product_name, product_price, product_amount, product_description, product_status)
    VALUES (p_product_code, p_product_name, p_product_price, p_product_amount, p_product_description, p_product_status);
END //

DELIMITER ;

-- 9. Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //

CREATE PROCEDURE UpdateProductById(
    IN p_id INT,
    IN p_product_code INT,
    IN p_product_name VARCHAR(50),
    IN p_product_price DECIMAL(10,2),
    IN p_product_amount INT,
    IN p_product_description TEXT,
    IN p_product_status VARCHAR(20)
)
BEGIN
    UPDATE products
    SET product_code = p_product_code,
        product_name = p_product_name,
        product_price = p_product_price,
        product_amount = p_product_amount,
        product_description = p_product_description,
        product_status = p_product_status
    WHERE id = p_id;
END //

DELIMITER ;

-- 10. Tạo store procedure xoá sản phẩm theo id
DELIMITER //

CREATE PROCEDURE DeleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM products WHERE id = p_id;
END //

DELIMITER ;

