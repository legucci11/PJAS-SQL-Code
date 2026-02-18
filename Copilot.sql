-- Bulk insert a list of names into Users only if they don't already exist.
-- No explicit transaction statements. Replace the VALUES(...) list with your input names.

-- Create Users table if it doesn't exist (SQLite-compatible identity and case-insensitive name)
CREATE TABLE IF NOT EXISTS Users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE COLLATE NOCASE
);

WITH
  -- Replace the VALUES below with the list of names you want to insert
  new_names(name) AS (
    VALUES
      ('Alice'),
      ('Bob'),
      ('Charlie'),
      ('alice')  -- example duplicate (case-insensitive)
  ),
  -- Normalize and deduplicate the incoming list
  distinct_names AS (
    SELECT DISTINCT TRIM(name) AS name
    FROM new_names
    WHERE name IS NOT NULL AND TRIM(name) <> ''
  )
INSERT INTO Users (name)
SELECT dn.name
FROM distinct_names dn
WHERE NOT EXISTS (
  SELECT 1
  FROM Users u
  WHERE u.name = dn.name
);

SELECT * FROM Users
