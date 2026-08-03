-- ============================================================
-- Practice Queries — Library Management System
-- A set of queries showing common SQL patterns: joins, aggregates,
-- subqueries, filtering, and grouping.
-- ============================================================

-- 1. List all books with their author's full name
SELECT
    b.title,
    a.first_name || ' ' || a.last_name AS author,
    b.genre,
    b.published_year
FROM books b
JOIN authors a ON b.author_id = a.author_id
ORDER BY b.title;

-- 2. Books that are currently out of stock (0 copies available)
SELECT title, copies_total, copies_available
FROM books
WHERE copies_available = 0;

-- 3. All currently borrowed books (not yet returned) with borrower info
SELECT
    bo.borrowing_id,
    bk.title,
    m.first_name || ' ' || m.last_name AS borrower,
    bo.borrow_date,
    bo.due_date
FROM borrowings bo
JOIN books bk ON bo.book_id = bk.book_id
JOIN members m ON bo.member_id = m.member_id
WHERE bo.return_date IS NULL
ORDER BY bo.due_date;

-- 4. Overdue books (not returned and past due date)
SELECT
    bk.title,
    m.first_name || ' ' || m.last_name AS borrower,
    bo.due_date,
    julianday('now') - julianday(bo.due_date) AS days_overdue
FROM borrowings bo
JOIN books bk ON bo.book_id = bk.book_id
JOIN members m ON bo.member_id = m.member_id
WHERE bo.return_date IS NULL
  AND bo.due_date < date('now')
ORDER BY days_overdue DESC;

-- 5. Number of books borrowed per member (most active readers first)
SELECT
    m.first_name || ' ' || m.last_name AS member,
    COUNT(bo.borrowing_id) AS total_borrowed
FROM members m
LEFT JOIN borrowings bo ON m.member_id = bo.member_id
GROUP BY m.member_id
ORDER BY total_borrowed DESC;

-- 6. Most popular genre by number of borrowings
SELECT
    bk.genre,
    COUNT(bo.borrowing_id) AS times_borrowed
FROM borrowings bo
JOIN books bk ON bo.book_id = bk.book_id
GROUP BY bk.genre
ORDER BY times_borrowed DESC;

-- 7. Books that have never been borrowed
SELECT title
FROM books
WHERE book_id NOT IN (SELECT DISTINCT book_id FROM borrowings);

-- 8. Authors with more than one book in the library
SELECT
    a.first_name || ' ' || a.last_name AS author,
    COUNT(b.book_id) AS book_count
FROM authors a
JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_id
HAVING COUNT(b.book_id) > 1;

-- 9. Average borrowing duration (in days) for returned books
SELECT
    ROUND(AVG(julianday(return_date) - julianday(borrow_date)), 1) AS avg_days_borrowed
FROM borrowings
WHERE return_date IS NOT NULL;

-- 10. Members who joined in a given year, with their total borrow count
SELECT
    m.first_name || ' ' || m.last_name AS member,
    m.join_date,
    COUNT(bo.borrowing_id) AS total_borrowed
FROM members m
LEFT JOIN borrowings bo ON m.member_id = bo.member_id
WHERE strftime('%Y', m.join_date) = '2024'
GROUP BY m.member_id
ORDER BY m.join_date;
