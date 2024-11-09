create database quanlybanhang;
CREATE TABLE Customer (
    cID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Mã khách hàng
    customer_name VARCHAR(100) NOT NULL,          -- Tên khách hàng
    cAge TINYINT UNSIGNED                         -- Tuổi khách hàng

);
CREATE TABLE Orderr (
    oID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Số hóa đơn
    cID INT NOT NULL,                             -- Mã khách hàng (khóa ngoại)
    oDate DATETIME NOT NULL,                      -- Ngày mua hàng
    oTotal_price int,                             -- Tổng tiền của hóa đơn
    FOREIGN KEY (cID) REFERENCES Customer(cID)    -- Khóa ngoại liên kết với bảng Customer
);
CREATE TABLE Product (
    pID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL
);
CREATE TABLE OrderDetail (
    oID INT NOT NULL,                             -- Số hóa đơn (khóa ngoại)
    pID INT NOT NULL,                             -- Mã sản phẩm (khóa ngoại)
    oquantity INT NOT NULL,                       -- Số lượng sản phẩm trong hóa đơn
    PRIMARY KEY (oID, pID),                       -- Khóa chính kết hợp của oID và pID
    FOREIGN KEY (oID) REFERENCES Orderr(oID),      -- Khóa ngoại liên kết với bảng Order
    FOREIGN KEY (pID) REFERENCES Product(pID)     -- Khóa ngoại liên kết với bảng Product
);
-- Dữ liệu cho bảng Customer
INSERT INTO Customer (cID, customer_name, cAge) VALUES 
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Dữ liệu cho bảng Oderr
INSERT INTO orderr (oID, cID, oDate, oTotal_price) VALUES 
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Dữ liệu cho bảng Product
INSERT INTO product (pID, pName, Price) VALUES 
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Dữ liệu cho bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, oquantity) VALUES 
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);
-- 1. Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotal_price
FROM Orderr;
-- 2. Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT c.customer_name, p.pName
FROM Customer c
JOIN Orderr o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;
-- 3. Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.customer_name
FROM Customer c
LEFT JOIN Orderr o ON c.cID = o.cID
LEFT JOIN OrderDetail od ON o.oID = od.oID
WHERE od.oID IS NULL;
-- 4. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT o.oID, o.oDate, SUM(od.oQuantity * p.price) AS oTotal_price
FROM Orderr o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;