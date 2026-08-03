-- ============================================================
-- Library Management System — Database Schema
-- Compatible with SQLite (also easily portable to MySQL/Postgres)
-- ============================================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS authors;

-- Authors table
CREATE TABLE authors (
    author_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    birth_year    INTEGER,
    country       TEXT
);

-- Books table
CREATE TABLE books (
    book_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    title             TEXT NOT NULL,
    author_id         INTEGER NOT NULL,
    genre             TEXT,
    published_year    INTEGER,
    copies_total      INTEGER NOT NULL DEFAULT 1,
    copies_available  INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
        ON DELETE CASCADE
);

-- Members table
CREATE TABLE members (
    member_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    email         TEXT UNIQUE NOT NULL,
    join_date     DATE NOT NULL DEFAULT (date('now'))
);

-- Borrowings table (junction / transaction table)
CREATE TABLE borrowings (
    borrowing_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id       INTEGER NOT NULL,
    member_id     INTEGER NOT NULL,
    borrow_date   DATE NOT NULL,
    due_date      DATE NOT NULL,
    return_date   DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
        ON DELETE CASCADE
);

-- Helpful indexes for common lookups
CREATE INDEX idx_books_author ON books(author_id);
CREATE INDEX idx_borrowings_book ON borrowings(book_id);
CREATE INDEX idx_borrowings_member ON borrowings(member_id);
CREATE INDEX idx_borrowings_return_date ON borrowings(return_date);
