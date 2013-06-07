(in-package :clsql-orm)
(cl-interpol:enable-interpol-syntax)
(clsql-sys:file-enable-sql-reader-syntax)

(defun mysql-sql (where order) #?"
SELECT 
cols.table_schema,
cols.table_name,
cols.column_name, cols.data_type,
COALESCE(cols.character_maximum_length,
cols.numeric_precision),
cols.numeric_scale,
cols.is_nullable,
cols.column_default,
cons.constraint_type,
fkey.referenced_table_schema,
fkey.referenced_table_name,
fkey.referenced_column_name
FROM information_schema.columns AS cols
LEFT JOIN information_schema.key_column_usage AS fkey
ON fkey.column_name = cols.column_name
AND fkey.table_name = cols.table_name
AND fkey.table_schema = cols.table_schema
LEFT JOIN information_schema.table_constraints AS cons
ON cons.constraint_name = fkey.constraint_name
AND cons.constraint_schema = fkey.constraint_schema
AND cons.table_name = fkey.table_name
AND cons.table_schema = fkey.table_schema

WHERE ${where}

ORDER BY ${order}
")
