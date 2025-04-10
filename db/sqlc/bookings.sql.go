// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.28.0
// source: bookings.sql

package medical

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const bookingsOfDoc = `-- name: BookingsOfDoc :many
SELECT id, user_id, doc_id, booked_at, slot FROM bookings
WHERE doc_id = $1
ORDER BY user_id ASC
LIMIT $2
OFFSET $3
`

type BookingsOfDocParams struct {
	DocID  int64 `json:"doc_id"`
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) BookingsOfDoc(ctx context.Context, arg BookingsOfDocParams) ([]Bookings, error) {
	rows, err := q.db.Query(ctx, bookingsOfDoc, arg.DocID, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Bookings
	for rows.Next() {
		var i Bookings
		if err := rows.Scan(
			&i.ID,
			&i.UserID,
			&i.DocID,
			&i.BookedAt,
			&i.Slot,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const bookingsOfUser = `-- name: BookingsOfUser :many
SELECT id, user_id, doc_id, booked_at, slot FROM bookings
WHERE user_id = $1
ORDER BY doc_id ASC
LIMIT $2
OFFSET $3
`

type BookingsOfUserParams struct {
	UserID int64 `json:"user_id"`
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) BookingsOfUser(ctx context.Context, arg BookingsOfUserParams) ([]Bookings, error) {
	rows, err := q.db.Query(ctx, bookingsOfUser, arg.UserID, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Bookings
	for rows.Next() {
		var i Bookings
		if err := rows.Scan(
			&i.ID,
			&i.UserID,
			&i.DocID,
			&i.BookedAt,
			&i.Slot,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const createBooking = `-- name: CreateBooking :one
INSERT INTO bookings (
  user_id, doc_id, slot
) VALUES (
  $1, $2, $3
) RETURNING id, user_id, doc_id, booked_at, slot
`

type CreateBookingParams struct {
	UserID int64              `json:"user_id"`
	DocID  int64              `json:"doc_id"`
	Slot   pgtype.Timestamptz `json:"slot"`
}

func (q *Queries) CreateBooking(ctx context.Context, arg CreateBookingParams) (Bookings, error) {
	row := q.db.QueryRow(ctx, createBooking, arg.UserID, arg.DocID, arg.Slot)
	var i Bookings
	err := row.Scan(
		&i.ID,
		&i.UserID,
		&i.DocID,
		&i.BookedAt,
		&i.Slot,
	)
	return i, err
}

const dropBooking = `-- name: DropBooking :exec
DELETE FROM users
WHERE id = $1
`

func (q *Queries) DropBooking(ctx context.Context, id int64) error {
	_, err := q.db.Exec(ctx, dropBooking, id)
	return err
}

const getBooking = `-- name: GetBooking :one
SELECT id, user_id, doc_id, booked_at, slot FROM bookings
WHERE id = $1 LIMIT 1
`

func (q *Queries) GetBooking(ctx context.Context, id int64) (Bookings, error) {
	row := q.db.QueryRow(ctx, getBooking, id)
	var i Bookings
	err := row.Scan(
		&i.ID,
		&i.UserID,
		&i.DocID,
		&i.BookedAt,
		&i.Slot,
	)
	return i, err
}

const updateBooking = `-- name: UpdateBooking :exec
UPDATE bookings 
SET
 doc_id = COALESCE(NULLIF($1, ''), doc_id),
 slot = COALESCE($2, slot)
WHERE id = $3
`

type UpdateBookingParams struct {
	DocID interface{}        `json:"doc_id"`
	Slot  pgtype.Timestamptz `json:"slot"`
	ID    int64              `json:"id"`
}

func (q *Queries) UpdateBooking(ctx context.Context, arg UpdateBookingParams) error {
	_, err := q.db.Exec(ctx, updateBooking, arg.DocID, arg.Slot, arg.ID)
	return err
}
