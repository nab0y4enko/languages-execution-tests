import Foundation

let start = Date()
var sum = 0
for i in 1...100_000_000 {
    sum += i
}
let elapsed = Date().timeIntervalSince(start)
print("Time: \(elapsed * 1000) ms") // Convert seconds to ms
