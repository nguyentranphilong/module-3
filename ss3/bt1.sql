CREATE DATABASE QuanLySinhVien;

USE QuanLySinhVien;

CREATE TABLE class (
    class_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(60) NOT NULL,
    start_date DATETIME NOT NULL,
    status BIT
);

CREATE TABLE student (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(30) NOT NULL,
    address VARCHAR(50),
    phone VARCHAR(20),
    status BIT,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES class (class_id)
);

CREATE TABLE subject (
    sub_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(30) NOT NULL,
    credit TINYINT NOT NULL DEFAULT 1 CHECK (credit >= 1),
    status BIT DEFAULT 1
);

CREATE TABLE mark (
    mark_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sub_id INT NOT NULL,
    student_id INT NOT NULL,
    mark FLOAT DEFAULT 0 CHECK (mark BETWEEN 0 AND 100),
    exam_times TINYINT DEFAULT 1,
    UNIQUE (sub_id, student_id),
    FOREIGN KEY (sub_id) REFERENCES subject (sub_id),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);
-- Thêm dữ liệu vào bảng class
INSERT INTO class (class_name, start_date, status)
VALUES 
    ('Toán 101', '2024-01-15 08:00:00', 1),
    ('Lịch sử 101', '2024-01-16 09:00:00', 1),
    ('Vật lý 101', '2024-01-17 10:00:00', 1);

-- Thêm dữ liệu vào bảng student
INSERT INTO student (student_name, address, phone, status, class_id)
VALUES 
    ('Nguyễn Văn Hoàng', '123 Đường Chính', '0123-456-789', 1, 1),
    ('Trần Thị Mai', '456 Đường Maple', '0987-654-321', 1, 2),
    ('Lê Văn Minh', '789 Đường Oak', '0345-678-910', 1, 3),
    ('Phạm Thị Lan', '101 Đường Pine', '0567-890-123', 1, 1);

-- Thêm dữ liệu vào bảng subject
INSERT INTO subject (sub_name, credit, status)
VALUES 
    ('Đại số', 3, 1),
    ('Lịch sử Thế giới', 4, 1),
    ('Cơ học', 3, 1);

-- Thêm dữ liệu vào bảng mark
INSERT INTO mark (sub_id, student_id, mark, exam_times)
VALUES 
    (1, 1, 85.5, 1),
    (2, 2, 90.0, 1),
    (3, 3, 78.0, 1),
    (1, 4, 88.5, 1),
    (2, 1, 92.0, 2);


-- 1.Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT student_name
from student
where student_name like '% H%' ;
-- 2.Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT * 
FROM class
WHERE MONTH(start_date) = 12;
-- 3. Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT * 
FROM subject
WHERE credit BETWEEN 3 AND 5;
-- 4. Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
SET SQL_SAFE_UPDATES = 0;
UPDATE student
SET class_id = 2
WHERE student_name = 'Hung';
-- 5. Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT s.student_name AS StudentName, sub.sub_name AS SubName, m.mark AS Mark
FROM student s
JOIN mark m ON s.student_id = m.student_id
JOIN subject sub ON m.sub_id = sub.sub_id
ORDER BY m.mark DESC, s.student_name ASC;
-- 6,7,8 làm bt ss4 nha anh <3 
-- 6. Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
SELECT *
FROM subject
WHERE credit = (SELECT MAX(credit) FROM subject);
-- 7. Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT s.sub_id, s.sub_name, m.mark
FROM subject s
JOIN mark m ON s.sub_id = m.sub_id
WHERE m.mark = (SELECT MAX(mark) FROM mark);
-- 8. Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT st.student_id, st.student_name, AVG(m.mark) AS avg_mark
FROM student st
JOIN mark m ON st.student_id = m.student_id
GROUP BY st.student_id
ORDER BY avg_mark DESC;


