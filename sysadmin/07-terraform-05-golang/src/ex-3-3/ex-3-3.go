package main

import "fmt"

func main() {
	x := []int{}
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			x = append(x, i)
		}
	}
	fmt.Println(x)
}
