package main

import "fmt"

func main() {
	fmt.Print("Enter a number in meters: ")
	var input float64
	n, err := fmt.Scanf("%f\n", &input)
	if err != nil || n != 1 {
		// handle invalid input
		fmt.Println(n, err)
		return
	}
	output := input * 3.28084
	fmt.Printf("\nThis is will be %g feets.\n", output)
}
