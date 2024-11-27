CREATE DATABASE lab9;

-- 1) Increase integer by 10
CREATE FUNCTION increase_value(val integer) RETURNS integer AS
$$
BEGIN
    RETURN val + 10;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM increase_value(8);

-- 2) Compare two integers
CREATE FUNCTION compare_numbers(val1 INTEGER, val2 INTEGER, OUT result VARCHAR)
RETURNS VARCHAR AS
$$
BEGIN
    IF val1 > val2 THEN
        result := 'Greater';
    ELSIF val1 < val2 THEN
        result := 'Lesser';
    ELSE
        result := 'Equal';
    END IF;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM compare_numbers(12, -13);

-- 3) Return a series from 1 to n (use a loop)
CREATE FUNCTION number_series(n integer) RETURNS TABLE
    (
        series int
    )
    AS
$$
DECLARE
    i integer;
BEGIN
    i := 1;
    WHILE i <= n LOOP
            series := i;
            RETURN NEXT;
            i := i + 1;
        END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM number_series(4);

-- 4) Return employee details by performing a query
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary REAL
);

INSERT INTO employees VALUES (2331, 'John', 'Price', 10000.0),
                             (2335, 'John', 'MacTavish', 8990.0),
                             (5981, 'Olivia', 'Johannes', 6000.5),
                             (1589, 'Kate', 'Laswell', 15000.0);

CREATE OR REPLACE FUNCTION find_employee(name VARCHAR(50)) RETURNS TABLE
    (
      id INTEGER,
      first_name VARCHAR(50),
      last_name VARCHAR(50),
      salary REAL
    )
    AS
$$
BEGIN
    RETURN QUERY SELECT employees.id,
                        employees.first_name,
                        employees.last_name,
                        employees.salary
                     FROM employees
                     WHERE employees.first_name = name;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM find_employee('John');

-- 5) Return a table with product details based on a given category
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price REAL
);

INSERT INTO products VALUES (23, 'Coca-Cola', 'Drinks', 450),
                            (112, 'Fanta', 'Drinks', 550),
                            (118, 'Chocopie', 'Pastries', 990);

CREATE OR REPLACE FUNCTION list_products(cat VARCHAR(50)) RETURNS TABLE
    (
        product_id INT,
        product_name VARCHAR(50),
        price REAL
    )
    AS
$$
BEGIN
    RETURN QUERY SELECT products.product_id,
                        products.product_name,
                        products.price
                    FROM products
                    WHERE category = cat;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM list_products('Drinks');

-- 6) Create a procedure that calls for another procedure
---------- 1. calculate_bonus
CREATE FUNCTION calculate_bonus(idd INT) RETURNS real AS
$$
DECLARE
    bonus REAL := 0.10;
    salary REAL;
BEGIN
    SELECT employees.salary
    INTO salary
    FROM employees
    WHERE employees.id = idd;

    IF salary IS NULL THEN
        RAISE EXCEPTION 'Employee % does not have a salary.', idd;
    END IF;

    RETURN salary * bonus;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM calculate_bonus(5981);
---------- 2. update_salary
CREATE FUNCTION update_salary(idd INT) RETURNS real AS
$$
DECLARE
    bonus REAL := calculate_bonus(idd);
    updated_salary REAL;
BEGIN
    UPDATE employees
    SET salary = salary + bonus
    WHERE employees.id = idd
    RETURNING salary INTO updated_salary;

    RETURN updated_salary;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM update_salary(5981);

-- 7) A function with two labeled subblocks

CREATE OR REPLACE FUNCTION complex_calculation(age INTEGER, health_rate REAL, name VARCHAR(50)) RETURNS REAL AS
$$
<<main_block>>
DECLARE
    unique_medical_code INT;
    health_evaluation REAL;
    name_len INT;
BEGIN
    <<first_block>>
    BEGIN
        health_evaluation := health_rate - (age::REAL / 100);
        RAISE NOTICE 'Health evaluation result is %', health_evaluation;
    END first_block;

    <<second_block>>
    BEGIN
        name_len := LENGTH(name);
        RAISE NOTICE 'Converted name % to number based on the length: %', name, name_len;
    END second_block;

    unique_medical_code := (name_len * health_evaluation)::INT;

    RETURN unique_medical_code;
END main_block;
$$
LANGUAGE plpgsql;

SELECT * FROM complex_calculation(31, 10.0, 'Lima');