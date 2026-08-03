-- ============================================================
-- Sample Data for Library Management System
-- ============================================================

-- Authors
INSERT INTO authors (first_name, last_name, birth_year, country) VALUES
('George', 'Orwell', 1903, 'United Kingdom'),
('Jane', 'Austen', 1775, 'United Kingdom'),
('Haruki', 'Murakami', 1949, 'Japan'),
('Chimamanda', 'Ngozi Adichie', 1977, 'Nigeria'),
('Gabriel', 'García Márquez', 1927, 'Colombia');

-- Books
INSERT INTO books (title, author_id, genre, published_year, copies_total, copies_available) VALUES
('1984', 1, 'Dystopian', 1949, 4, 2),
('Animal Farm', 1, 'Political Satire', 1945, 3, 3),
('Pride and Prejudice', 2, 'Romance', 1813, 5, 4),
('Emma', 2, 'Romance', 1815, 2, 2),
('Norwegian Wood', 3, 'Literary Fiction', 1987, 3, 1),
('Kafka on the Shore', 3, 'Magical Realism', 2002, 2, 0),
('Half of a Yellow Sun', 4, 'Historical Fiction', 2006, 3, 3),
('One Hundred Years of Solitude', 5, 'Magical Realism', 1967, 4, 2);

-- Members
INSERT INTO members (first_name, last_name, email, join_date) VALUES
('Aisha', 'Khan', 'aisha.khan@example.com', '2024-01-15'),
('Liam', 'Chen', 'liam.chen@example.com', '2024-02-20'),
('Sofia', 'Rossi', 'sofia.rossi@example.com', '2024-03-05'),
('Noah', 'Patel', 'noah.patel@example.com', '2024-04-10'),
('Emma', 'Garcia', 'emma.garcia@example.com', '2024-05-22');

-- Borrowings (mix of returned, active, and overdue)
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date, return_date) VALUES
(1, 1, '2025-01-05', '2025-01-19', '2025-01-18'),
(1, 2, '2025-06-01', '2025-06-15', NULL),              -- currently borrowed
(3, 3, '2025-05-10', '2025-05-24', '2025-05-20'),
(3, 4, '2025-06-10', '2025-06-24', NULL),               -- currently borrowed
(5, 1, '2025-05-01', '2025-05-15', NULL),               -- overdue (past due_date, not returned)
(6, 2, '2025-04-20', '2025-05-04', '2025-05-02'),
(6, 5, '2025-06-05', '2025-06-19', NULL),               -- currently borrowed
(7, 3, '2025-03-01', '2025-03-15', '2025-03-14'),
(8, 4, '2025-02-14', '2025-02-28', '2025-03-01'),
(8, 5, '2025-05-25', '2025-06-08', NULL);               -- overdue
