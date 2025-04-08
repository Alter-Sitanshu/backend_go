
-- name: CreateDoc :one
INSERT INTO doctors (
  first_name, last_name, dept, contact, experience, fee, email
) VALUES (
  $1, $2, $3, $4, $5, $6, $7
) RETURNING *;

-- name: GetDocByName :many
SELECT * FROM doctors
WHERE first_name LIKE $1
ORDER BY id;

-- name: GetDocByDept :many
SELECT * FROM doctors
WHERE dept = $1;

-- name: UpdateDoc :exec
UPDATE doctors
SET
  first_name = COALESCE(NULLIF(@first_name, ''), first_name),
  last_name = COALESCE(NULLIF(@last_name, ''), last_name),
  dept = COALESCE(NULLIF(@dept, ''), dept),
  contact = COALESCE(NULLIF(@contact, ''), contact)
WHERE id = @id;

-- name: DropDoc :exec
DELETE FROM doctors
WHERE id = $1;