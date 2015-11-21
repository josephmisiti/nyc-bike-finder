package main

import (
    "fmt"
    "time"
    "database/sql"

    "github.com/lib/pq"
)

// go build -o bin/db_writer.exe db_writer.go 


/*func main() {
    db, err := sql.Open("postgres", "user=postgres password=sa host=localhost port=5433 dbname=nyc-bike-finder sslmode=disable")
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
}*/

func writeStationHistories(stations []Station) {
    db, err := sql.Open("postgres", "user=postgres password=sa host=localhost port=5433 dbname=nyc-bike-finder sslmode=disable")
    checkErr(err)
    // citibike.cvgkx0imxti5.us-east-1.rds.amazonaws.com:5432
    for _,station := range stations {
        writeStationHistory(db, station)
    }
}



func writeStationHistory(db *sql.DB, s Station) {
    fmt.Printf("-----# Processing station %d %s\n", s.Id, s.StationName)
    // var location = fmt.Sprintf("%f,%f", s.Latitude, s.Longitude)
    var now = fmt.Sprintf(time.Now().Format(time.RFC3339))

    var location = fmt.Sprintf("SRID=4267;POINT(%f %f)", s.Longitude, s.Latitude)
    // fmt.Println(location)

    err := db.QueryRow("INSERT INTO stations(id,station_name,location,status_value,status_key,available_bikes,"+
        "available_docks,total_docks,last_communication_time,st_address1,st_address2,city,postal_code,location_text,altitude,test_station,land_mark,"+
        "created_at,updated_at) VALUES ($1,$2,ST_GeogFromText($3),$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19)", 
        s.Id, s.StationName, location, s.StatusValue, s.StatusKey, s.AvailableBikes, s.AvailableDocks, s.TotalDocks, 
        s.LastCommunicationTime, 
        s.StAddress1, s.StAddress2, s.City, s.PostalCode, s.Location, s.Altitude, s.TestStation, s.LandMark,
        now, now).Scan()
    if err, ok := err.(*pq.Error); ok {
        if err.Code == "12404" {
            // unique_violation, so update instead.
            fmt.Println("Station was already there1.")
        } else if err.Code == "23505" {
            // unique_violation, so update instead.
            fmt.Println("Station was already there2.")

        } else {
            fmt.Println("pq error:", err.Code.Name())
            fmt.Println("pq error:", err.Code)
            fmt.Println("pq error:", err)
            panic(err)
        }
    } else {
        fmt.Printf("-----# Inserted station %d %s\n", s.Id, s.StationName)
    }

    err = db.QueryRow("INSERT INTO station_histories(station_id,available_docks,total_docks,status_value,status_key,available_bikes,"+
        "last_communication_time,created_at) VALUES ($1,$2,$3,$4,$5,$6,$7,$8)", 
        s.Id, s.AvailableDocks, s.TotalDocks, s.StatusValue, s.StatusKey, s.AvailableBikes, s.LastCommunicationTime, 
        now).Scan()

    if err, ok := err.(*pq.Error); ok {
        if err.Code == "23505" {
            // unique_violation, so update instead.
            fmt.Println("History was already there. Skipping...")
        } else {
            fmt.Println("pq error:", err.Code.Name())
            fmt.Println("pq error:", err.Code)
            fmt.Println("pq error:", err)
            panic(err)
        }
    } else {
        fmt.Printf("-----# Inserted station history %d %s\n", s.Id, s.StationName)
    }

}


func checkErr(err error) {
    if err != nil {
        panic(err)
    }
}