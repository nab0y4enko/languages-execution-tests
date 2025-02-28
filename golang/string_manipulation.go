package main

import (
    "fmt"
    "strings"
    "time"
)

func main() {
    start := time.Now()
    var builder strings.Builder
    for i := 0; i < 1000000; i++ {
        builder.WriteString("Hello")
    }
    elapsed := time.Since(start)
    fmt.Printf("Time: %v\n", elapsed)
}