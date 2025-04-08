-- name: CreateBooking :one
INSERT INTO bookings (
  user_id, doc_id, slot
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: BookingsOfDoc :many
SELECT * FROM bookings
WHERE doc_id = $1
ORDER BY user_id ASC
LIMIT $2
OFFSET $3;

-- name: BookingsOfUser :many
SELECT * FROM bookings
WHERE user_id = $1
ORDER BY doc_id ASC
LIMIT $2
OFFSET $3;

-- name: GetBooking :one
SELECT * FROM bookings
WHERE id = $1 LIMIT 1;

-- name: UpdateBooking :exec
UPDATE bookings 
SET
 doc_id = COALESCE(NULLIF(@doc_id, ''), doc_id),
 slot = COALESCE(@slot, slot)
WHERE id = @id;

-- name: DropBooking :exec
DELETE FROM users
WHERE id = $1;