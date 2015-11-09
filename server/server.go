package main

import(
    "encoding/json"
    "flag"
    "fmt"
    "net/http"
    "io/ioutil"
    "os"
    "runtime"
)

const (
    VERSION = 1
    CITI_BIKE_JSON = "https://www.citibikenyc.com/stations/json"
)


type Station struct {
    Id int64 `json:"id"`
    StationName string `json:"stationName"`
    AvailableDocks int64 `json:"availableDocks"`
    TotalDocks int64 `json:"totalDocks"`
    Latitude float64 `json:"latitude"`
    Longitude float64 `json:"longitude"`
    StatusValue string `json:"statusValue"`
    StatusKey int64 `json:"statusKey"`
    AvailableBikes int64 `json:"availableBikes"`
    StAddress1 string `json:"stAddress1"`
    StAddress2 string `json:"stAddress2"`
    City string `json:"city"`
    PostalCode string `json:"postalCode"`
    Location string `json:"location"`
    Altitude string `json:"altitude"`
    TestStation bool `json:"testStation"`
    LastCommunicationTime string `json:"lastCommunicationTime"`
    LandMark string `json:"landMark"`
}

type Stations struct {
    ExecutionTime string `json:"executionTime"`
    StationBeanList []Station `json:"stationBeanList"`
}

var (
    port   = flag.String("port", ":8125", "UDP service address")
    runCron = flag.Bool("runCron", false, "run the cron job to pull the statistics")
    showVersion = flag.Bool("version", false, "print version string")
)

func runCronJob() {
    fmt.Println("\n--- runCronJob\n")
    
    res, err := http.Get(CITI_BIKE_JSON)
    if err != nil {
        panic(err.Error())
    }

    body, err := ioutil.ReadAll(res.Body)
    if err != nil {
        panic(err.Error())
    }
    
    var s Stations
    err = json.Unmarshal([]byte(body), &s)
    if(err != nil){
        fmt.Println("whoops:", err)
    }
    fmt.Println("-----> ", s.StationBeanList[0])    
    os.Exit(0)
}


func test1() {
    body := `{
        "executionTime": "2015-11-09 11:59:58 AM",
        "stationBeanList": [{"id": 1, "stationName": "x"}]
    }`
    var s Stations
    err := json.Unmarshal([]byte(body), &s)
    if(err != nil){
        fmt.Println("ERROR 1:", err)
    }
    fmt.Println("-----> ", s.StationBeanList)    
}

func main() {
    flag.Parse()
    if(*showVersion) {
        fmt.Printf("server v%s (built w/%s)\n", VERSION, runtime.Version())
        return
    } 
    
     if(*runCron) {
         runCronJob()
         //test1()
     }
}