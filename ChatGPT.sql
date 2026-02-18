-- 1. Create the Users table if it doesn't exist
CREATE TABLE IF NOT EXISTS Users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);

-- 2. List of names to insert
-- You can modify this list
WITH names_to_insert(name) AS (
  VALUES
  	('Alice'),
  	('Bob'),
  	('Charlie'),
  	('Diana'),
  	('Eve')
)

-- 3. Insert names that are not already in the Users table
INSERT OR IGNORE INTO Users (name)
SELECT name
FROM names_to_insert;

-- 4. Optional: Check the contents of the Users table
SELECT * FROM Users;
