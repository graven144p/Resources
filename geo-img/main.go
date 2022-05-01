package main

import (
	"fmt"
	"os"

	"github.com/rwcarlsen/goexif/exif"
)

//https://www.google.com/maps/@56.3431557,-73.6772364,11.11z

func check(err error, exit int, msg string) {
	if err != nil {
		fmt.Println("{+} GOT ERR: -> ", err, "{+} WITH MESSAGE -> ", msg)
		os.Exit(exit)
	} else {
		fmt.Println("[+] Passed: ERR: Returned NIL")
	}
}

func main() {
	if len(os.Args) == 1 {
		fmt.Printf("Usage: %v \n", os.Args[0])
	} else {
		f, err := os.Open(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "file: %v\n", err)
			os.Exit(1)
		}

		x, err := exif.Decode(f)
		check(err, 1, "DEBUG: ERR: FATAL: during running the decode function for EXIF")

		lat, long, err := x.LatLong()
		if err != nil {
			fmt.Fprintf(os.Stderr, "LatLong: %v\n", err)
			os.Exit(1)
		} else {
			fmt.Fprintln(os.Stdout, f.Name())
			fmt.Println("[+] Image -> ", os.Args[0])
			fmt.Fprintln(os.Stdout, fmt.Sprintf("[+] lat:\t%v\n[+] long:\t%v", lat, long))
			fmt.Fprintln(os.Stdout, fmt.Sprintf("[+] Possible Location -> https://www.google.com/maps/@%v,%v", lat, long))
			os.Exit(0)
		}
	}
}
