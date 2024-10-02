CREATE DATABASE lab1;

CREATE TABLE users (
    id SERIAL, -- or id SERIAL PRIMARY KEY;
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users ADD COLUMN isadmin INTEGER;

ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::BOOLEAN;

ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT false;
-- or ALTER  TABLE users ADD PRIMARY KEY (id)
ALTER TABLE users ADD CONSTRAINT users_pkey PRIMARY KEY (id); -- or simply ALTER TABLE users ADD PRIMARY KEY (id)

CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);

DROP TABLE tasks;
DROP DATABASE lab1;
