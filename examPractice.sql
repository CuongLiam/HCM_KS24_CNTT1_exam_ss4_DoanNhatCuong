-- Library Management SQL for MySQL Workbench
-- Câu 1 (DDL): Create tables Reader, Book, Borrow

-- Safe drops to allow re-run
DROP TABLE IF EXISTS Borrow;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Reader;

-- 1) Reader
CREATE TABLE Reader (
	reader_id INT AUTO_INCREMENT PRIMARY KEY,
	reader_name VARCHAR(100) NOT NULL,
	phone VARCHAR(15) UNIQUE,
	register_date DATE DEFAULT (CURRENT_DATE)
);

-- 2) Book
CREATE TABLE Book (
	book_id INT PRIMARY KEY,
	book_title VARCHAR(150) NOT NULL,
	author VARCHAR(100),
	publish_year INT,
	CHECK (publish_year >= 1900)
);

-- 3) Borrow
CREATE TABLE Borrow (
	reader_id INT,
	book_id INT,
	borrow_date DATE DEFAULT (CURRENT_DATE),
	return_date DATE
);

-- Câu 2 (DDL): ALTER TABLE changes
-- Add email to Reader
ALTER TABLE Reader
	ADD COLUMN email VARCHAR(100) UNIQUE;

-- Modify author type in Book
ALTER TABLE Book
	MODIFY COLUMN author VARCHAR(150);

-- Add constraint: return_date >= borrow_date (or NULL allowed)
ALTER TABLE Borrow
	ADD CONSTRAINT chk_return_date
	CHECK (return_date IS NULL OR return_date >= borrow_date);

-- Câu 3 (DML): Insert sample data
-- Reader
INSERT INTO Reader (reader_id, reader_name, phone, email, register_date) VALUES
	(1, 'Nguyễn Văn An', '0901234567', 'an.nguyen@gmail.com', '2024-09-01'),
	(2, 'Trần Thị Bình', '0912345678', 'binh.tran@gmail.com', '2024-09-05'),
	(3, 'Lê Minh Châu', '0923456789', 'chau.le@gmail.com', '2024-09-10');

-- Book
INSERT INTO Book (book_id, book_title, author, publish_year) VALUES
	(101, 'Lập trình C căn bản', 'Nguyễn Văn A', 2018),
	(102, 'Cơ sở dữ liệu', 'Trần Thị B', 2020),
	(103, 'Lập trình Java', 'Lê Minh C', 2019),
	(104, 'Hệ quản trị MySQL', 'Phạm Văn D', 2021);

-- Borrow
INSERT INTO Borrow (reader_id, book_id, borrow_date, return_date) VALUES
	(1, 101, '2024-09-15', NULL),
	(1, 102, '2024-09-15', '2024-09-25'),
	(2, 103, '2024-09-18', NULL);

