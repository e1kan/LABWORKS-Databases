-- 1) Create database 'lab7'
CREATE DATABASE lab7;

-- 2) Create tables 'locations', 'departments'  and 'employees'
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    budget REAL
);
--submitted by e1kan
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary REAL,
    country_id INTEGER REFERENCES countries (country_id),
    department_id INTEGER REFERENCES departments (department_id)
);
--submitted by e1kan
INSERT INTO countries(country_id, country_name) VALUES(1, 'Teufort'),
                                                  (2, 'Hereford'),
                                                  (3, 'Raccoon City'),
                                                  (4, 'Harran'),
                                                  (5, 'Silent Hill');

INSERT INTO employees(first_name, last_name, country_id, salary, department_id) VALUES ('Pyro', '???', 1, 667.1666, 2),
                                                                   ('Soap', 'MacTavish', 2, 9999.9, 1),
                                                                   ('Engie', '???', 1, 100000.0, 2),
                                                                   ('Scout', '???', 1, 0.01, 2),
                                                                   ('Roach', 'Sanderson', 2, 7999.9, 1),
                                                                   ('Chris', 'Redfield', 3, 55551.8871, 3), --submitted by e1kan
                                                                   ('Kyle', 'Crane', 4, 1000.1, 5),
                                                                   ('Jill', 'Valentine', 3, 45005.51, 3),
                                                                   ('Ghost', 'Riley', 2, 9999.9, 1);

INSERT INTO departments VALUES (1, 'Task Force 141', 10000000000000.0),
                               (2, 'Team Fortress 2', 999999999999999.999),
                               (3, 'S.T.A.R.S.', 10000000000000.0),
                               (4, 'Ordinary', 120000.0),
                               (5, 'People of Harran', 0.0); --submitted by e1kan

-- 3) 1. Create index for queries like below:
-- SELECT * FROM countries WHERE name = ‘string’;
CREATE INDEX country_name_index ON countries (country_name);
--submitted by e1kan

-- 4) 2. Create index for queries like below:
-- SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
CREATE INDEX employees_name_surname_index ON employees (first_name, last_name);


-- 5) 3. Create unique index for queries like below:
-- SELECT * FROM employees WHERE salary < value AND salary > value2;
CREATE UNIQUE INDEX employees_salary_index ON employees (salary);

/* filtered index example:
CREATE INDEX employees_salary_index ON employees (salary) WHERE salary BETWEEN 500 AND 100000;
 */


-- 6) 4. Create index for queries like below:
-- SELECT * FROM employees WHERE substring(name from 1 for 4) = ‘abcd’;
CREATE INDEX employees_substring_name_index ON employees(SUBSTRING(first_name FROM 1 FOR 4));


-- 7) 5. Create index for queries like below:
-- SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary < value2;
------------- 1st: composite index with partial filtering (if we have certain values):
CREATE INDEX department_budget_index
ON departments (department_id, budget) WHERE budget > 1000;
CREATE INDEX employee_department_salary_index
ON employees (department_id, salary) WHERE salary < 15000;

EXPLAIN ANALYZE
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.budget > 1000 AND e.salary < 15000;
--submitted by e1kan
DROP INDEX department_budget_index;
DROP INDEX employee_department_salary_index;
------------- 2nd: composite index without partial filtering:
CREATE INDEX department_budget_index
ON departments (department_id, budget);
CREATE INDEX employee_department_salary_index
ON employees (department_id, salary);

EXPLAIN ANALYZE
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.budget > 1000 AND e.salary < 15000;
--submitted by e1kan
DROP INDEX department_budget_index;
DROP INDEX employee_department_salary_index;
