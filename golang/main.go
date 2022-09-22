package main

import "fmt"

func main() {
	fmt.Print("Enter a number of meters: ")
	var input float64
	//const feets =
	fmt.Scanf("%f", &input)
	fmt.Println(input)

	output := input * 3.28084

	fmt.Println(output)
}
