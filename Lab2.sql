CREATE DATABASE lab2;
--submitted by e1kan
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER,
    population INTEGER
);

--3 insert a row of data
INSERT INTO countries
VALUES (1, 'USA', 27, 4237256);

--4 insert columns country_id, country_name
INSERT INTO countries (country_id, country_name)
VALUES (51, 'AREA 51');

--5 insert null to region_id column
INSERT INTO countries
VALUES (666, 'Hell', null, 6666666);

--6 insert 3 rows by a single statement
INSERT INTO countries
VALUES (2, 'CANADA', 57, 353000),
       (3, 'AUSTRIA', 55, 753091),
       (4, 'NETHERLANDS', 78, 12301);

--7 set default value 'kazakhstan' to country_name
ALTER TABLE countries ALTER COLUMN country_name
SET DEFAULT 'Kazakhstan';

--8 insert default value to country_name for a row of countries
INSERT INTO countries (country_id, region_id, population)
VALUES (7, 99, 500000);

--9 insert only default values
INSERT INTO countries DEFAULT VALUES;

--10 create duplicate of the table named countries_new
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

--11 insert all rows from countries to countries_new
INSERT INTO countries_new
SELECT * FROM countries;

--12 change region_id to 1 if it's NULL
UPDATE countries
SET region_id = 1 WHERE region_id IS NULL;

--13 increase population by 10%
UPDATE countries
SET population = population * 1.10 WHERE population IS NOT NULL;
--submitted by e1kan
--14 remove all rows with <100k population
DELETE FROM countries
WHERE population < 100000;