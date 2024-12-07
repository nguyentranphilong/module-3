create database datacase;
use datacase;
CREATE TABLE Student (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL,       
    birthday DATE NOT NULL,
    gender TINYINT(1) NOT NULL,        
    email VARCHAR(255) UNIQUE,     
    point DOUBLE NOT NULL,           
    class_id INT,                      

    CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES Class(id)
);
CREATE TABLE Class (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL        
);
INSERT INTO Student (name, birthday, gender, email, point, class_id)
VALUES 
('Nguyen Van A', '2000-05-12', 1, 'nva@example.com', 8.5, 1),
('Tran Thi B', '2001-11-23', 0, 'ttb@example.com', 7.8, 1);student