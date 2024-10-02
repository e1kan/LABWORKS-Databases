-- 1) Create database named "lab1"
CREATE DATABASE lab1;
-- submitted by e1kan
-- 2) Create table "users"
CREATE TABLE users (
    id SERIAL, -- or id SERIAL PRIMARY KEY;
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

-- 3) Add integer column "isadmin"
ALTER TABLE users ADD COLUMN isadmin INTEGER;

-- 4) Change type "isadmin" to boolean
ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::BOOLEAN;

-- 5) Set default value as false to "isadmin" column
ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT false;

-- 6) Add primary key constraint to ID column
ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (id);
-- or simply ALTER TABLE users ADD PRIMARY KEY (id) or ALTER  TABLE users ADD PRIMARY KEY (id)

-- 7) Create table "tasks"
CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);

-- 8) Delete "tasks" table
DROP TABLE tasks;
-- submitted by e1kans
-- 9) Delete "lab1" database
DROP DATABASE lab1;
