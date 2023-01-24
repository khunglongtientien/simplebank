package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDb *sql.DB

const (
	dbDrive  = "postgres"
	dbSource = "postgresql://postgres:MyPassword1!@localhost:5432/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M) {
	var err error
	testDb, err = sql.Open(dbDrive, dbSource)
	if err != nil {
		log.Fatal("cannot connect to database: ", err)
	}

	testQueries = New(testDb)

	os.Exit(m.Run())
}
