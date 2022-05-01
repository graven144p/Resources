package main

import (
	"time"
	"fmt"
	"os"

	"github.com/elliotforbes/athena/port"
)

func main() {
	fmt.Println("Port Scanning")
	time.Sleep(1 * time.Second)
	results := port.InitialScan("localhost")
	fmt.Println("---------------------------RESULTS CAM BACK AS------------------------------------------------------------------")
	time.Sleep(1 * time.Second)
	fmt.Println(results)
	fmt.Println("-----------------------------------------------------------------------------------------------------------------")
}
