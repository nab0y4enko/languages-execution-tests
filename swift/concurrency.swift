import Foundation

let start = Date()
let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInitiated)

for _ in 0..<100 {
    queue.async(group: group) {
        var sum = 0
        for i in 0..<1_000_000 {
            sum += i
        }
    }
}

group.wait()
let elapsed = Date().timeIntervalSince(start)
print("Time: \(elapsed * 1000) ms") // Convert seconds to ms
