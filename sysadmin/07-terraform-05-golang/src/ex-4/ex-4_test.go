package main

import "testing"

func testMain(t *testing.T) {
	var y float64
	y = Average([]float64{1, 2, 3, 4})
	if y != 2.5 {
		t.Error("Expected 2.5, got ", y)
	}
}
