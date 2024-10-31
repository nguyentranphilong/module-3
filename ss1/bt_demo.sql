CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    BirthDate DATE,
    Gender INT,
    CustomerCode VARCHAR(10),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(255),
    Address VARCHAR(255)
);

insert INTO Customers (ID, Name, BirthDate, Gender, CustomerCode, PhoneNumber, Email, Address) 
VALUES
(1, 'nguyen van a', '2000-12-12', 1, 'KH1', '0111222333', 'nguyenvana@gmail.com', 'Da Nang'),
(2, 'tran thi b', '1995-07-08', 0, 'KH2', '0988777666', 'tranthib@gmail.com', 'Ha Noi'),
(3, 'le van c', '1988-03-22', 1, 'KH3', '0909123456', 'levanc@gmail.com', 'Ho Chi Minh City'),
(4, 'pham thi d', '2001-11-15', 0, 'KH4', '0933555444', 'phamthid@gmail.com', 'Hai Phong'),
(5, 'nguyen van e', '1999-09-30', 1, 'KH5', '0123456789', 'nguyenvane@gmail.com', 'Can Tho'),
(6, 'do thi f', '2002-05-19', 0, 'KH6', '0988001122', 'dothif@gmail.com', 'Hue');

select * from Customers;

set sql_safe_updates = 0;
set sql_safe_updates = 1;

update customers
set name = "bui van c"
where name = "le van c";

delete from customers
where id = 1;
