-- 1) Create database named "lab2"
CREATE DATABASE lab4;
--submitted by e1kan
-- 2-3) Create two tables
CREATE TABLE Warehouses (
    code INT PRIMARY KEY NOT NULL,
    location VARCHAR(255),
    capacity INT
);

CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INT,
    FOREIGN KEY (warehouse) REFERENCES Warehouses(code)
);

INSERT INTO Warehouses VALUES(1, 'Chicago', 3),
                             (2, 'Chicago', 4),
                             (3, 'New York', 7),
                             (4, 'Los Angeles', 2),
                             (5, 'San Francisco', 8);

INSERT INTO Boxes VALUES('OMN7', 'Rocks', 180, 3),
                        ('4H8P', 'Rocks', 250, 1),
                        ('4RT3', 'Scissors', 190, 4),
                        ('7G3H', 'Rocks', 200, 1),
                        ('8JN6', 'Papers', 75, 1),
                        ('8Y6U', 'Papers', 50, 3),
                        ('9J6F', 'Papers', 175, 2),
                        ('LL08', 'Rocks', 140, 4),
                        ('P0H6', 'Scissors', 125, 1),
                        ('P2T6', 'Scissors', 150, 2),
                        ('TU55', 'Papers', 90, 5);

-- 4) Select all warehouses with all columns
SELECT * FROM Warehouses;

-- 5) Select all boxes with a value larger than $150
SELECT * FROM Boxes WHERE value > 150;
--submitted by e1kan
-- 6) Select all the boxes distinct by contents
SELECT DISTINCT ON (contents) * FROM boxes;

-- 7) Select the warehouse code and the number of the boxes in each warehouse
SELECT  warehouse, count(*) AS boxes_count FROM boxes GROUP BY warehouse;

-- 8) Select only those warehouses where the number of the boxes is greater than 2
SELECT warehouse, count(*) AS boxes_count FROM boxes GROUP BY warehouse HAVING count(*) > 2;

-- 9) Create a new warehouse in New York with a capacity for 3 boxes
INSERT INTO Warehouses VALUES(6, 'New York', 3);

-- 10) Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2
INSERT INTO Boxes VALUES('H5RT', 'Papers', 200, 2);

-- 11) Reduce the value of the 3rd largest box by 15%
UPDATE Boxes SET value = value * 0.85 WHERE code = (SELECT code FROM Boxes ORDER BY value DESC LIMIT 1 OFFSET 2);
--submitted by e1kan
-- 12) Remove all boxes with a value lower than $150
DELETE FROM Boxes WHERE value < 150;

-- 13) Remove all boxes which is located in New York, statement should return all deleted data
DELETE FROM Boxes WHERE warehouse IN (SELECT code FROM Warehouses WHERE location = 'New York') RETURNING *;