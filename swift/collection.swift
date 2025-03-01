import Foundation

let start = Date()
let numbers = Array(0..<1_000_000)
let sum = numbers.reduce(0, +)
let elapsed = Date().timeIntervalSince(start)
print("Time: \(elapsed * 1000) ms") // Convert seconds to ms
