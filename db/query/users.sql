-- name: CreateUser :one
INSERT INTO users (
  first_name, last_name, contact
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetUsers :many
SELECT * FROM users
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: GetUser :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: UpdateUser :exec
UPDATE users SET contact = $2
WHERE id = $1
RETURNING *;

-- name: DropUser :exec
DELETE FROM users
WHERE id = $1;
