postgres:
	docker run --name postgres15.1 -p 5432:5432 -e POSTGRES_USER:postgres -e POSTGRES_PASSWORD=MyPassword1! -d postgres:15.1-alpine

createdb:
	docker exec -it postgres15.1 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres15.1 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1\!@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1\!@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test