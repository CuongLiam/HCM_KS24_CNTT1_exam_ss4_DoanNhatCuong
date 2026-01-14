CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

--------------------------------------------------
-- Câu 1 (DDL): Tạo 3 bảng Reader, Book, Borrow
--------------------------------------------------

-- Xóa bảng cũ nếu có (để chạy lại không lỗi)
DROP TABLE IF EXISTS Borrow;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Reader;

-- 1) Bảng Reader
CREATE TABLE Reader (
    reader_id INT AUTO_INCREMENT PRIMARY KEY,
    reader_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    register_date DATE DEFAULT (CURRENT_DATE)
);

-- 2) Bảng Book
CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    publish_year INT,
    CHECK (publish_year >= 1900)
);

-- 3) Bảng Borrow
CREATE TABLE Borrow (
    reader_id INT,
    book_id INT,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    -- Khóa ngoại (tùy chọn, tốt cho thiết kế)
    CONSTRAINT fk_borrow_reader FOREIGN KEY (reader_id) REFERENCES Reader(reader_id),
    CONSTRAINT fk_borrow_book  FOREIGN KEY (book_id)  REFERENCES Book(book_id)
);

--------------------------------------------------
-- Câu 2 (DDL): ALTER TABLE
--------------------------------------------------

-- 1) Thêm cột email (VARCHAR(100), UNIQUE) vào bảng Reader
ALTER TABLE Reader
    ADD COLUMN email VARCHAR(100) UNIQUE;

-- 2) Sửa kiểu dữ liệu cột author thành VARCHAR(150)
ALTER TABLE Book
    MODIFY COLUMN author VARCHAR(150);

-- 3) Thêm ràng buộc để return_date >= borrow_date (hoặc NULL)
ALTER TABLE Borrow
    ADD CONSTRAINT chk_return_date
    CHECK (return_date IS NULL OR return_date >= borrow_date);

--------------------------------------------------
-- Câu 3 (DML)
-- 3.1 Thêm dữ liệu (INSERT)
--------------------------------------------------

-- Bảng Reader
INSERT INTO Reader (reader_id, reader_name, phone, email, register_date) VALUES
    (1, 'Nguyễn Văn An',  '0901234567', 'an.nguyen@gmail.com',   '2024-09-01'),
    (2, 'Trần Thị Bình',  '0912345678', 'binh.tran@gmail.com',   '2024-09-05'),
    (3, 'Lê Minh Châu',   '0923456789', 'chau.le@gmail.com',     '2024-09-10');

-- Bảng Book
INSERT INTO Book (book_id, book_title, author, publish_year) VALUES
    (101, 'Lập trình C căn bản', 'Nguyễn Văn A', 2018),
    (102, 'Cơ sở dữ liệu',       'Trần Thị B',  2020),
    (103, 'Lập trình Java',      'Lê Minh C',   2019),
    (104, 'Hệ quản trị MySQL',   'Phạm Văn D',  2021);

-- Bảng Borrow
INSERT INTO Borrow (reader_id, book_id, borrow_date, return_date) VALUES
    (1, 101, '2024-09-15', NULL),
    (1, 102, '2024-09-15', '2024-09-25'),
    (2, 103, '2024-09-18', NULL);

--------------------------------------------------
-- 3.2 Cập nhật dữ liệu (UPDATE)
--------------------------------------------------

-- a) Cập nhật return_date = '2024-10-01' cho tất cả lượt mượn có reader_id = 1
UPDATE Borrow
SET return_date = '2024-10-01'
WHERE reader_id = 1;

-- b) Cập nhật publish_year = 2023 cho các sách có publish_year >= 2021
UPDATE Book
SET publish_year = 2023
WHERE publish_year >= 2021;

--------------------------------------------------
-- 3.3 Xóa dữ liệu (DELETE)
--------------------------------------------------

-- Xóa các lượt mượn sách có borrow_date < '2024-09-18'
DELETE FROM Borrow
WHERE borrow_date < '2024-09-18';

--------------------------------------------------
-- 3.4 Truy vấn dữ liệu (SELECT)
--------------------------------------------------

-- Lấy toàn bộ dữ liệu từ bảng Reader
SELECT * FROM Reader;

-- Lấy toàn bộ dữ liệu từ bảng Book
SELECT * FROM Book;

-- Lấy toàn bộ dữ liệu từ bảng Borrow
SELECT * FROM Borrow;