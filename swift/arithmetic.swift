import Foundation

let start = Date()
let sum = (1...100_000_000).reduce(0, +)
let elapsed = Date().timeIntervalSince(start)
print("Time: \(elapsed * 1000) ms") // Convert seconds to ms
