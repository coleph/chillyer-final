package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"net/url"
	"strings"
	"time"
)

var Locations = [6]string{"Old Gym", "New Gym", "Pool", "Upper Field", "Lower Field", "Tennis Courts"}

type Event struct {
	Sport    string
	Lat      string
	Long     string
	Time     string
	Notes    string
	Location string
}

var Events [20]Event

// the slice of events generates by the main function- when the client user searches a sport the handler function will search through this slice to find an Event for the sport

func main() {

	sportsList := [20]string{"Boy's Lacrosse", "Girl's Lacrosse", "Boy's Waterpolo", "Girl's Waterpolo", "Football", "Baseball", "Swimming", "Boy's Basketball", "Girl's Basketball", "Boy's Tennis", "Girl's Tennis", "Ultimate Frisbee", "Girl's Soccer", "Boy's Soccer", "Girl's Squash", "Boy's Squash", "Girl's Volleyball", "Boy's Volleyball", "Cross Country", "Track and Field"}

	rand.Seed(time.Now().UnixNano())
	// random seed so the data isn't always the same

	for index := 0; index <= 19; index++ {
		// creating one event for every sport as a test so you can search any sport on the app and get a result
		Events[index].Sport = sportsList[index]
		Events[index].Time = "TBA"
		// trying to chose a random location even though if the app was fully complete you would be able to select locations for events created in the app
		Events[index].Location = Locations[rand.Intn(5)]
		Events[index].Notes = "placeholder"

		if Events[index].Location == "New Gym" {
			Events[index].Lat = "34.40540045"
			Events[index].Long = "-119.47687865"
		}
		if Events[index].Location == "Old Gym" {
			Events[index].Lat = "34.40541902"
			Events[index].Long = "-119.47892551"
		}
		if Events[index].Location == "Pool" {
			Events[index].Lat = "34.40656022"
			Events[index].Long = "-119.47836095"
		}
		if Events[index].Location == "Upper Field" {
			Events[index].Lat = "34.40620172"
			Events[index].Long = "-119.47591854"
		}
		if Events[index].Location == "Lower Field" {
			Events[index].Lat = "34.40649877"
			Events[index].Long = "-119.47729934"
		}
		if Events[index].Location == "Tennis Courts" {
			Events[index].Lat = "34.40659497"
			Events[index].Long = "-119.47889747"
		}
		// assign corresponding Lat and Long values for each location so it can be acurately marked on the map view in the client

	}

	fmt.Println(Events)
	// print the data as a test to see if it is working
	http.HandleFunc("/", handlerBySport)
	log.Fatal(http.ListenAndServe(":80", nil))

}

func handlerBySport(w http.ResponseWriter, r *http.Request) {

	var selectedSportData Event

	fmt.Println("Handler for Sport - Incoming Request: ")
	fmt.Println("Method: ", r.Method, " ", r.URL)

	game := strings.Split(r.URL.Path, "/")[1]

	game, _ = url.PathUnescape(game)
	// split the url

	var sportSearched = game

	fmt.Println(sportSearched)
	// create a variable for the sport send by the client, print it so make sure everything is working so far

	if sportSearched == "" {
		fmt.Println("error")
	}

	for index := 0; index <= 18; index++ {
		if Events[index].Sport == sportSearched {
			// search through array "game" and find struct with with specific sport name
			selectedSportData.Sport = sportSearched
			selectedSportData.Location = Events[index].Location
			selectedSportData.Notes = Events[index].Notes
			selectedSportData.Time = Events[index].Time
			selectedSportData.Lat = Events[index].Lat
			selectedSportData.Long = Events[index].Long

		}
		// assign all of the data from the selected sport on to a new slice so it can be put in to a json
	}

	fmt.Println(selectedSportData)
	// test to see if the data is being generated correctly

	var testJson = []byte{}

	testJson, _ = json.Marshal(selectedSportData)

	dataJson := string(testJson)

	fmt.Fprintf(w, dataJson)
	// Answer the Client request
}
