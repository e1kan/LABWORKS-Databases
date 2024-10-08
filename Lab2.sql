-- 1) Create database named "lab2"
CREATE DATABASE lab2;
--submitted by e1kan
-- 2) Create table "countries"
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER,
    population INTEGER
);

-- 3) Insert a row of data
INSERT INTO countries
VALUES (778, 'USA', 27, 4237256);

-- 4) Insert columns country_id, country_name
INSERT INTO countries (country_id, country_name)
VALUES (51, 'AREA 51');

-- 5) Insert null to region_id column
INSERT INTO countries
VALUES (666, 'Hell', null, 6666666);

-- 6) Insert 3 rows by a single statement
INSERT INTO countries
VALUES (99, 'CANADA', 57, 353000),
       (3, 'AUSTRIA', 55, 753091),
       (4, 'NETHERLANDS', 78, 12301);

-- 7) Set default value 'kazakhstan' to country_name
ALTER TABLE countries ALTER COLUMN country_name
SET DEFAULT 'Kazakhstan';

-- 8) Insert default value to country_name for a row of countries
INSERT INTO countries (country_id, region_id, population)
VALUES (7, 99, 500000);

-- 9) Insert only default values
INSERT INTO countries DEFAULT VALUES;

-- 10) Create duplicate of the table named countries_new
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

-- 11) Insert all rows from countries to countries_new
INSERT INTO countries_new
SELECT * FROM countries;

-- 12) Change region_id to 1 if it's NULL
UPDATE countries
SET region_id = 1 WHERE region_id IS NULL;

-- 13) Increase population by 10% and return the statement
SELECT
    country_name,
    population * 1.10 AS "New Population"
FROM  countries;
--submitted by e1kan
--14 remove all rows with <100k population
DELETE FROM countries
WHERE population < 100000;

-- 15) Remove all rows (countries_new) if county_id exists AND return deleted data
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;

-- 16) Remove all rows (countries) and return all deleted data
DELETE FROM countries RETURNING *;

DROP DATABASE lab2;