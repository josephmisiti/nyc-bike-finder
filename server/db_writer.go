package main

import (
    "fmt"
    "database/sql"

    _ "github.com/lib/pq"
)

// go build -o bin/db_writer.exe db_writer.go 


func main() {
    db, err := sql.Open("postgres", "user=postgres password=sa host=localhost port=5432 dbname=nyc-bike-finder sslmode=disable")
    if err != nil {
        panic(err.Error())
    }

	var lastInsertId int
    err = db.QueryRow("INSERT INTO my_test_table(name,age) VALUES($1,$2) returning id;", "scott", 37).Scan(&lastInsertId)
    checkErr(err)
    fmt.Println("last inserted id =", lastInsertId)

    err = db.QueryRow("INSERT INTO my_test_table(name,age) VALUES($1,$2) returning id;", "joe", 21).Scan(&lastInsertId)
    checkErr(err)
    fmt.Println("last inserted id =", lastInsertId)


    age := 21
    rows, err := db.Query("SELECT name FROM my_test_table WHERE age = $1", age)
    if err != nil {
        panic(err.Error())
    }

    // fmt.Printf("rows %d\n", rows)
    for rows.Next() {
        var name string
        err = rows.Scan(&name)
        checkErr(err)
        fmt.Println("name")
        fmt.Printf("%v", name)
    }
}

func checkErr(err error) {
    if err != nil {
        panic(err)
    }
}