create database c0624;
use c0624;
drop database c0624;
-- Tạp Bảng student có các trường lần lượt là id, name, age, country. --
CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    age int,
    country varchar(50)
);
-- Tạo Bảng Class có các trường lần lượt là id, name. --
create table class (
id int,
name varchar(50)
);
-- Tạo Bảng Teacher có các trường lần lượt là id, name, age, country. --
CREATE TABLE techer (
    id INT,
    name VARCHAR(50),
    age INT,
    country VARCHAR(50)
)
