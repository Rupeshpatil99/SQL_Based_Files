# 📚 Library Management System — SQL Project

A beginner-friendly SQL project that models a small library: books, authors,
members, and borrowing records. Built to practice schema design, foreign
keys, and real-world query patterns (joins, aggregates, subqueries).

## Entity-Relationship Diagram

```mermaid
erDiagram
    AUTHORS ||--o{ BOOKS : writes
    BOOKS ||--o{ BORROWINGS : "is borrowed in"
    MEMBERS ||--o{ BORROWINGS : makes

    AUTHORS {
        int author_id PK
        string first_name
        string last_name
        int birth_year
        string country
    }
    BOOKS {
        int book_id PK
        string title
        int author_id FK
        string genre
        int published_year
        int copies_total
        int copies_available
    }
    MEMBERS {
        int member_id PK
        string first_name
        string last_name
        string email
        date join_date
    }
    BORROWINGS {
        int borrowing_id PK
        int book_id FK
        int member_id FK
        date borrow_date
        date due_date
        date return_date
    }
```

## Project Structure

```
library-management-sql/
├── schema.sql       # CREATE TABLE statements, keys, indexes
├── seed_data.sql    # Sample data (5 authors, 8 books, 5 members, 10 borrowings)
├── queries.sql       # 10 practice queries (joins, aggregates, subqueries)
├── README.md
└── .gitignore
```

## Tech Stack

- **SQLite** — zero-setup, single-file database, perfect for learning
  (the SQL is standard enough to adapt to MySQL/PostgreSQL with minor tweaks)

## What This Project Demonstrates

- **Schema design** — primary keys, foreign keys, `ON DELETE CASCADE`,
  sensible data types and constraints
- **Normalization** — a junction table (`borrowings`) to model the
  many-to-many relationship between books and members
- **Indexing** — indexes on foreign key columns for faster joins
- **Querying** — `INNER JOIN` / `LEFT JOIN`, `GROUP BY` with aggregates,
  subqueries (`NOT IN`), date arithmetic, and `HAVING`

See [`queries.sql`](./queries.sql) for the full list, including:
- Currently borrowed & overdue books
- Most active members
- Most popular genres
- Books that have never been borrowed
- Average borrowing duration


