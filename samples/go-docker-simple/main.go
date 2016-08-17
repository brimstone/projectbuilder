package main

import (
	"io/ioutil"
	"log"
	"net/http"
)

var COMMITHASH = "dev"
var BUILDDATETIME = "now"

func main() {
	log.Println("COMMITHASH:", COMMITHASH, "BUILDDATETIME:", BUILDDATETIME)
	resp, _ := http.Get("http://echoip.com")
	body, _ := ioutil.ReadAll(resp.Body)
	log.Println(string(body))
}
