package main

import (
    "fmt"
    "time"
)

func main() {
    numbers := make([]int, 1000000)
    for i := range numbers {
        numbers[i] = i
    }

    start := time.Now()
    sum := 0
    for _, num := range numbers {
        sum += num
    }
    elapsed := time.Since(start)
    fmt.Printf("Time: %v\n", elapsed)
}