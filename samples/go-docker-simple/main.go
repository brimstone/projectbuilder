package main

import (
	"log"
	"net/http"
)

func main() {
	log.Println(http.Get("https://google.com"))
}
