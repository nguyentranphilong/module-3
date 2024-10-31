-- Tạo cơ sở dữ liệu và sử dụng nó
CREATE DATABASE maganement_codegym_demo;
USE maganement_codegym_demo;

-- Tạo bảng jame_account
CREATE TABLE jame_account(
    user_name VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50)
);

-- Tạo bảng class
CREATE TABLE class(
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50)
);

-- Tạo bảng student
CREATE TABLE student(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    student_birthday DATE,
    student_gender BIT,
    student_email VARCHAR(50),
    student_point DOUBLE,
    user_name VARCHAR(50),
    class_id INT,
    FOREIGN KEY (user_name) REFERENCES jame_account(user_name),
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

-- Tạo bảng instructor
CREATE TABLE instructor(
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_name VARCHAR(50),
    instructor_birthday DATE,
    instructor_salary DOUBLE
);

-- Tạo bảng instructor_class
CREATE TABLE instructor_class(
    class_id INT,
    instructor_id INT,
    PRIMARY KEY (class_id, instructor_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);

-- Chèn dữ liệu vào bảng class
INSERT INTO class (class_name) 
VALUES 
    ('c1121g1'), 
    ('c1221g1'),
    ('a0821i1'),
    ('a0921i1');

-- Chèn dữ liệu vào bảng jame_account
INSERT INTO jame_account(user_name, password)
VALUES
    ('cunn', '12345'),
    ('chunglh', '12345'),
    ('hoanhh', '12345'),
    ('dungd', '12345'),
    ('huynhtd', '12345'),
    ('hainm', '12345'),
    ('namtv', '12345'),
    ('hieuvm', '12345'),
    ('kynx', '12345'),
    ('vulm', '12345'),
    ('anv', '12345'),
    ('bnv', '12345');

-- Chèn dữ liệu vào bảng instructor
INSERT INTO instructor(instructor_name, instructor_birthday, instructor_salary)
VALUES
    ('tran van chanh', '1985-02-03', 100),
    ('dang chi trung', '1985-02-03', 200),
    ('nguyen vu thanh tien', '1985-02-03', 300);

-- Chèn dữ liệu vào bảng student
INSERT INTO student(student_name, student_birthday, student_gender, student_point, class_id, user_name)
VALUES 
    ('nguyen ngoc cu', '1981-12-12', 1, 8, 1, 'cunn'),
    ('le hai chung', '1981-12-12', 1, 5, 1, 'chunglh'),
    ('hoang huu hoan', '1990-12-12', 1, 6, 2, 'hoanhh'),
    ('dau dung', '1987-12-12', 1, 8, 1, 'dungd'),
    ('ta dinh huynh', '1981-12-12', 1, 7, 2, 'huynhtd'),
    ('nguyen minh hai', '1987-12-12', 1, 9, 1, 'hainm'),
    ('tran van nam', '1989-12-12', 1, 4, 2, 'namtv'),
    ('vo minh hieu', '1981-12-12', 1, 3, 1, 'hieuvm'),
    ('le xuan ky', '1981-12-12', 1, 7, 2, 'kynx'),
    ('le minh vu', '1981-12-12', 1, 7, 1, 'vulm'),
    ('nguyen van a', '1981-12-12', 1, 8, NULL, 'anv'),
    ('tran van b', '1981-12-12', 1, 5, NULL, 'bnv');

-- Chèn dữ liệu vào bảng instructor_class
INSERT INTO instructor_class(class_id, instructor_id)
VALUES 
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (3, 1),
    (3, 2);

-- 1. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào (sử dụng join).
SELECT * FROM student s
INNER JOIN class c ON s.class_id = c.class_id;

-- 2. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào và cả các bạn đã đăng ký nhưng chưa có lớp học.
SELECT s.student_name, c.class_name 
FROM student s
LEFT JOIN class c ON s.class_id = c.class_id;

-- 3. Lấy thông tin của các học viên tên “Hai” và 'Huynh'
SELECT * FROM student
WHERE student_name LIKE '% Hai' OR student_name LIKE '% Huynh';

-- 4. Lấy ra học viên có điểm lớn hơn 5 
SELECT student_name, student_point 
FROM student
WHERE student_point > 5;

-- 5. Lấy ra học viên có họ là “nguyen”
SELECT student_name 
FROM student
WHERE student_name LIKE 'nguyen %';

-- 6. Thống kê số lượng học sinh theo từng loại điểm.
SELECT student_point, COUNT(*) AS "So luong"
FROM student
GROUP BY student_point;

-- 7. Thống kê số lượng học sinh theo điểm và điểm phải lớn hơn 5
SELECT student_point, COUNT(*) AS "So luong"
FROM student
WHERE student_point > 5
GROUP BY student_point;

-- 8. Thống kê số lượng học sinh theo điểm lớn hơn 5 và chỉ hiện thị với số lượng >= 2
SELECT student_point, COUNT(*) AS "So luong"
FROM student
WHERE student_point > 5
GROUP BY student_point
HAVING COUNT(*) > 2;

-- 9. Lấy ra danh sách học viên của lớp c1121g1 và sắp xếp tên học viên theo thứ tự alphabet.
SELECT s.student_name 
FROM student s
INNER JOIN class c ON s.class_id = c.class_id
WHERE c.class_name = 'c1121g1'
ORDER BY s.student_name;

-- 10. Hiển thị danh sách các lớp có học viên theo học và số lượng học viên của mỗi lớp.
SELECT c.class_name, COUNT(s.student_id) AS so_luong_hoc_vien
FROM class c
LEFT JOIN student s ON c.class_id = s.class_id
GROUP BY c.class_name;

-- 11. Tính điểm lớn nhất của mỗi lớp.
SELECT c.class_name, MAX(s.student_point) AS diem_lon_nhat
FROM class c
JOIN student s ON c.class_id = s.class_id
GROUP BY c.class_name;

-- 12. Tính điểm trung bình của từng lớp.
SELECT c.class_name, AVG(s.student_point) AS diem_trung_binh
FROM class c
JOIN student s ON c.class_id = s.class_id
GROUP BY c.class_name;

-- 13. Lấy ra toàn bộ tên và ngày sinh các instructor và student ở CodeGym (sử dụng UNION).
SELECT instructor_name AS ho_ten, instructor_birthday AS ngay_sinh 
FROM instructor
UNION
SELECT student_name AS ho_ten, student_birthday AS ngay_sinh 
FROM student;

-- 14. Lấy ra top 3 học viên có điểm cao nhất của trung tâm.
SELECT student_name, student_point
FROM student
ORDER BY student_point DESC
LIMIT 3;

-- 15. Lấy ra các học viên có điểm số là cao nhất của trung tâm.
SELECT student_name, student_point
FROM student
WHERE student_point = (SELECT MAX(student_point) FROM student);

-- 16. Đếm số lượng học sinh nữ theo từng lớp.
SELECT c.class_name, COUNT(s.student_id) AS so_luong_hoc_sinh_nu
FROM class c
JOIN student s ON c.class_id = s.class_id
WHERE s.student_gender = 0
GROUP BY c.class_name;

-- 17. Đánh và xóa index cho cột name ở bảng student.

CREATE INDEX idx_student_name ON student(student_name);
DROP INDEX idx_student_name ON student;
-- 18. Tạo view chỉ chứa thông tin id và name của student.

CREATE VIEW view_student AS
SELECT student_id, student_name
FROM student;

-- 19. Tạo stored procedure (SP) có tên findByName, có tham số truyền vào là name. 

DELIMITER //
CREATE PROCEDURE findByName(IN s_name VARCHAR(50))
BEGIN
    SELECT * FROM student WHERE student_name = s_name;
END //
DELIMITER ;



