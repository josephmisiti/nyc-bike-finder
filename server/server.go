package main

import(
    "encoding/json"
    "flag"
    "fmt"
    "net/http"
    "io"
    "io/ioutil"
    "os"
    "runtime"
)

const (
    VERSION = 1
    CITI_BIKE_JSON = "https://www.citibikenyc.com/stations/json"
)

type Stations struct {
    stationBeanList []Station
}

type Station struct {
    id uint64 `json:"id"`
    // stationName: "W 52 St & 11 Ave",
    // availableDocks: 33,
    // totalDocks: 39,
    // latitude: 40.76727216,
    // longitude: -73.99392888,
    // statusValue: "In Service",
    // statusKey: 1,
    // availableBikes: 4,
    // stAddress1: "W 52 St & 11 Ave",
    // stAddress2: "",
    // city: "",
    // postalCode: "",
    // location: "",
    // altitude: "",
    // testStation: false,
    // lastCommunicationTime: "2015-11-02 02:30:22 PM",
    // landMark: ""
}


var (
    port   = flag.String("port", ":8125", "UDP service address")
    runCron = flag.Bool("runCron", false, "run the cron job to pull the statistics")
    showVersion = flag.Bool("version", false, "print version string")
)

type Record struct {
	Author Author `json:"author"`
	Title  string `json:"title"`
	URL    string `json:"url"`
}

type Author struct {
	ID    uint64 `json:"id"`
	Email string `json:"email"`
}

type author Author

func (a *Author) UnmarshalJSON(b []byte) (err error) {
	j, s, n := author{}, "", uint64(0)
	if err = json.Unmarshal(b, &j); err == nil {
		*a = Author(j)
		return
	}
	if err = json.Unmarshal(b, &s); err == nil {
		a.Email = s
		return
	}
	if err = json.Unmarshal(b, &n); err == nil {
		a.ID = n
	}
	return
}

func Decode(r io.Reader) (x *Record, err error) {
	x = new(Record)
	err = json.NewDecoder(r).Decode(x)
	return
}


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
    
    var data map[string]string
    json.Unmarshal(body, &data)
    fmt.Printf("Results: %v\n", data["stationBeanList"])     
    os.Exit(0)
}

func test() {
	var r []Record
    body := `[{
    	  "author": "attila@attilaolah.eu",
    	  "title":  "My Blog",
    	  "url":    "http://attilaolah.eu"
    	}, {
    	  "author": 1234567890,
    	  "title":  "Westartup",
    	  "url":    "http://www.westartup.eu"
    	}, {
    	  "author": {
    	    "id":    1234567890,
    	    "email": "nospam@westartup.eu"
    	  },
    	  "title":  "Westartup",
    	  "url":    "http://www.westartup.eu"
    	}]`
    err := json.Unmarshal([]byte(body), &r)
    if(err != nil){
        fmt.Println("ERROR:", err) 
    }
	fmt.Println("RECORDS:", r) 
}

func test1() {
	var s []Stations
    body := `{
        "executionTime": "2015-11-02 02:30:30 PM",
        "stationBeanList": [
            {
            "id": 72
            }
        ]
        }`
    err := json.Unmarshal([]byte(body), &s)
    if(err != nil){
        fmt.Println("ERROR:", err) 
    }
	fmt.Println(s) 
}


func main() {
    flag.Parse()
    if(*showVersion) {
        fmt.Printf("server v%s (built w/%s)\n", VERSION, runtime.Version())
        return
    } 
    
     if(*runCron) {
         runCronJob()
     }
}