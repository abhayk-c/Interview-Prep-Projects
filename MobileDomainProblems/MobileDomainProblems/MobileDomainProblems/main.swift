//
//  main.swift
//  MobileDomainProblems
//
//  Created by Abhay Curam on 11/1/25.
//

import Foundation
import Dispatch

/**
 * Testing DispatchSemaphore, Briding Async to Sync
 */
let imageDownloader = RandomImageDownloader()
do {
    if let image = try imageDownloader.downloadRandomImageSync() {
        print("Downloaded Image")
    }
} catch {
    print(error)
}  

/**
 * Concurrent Perform Tests
 */
//Testing Interleaved Writes and Reads
var threadSafeMap = HashTable<String, Int>()
DispatchConcurrent().concurrentPerform(iterations: 5000) { index in
    if index % 2 == 0 {
        threadSafeMap.setValue(index, for: String(index))
    } else {
        let randIndex = Int.random(in: 0..<5000)
        let key = String(randIndex)
        let value = threadSafeMap.getValue(for: key)
        print("Key: \(key), Value: \(value ?? -1)")
    }
}
print("Dictionary count: \(threadSafeMap.count)")
print("Dictionary capacity: \(threadSafeMap.capacity)")
print("Printing Keys and Values:")
for i in 0..<5000 {
    let key = String(i)
    let value = threadSafeMap.getValue(for: key)
    print("Key: \(key), Value: \(value ?? -1)")
}



let concurrentOperationQueue = ConcurrentOperationQueue(10)
let urlSessionConfiguration = URLSessionConfiguration.default
urlSessionConfiguration.httpMaximumConnectionsPerHost = 10
let urlSession = URLSession(configuration: urlSessionConfiguration)
let urlString = "https://picsum.photos/200/300"

/**
 * AsyncTask Group tests (notify and wait)
 */
var dispatchGroup = AsyncTaskGroup()
for _ in 0..<100 {
    let url = URL(string: urlString)!
    let operationID = UUID()
    dispatchGroup.enter()
    let task = urlSession.dataTask(with: url) { data, response, error in
        dispatchGroup.leave()
    }
    task.resume()
}

dispatchGroup.notify(queue: .main) {
    print("!!Image downloads complete 1!!")
}

dispatchGroup.notify(queue: .main) {
    print("!!Image downloads complete 2!!")
}

dispatchGroup.wait()
dispatchGroup.wait()

for _ in 0..<100 {
    let url = URL(string: urlString)!
    let operationID = UUID()
    dispatchGroup.enter()
    let task = urlSession.dataTask(with: url) { data, response, error in
        dispatchGroup.leave()
    }
    task.resume()
}

dispatchGroup.notify(queue: .main) {
    print("!!Image downloads complete 3!!")
}

dispatchGroup.notify(queue: .main) {
    print("!!Image downloads complete 4!!")
}

dispatchGroup.wait()
dispatchGroup.wait()

/**
 * ConcurrentOperationQueue Tests
 */
for i in 0..<100 {
    let url = URL(string: urlString)!
    let operationID = UUID()
    let operation: Operation = { didFinish in
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                print("This is a NON-BATCHED operation")
                print("Image URL: \(urlString)/\(operationID)")
                print("Image size: \(data.count) bytes")
            }
            print("Concurrent Operation Count in Operation: \(concurrentOperationQueue.getConcurrentOperationCount())")
            didFinish()
        }
        task.resume()
    }
    print("Concurrent Operation Count At Time of Calling: \(concurrentOperationQueue.getConcurrentOperationCount())")
    concurrentOperationQueue.performOperationAsync(operation)
    
    
    if i == 3 || i == 8 {
        let url = URL(string: urlString)!
        let operationID = UUID()
        let batchOperation: Operation = { didFinish in
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    print("This is a BATCHED operation")
                    print("Image URL: \(urlString)/\(operationID)")
                    print("Image size: \(data.count) bytes")
                }
                print("Concurrent Operation Count in Operation: \(concurrentOperationQueue.getConcurrentOperationCount())")
                didFinish()
            }
            task.resume()
        }

        let operations = Array(repeating: batchOperation, count: 50)
        print("Concurrent Operation Count at Time of Calling Batch API: \(concurrentOperationQueue.getConcurrentOperationCount())")
        concurrentOperationQueue.performOperationsInBatchAsync(operations, .main) { didFinish in
            print("Finished executing all concurrent BATCHED operations!!")
            print("Concurrent Operation Count At Batch API Completion: \(concurrentOperationQueue.getConcurrentOperationCount())")
        }
    }
    
}


print("Dispatch Main")
dispatchMain()
