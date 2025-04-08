-- name: CreateDept :one
INSERT INTO departments (
  name
) VALUES (
  $1
) RETURNING *;

-- name: GetDept :one
SELECT * FROM departments
WHERE name LIKE $1 LIMIT 1;

-- name: UpdateDept :exec
UPDATE departments
SET name = $2
WHERE id = $1;

-- name: DropDept :exec
DELETE FROM departments
WHERE id = $1;
