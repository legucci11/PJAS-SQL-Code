/* Standard SQL Bulk 'Upsert' Pattern 
   1. Define the source data (the list of names)
   2. Filter out names that already exist in the 'Users' table
   3. Insert only the new records
*/

INSERT INTO Users (name)
SELECT DISTINCT new_names.name
FROM (
    -- This subquery represents your list of input names
    SELECT 'Alice' AS name UNION ALL
    SELECT 'Bob' AS name UNION ALL
    SELECT 'Charlie' AS name UNION ALL
    SELECT 'Alice' AS name -- Duplicate in the input list
) AS new_names
WHERE NOT EXISTS (
    SELECT 1 
    FROM Users 
    WHERE Users.name = new_names.name
);
