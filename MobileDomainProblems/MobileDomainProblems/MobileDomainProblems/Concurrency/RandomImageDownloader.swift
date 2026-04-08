//
//  RandomImageDownloader.swift
//  MobileDomainProblems
//
//  Created by Abhay Curam on 11/13/25.
//

import Foundation
import AppKit

public class RandomImageDownloader {
    
    private lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.httpMaximumConnectionsPerHost = 10
        return URLSession(configuration: urlSessionConfiguration)
    }()
    
    let urlEndpointString = "https://picsum.photos/200/300"
    
    public func downloadRandomImageAsync(_ completion: @escaping (NSImage?, Error?) -> Void) {
        let url = URL(string: urlEndpointString)!
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let data = data, let image = NSImage(data: data), error == nil {
                completion(image, nil)
            } else if let error = error {
                completion(nil, error)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    /**
     * There truly isn't a great use case for Semaphores in many practical applications of iOS Apps (in my experience).
     * GCD Queues, DisatchGroups, and standard primitives like NSLock and NSCondition can help solve almost all
     * common scenarios and cases. Even if implementing a producer consumer queue, because typically in iOS apps the producer
     * side is coming from a real-time input like camera or microphone its unacceptable to .wait() on the producer side
     * and block the producer side thread. In these designs the consumer side can "wait" and be signalled
     * by the producer when there are enough buffered bytes. Although a Semaphore could theoretically be used
     * here there are actually simpler and much easier event-driven designs for this (standard GCD and async dispatch block
     * submission).
     *
     * One interesting case where a DispatchSemaphore comes in handy is actually here. Converting a async
     * API into that of a synchronous one. Here a Semaphore could be used to bridge the async and sync worlds.
     */
    public func downloadRandomImageSync() throws(Error) -> NSImage?  {
        let semaphore = DispatchSemaphore(value: 0)
        var downloadedImage: NSImage? = nil
        var networkError: Error? = NSError()
        downloadRandomImageAsync { image, error in
            downloadedImage = image
            networkError = error
            semaphore.signal()
        }
        
        semaphore.wait()
        if downloadedImage != nil && networkError == nil {
            return downloadedImage
        } else if let unwrappedNetworkError = networkError {
            throw unwrappedNetworkError
        }
        return nil
    }
    
}
