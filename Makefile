postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb -U root --owner=root medical

dropdb:
	docker exec -it postgres12 dropdb medical

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/medical?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/medical?sslmode=disable" -verbose down

.PHONY:postgres dropdb createdb	migratedown migrateup