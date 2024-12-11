CREATE DATABASE lab10;

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR,
    author VARCHAR,
    price DECIMAL,
    quantity INTEGER
);
--submitted by e1kan
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    FOREIGN KEY (book_id) REFERENCES books (book_id)
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR,
    email VARCHAR
);

INSERT INTO books VALUES (1,'Database 101', 'A. Smith', 40.00, 10),
                        (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
                        (3, 'Advanced DB', 'C. Lee', 50.00, 5);
INSERT INTO customers VALUES (101, 'John Doe', 'johndoe@example.com'),
                            (102, 'Jane Doe', 'janedoe@example.com');

-- 1. Transaction for placing an order:
BEGIN;
    INSERT INTO orders VALUES (1, 1, 101, CURRENT_DATE, 2);
    UPDATE books SET quantity = quantity - 2 WHERE book_id = 1;
COMMIT;
--submitted by e1kan
ROLLBACK;
-- 2. Transaction with rollback:
BEGIN;
DO
$$
    BEGIN
        IF (SELECT quantity FROM books WHERE book_id = 3) < 10 THEN
            RAISE NOTICE 'Not enough books available!';
            RAiSE EXCEPTION 'TERMINATING TRANSACTION.';
        ELSE
            INSERT INTO orders VALUES (2, 3, 102, CURRENT_DATE, 10);
        END IF;
    END
$$;
COMMIT;
ROLLBACK;

-- 3. Isolation level demonstration:
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED; -- 1st session
    UPDATE books SET price = 45.0 WHERE book_id = 1;
COMMIT;
--submitted by e1kan
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED; -- 2nd session
      SELECT price FROM books WHERE book_id = 1;
COMMIT;

-- 4. Durability check:
BEGIN;
    UPDATE customers SET email = 'janelovesgaming@gmail.com' WHERE customer_id = 102;
COMMIT;

SELECT email FROM customers WHERE customer_id = 102;
--submitted by e1kan