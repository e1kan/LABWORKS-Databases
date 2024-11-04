-- 1) Create database 'lab6'
CREATE DATABASE lab6;

-- 2) Create tables 'locations', 'departments'  and 'employees'
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);
--submitted by e1kan
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
     email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
--submitted by e1kan
INSERT INTO locations(city, state_province) VALUES('Teufort', 'Badlands'),
                                                  ('Normal', 'Normlands'),
                                                  ('Hereford', '???'),
                                                  ('Raccoon City', 'Midwest'),
                                                  ('Harran', '???'),
                                                  ('Silent Hill', 'EVERYWHERE');

INSERT INTO departments(department_name, department_id, location_id) VALUES('Team Fortress 2', 4, 1),
                                                              ('Regulars', 3, 2),
                                                              ('Task Force 141', 9, 3),
                                                              ('Resident Evil', 80, 4),
                                                              ('Dying Light', 40, 5),
                                                              ('Silent Hill', 711, 6);

INSERT INTO employees(first_name, last_name, department_id) VALUES ('John', 'Doe', null),
                                                                   ('Pyro', '???', 4),
                                                                   ('Soap', 'MacTavish', 9),
                                                                   ('Engie', '???', 4),
                                                                   ('Scout', '???', 4),
                                                                   ('Roach', 'Sanderson', 9),
                                                                   ('Leon', 'Kennedy', 80),
                                                                   ('Kyle', 'Crane', 40),
                                                                   ('Claire', 'Redfield', 80),
                                                                   ('Jane', 'Doe', null);

-- 3) Select the first name, last name, department id, and department name
SELECT e.first_name, e.last_name, e.department_id, d.department_name FROM employees e
JOIN departments d on e.department_id = d.department_id;

-- 4) Select the first name, last name, department id and department name where departments = 80 or 40
SELECT e.first_name, e.last_name, d.department_id, d.department_name FROM employees e
JOIN departments d on e.department_id = d.department_id WHERE d.department_id IN (80, 40);
--submitted by e1kan
-- 5) Select the first and last name, department, city, and state province for each employee
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province FROM employees e
LEFT JOIN departments d on d.department_id = e.department_id
LEFT JOIN locations l on d.location_id = l.location_id;

-- 6) Select all departments including those without employees
SELECT DISTINCT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;
-- ooooooor if we need just departments info we can use SELF JOIN
SELECT d1.department_name, d2.department_id  FROM departments d1
JOIN departments d2 ON d1.department_id = d2.department_id;
--submitted by e1kan
-- 7) Select the first name, last name, department id and name, for all employees who have or have not any department
SELECT e.first_name, e.last_name, d.department_name, d.department_id FROM employees e
LEFT JOIN departments d on e.department_id = d.department_id;





/* lists departments with employee count
 SELECT DISTINCT d.department_id, d.department_name, count(e.employee_id)
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_id, d.department_name;
 */