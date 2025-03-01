import Foundation

let start = Date()
var str = ""
for _ in 0..<1_000_000 {
    str.append("Hello") 
}
let elapsed = Date().timeIntervalSince(start)
print("Time: \(elapsed * 1000) ms") // Convert seconds to ms
