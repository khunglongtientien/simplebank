postgres:
	docker run --name postgres15.1 --network bank-network -p 5432:5432 -e POSTGRES_USER:postgres -e POSTGRES_PASSWORD=MyPassword1! -d postgres:15.1-alpine

createdb:
	docker exec -it postgres15.1 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres15.1 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1!@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1!@localhost:5432/simple_bank?sslmode=disable" -verbose down

migrateup1:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1!@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown1:
	migrate -path db/migration -database "postgresql://postgres:MyPassword1!@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock migrateup1 migratedown1