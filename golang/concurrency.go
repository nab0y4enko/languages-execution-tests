package main

import (
    "fmt"
    "sync"
    "time"
)

func worker(wg *sync.WaitGroup) {
    defer wg.Done()
    sum := 0
    for i := 0; i < 1000000; i++ {
        sum += i
    }
}

func main() {
    start := time.Now()
    var wg sync.WaitGroup
    for i := 0; i < 100; i++ {
        wg.Add(1)
        go worker(&wg)
    }
    wg.Wait()
    elapsed := time.Since(start)
    fmt.Printf("Time: %v\n", elapsed)
}