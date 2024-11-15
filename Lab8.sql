-- 1) Create database 'lab8'
CREATE DATABASE lab8;

-- 2) Create tables 'salesman', 'customers', 'orders'
CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission REAL
);
--submitted by e1kan
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INT references salesman (salesman_id)
);

CREATE TABLE orders (
    ord_no SERIAL PRIMARY KEY,
    purch_amt REAL,
    ord_date DATE,
    customer_id INTEGER references customers (customer_id),
    salesman_id INTEGER references salesman (salesman_id)
);
--submitted by e1kan
INSERT INTO salesman VALUES (5001, 'James Hoog', 'New York', 0.15),
                            (5002, 'Nail Knite', 'Paris', 0.13),
                            (5005, 'Pit Alex', 'London', 0.11),
                            (5006, 'Mc Lyon', 'Paris', 0.14),
                            (5003, 'Lauson Hen', null, 0.12),
                            (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers VALUES (3002, 'Nick Rimando', 'New York', 200, 5001),
                             (3005, 'Graham Zusi', 'California', 200, 5002),
                             (3001, 'Brad Guzan', 'London', null, 5005),
                             (3004, 'Fabian Johns', 'Paris', 300, 5006),
                             (3007, 'Brad Davis', 'New York', 200, 5001),
                             (3009, 'Geoff Camero', 'Berlin', 100, 5003),
                             (3008, 'Julian Green', 'London', 300, 5002); --submitted by e1kan

INSERT INTO orders VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
                          (70009, 2700.65, '2012-09-10', 3001, 5005),
                          (70002, 65.26, '2012-10-05', 3002, 5001),
                          (70004, 110.5, '2012-08-17', 3009, 5003), --submitted by e1kan
                          (70007, 948.5, '2012-09-10', 3005, 5002),
                          (70005, 2400.6, '2012-07-21', 3007, 5001),
                          (70008, 5760, '2012-09-10', 3002, 5001);


-- 3) Create role named «junior_dev» with login privilege
CREATE ROLE junior_dev LOGIN;


-- 4) Create a view for those salesmen who belong to the city New York
CREATE VIEW salesmen_from_ny AS
    SELECT salesman_id, name
    FROM salesman
    WHERE city = 'New York';

--submitted by e1kan
-- 5) Create a view that shows for each order the salesman and customer by name. Grant all privileges to «junior_dev»
CREATE VIEW order_by_salesman_customer AS
    SELECT o.ord_no, s.name AS salesman_name, c.cust_name AS customer_name
    FROM orders o--submitted by e1kan
    JOIN salesman s ON o.salesman_id = s.salesman_id
    JOIN customers c ON o.customer_id = c.customer_id;

GRANT ALL PRIVILEGES ON order_by_salesman_customer TO junior_dev;


-- 6) Create a view that shows all of the customers who have the highest grade. Grant only select statements to «junior_dev»
CREATE VIEW customers_with_max_grade AS
    SELECT customer_id, cust_name
    FROM customers
    WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON customers_with_max_grade TO junior_dev;


-- 7) Create a view that shows the number of the salesman in each city
CREATE VIEW salesman_num_by_city AS
    SELECT
        COALESCE(city, 'Not specified') AS city,
        COUNT(salesman_id) AS salesman_num
    FROM salesman
    GROUP BY COALESCE(city, 'Not specified');
--submitted by e1kan

-- 8) Create a view that shows each salesman with more than one customers
CREATE VIEW salesman_with_many_customers AS
    SELECT s.name, count(c.customer_id) FROM salesman s
    JOIN customers c on s.salesman_id = c.salesman_id
    GROUP BY s.name
    HAVING count(c.customer_id) > 1;


-- 9) Create role «intern» and give all privileges of «junior_dev».
CREATE ROLE intern;
GRANT junior_dev TO intern;