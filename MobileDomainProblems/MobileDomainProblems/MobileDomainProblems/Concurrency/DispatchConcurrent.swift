//
//  DispatchConcurrent.swift
//  MobileDomainProblems
//
//  Created by Abhay Curam on 11/12/25.
//

import Foundation

public class DispatchConcurrent {
    private let concurrentQueue = DispatchQueue(label: "DispatchConcurrent.concurrent.queue",
                                                attributes: .concurrent)
    public func concurrentPerform(iterations: Int, _ performBlock: @escaping ((Int) -> Void)) {
        let taskGroup = AsyncTaskGroup()
        for index in 0..<iterations {
            taskGroup.enter()
            concurrentQueue.async {
                performBlock(index)
                taskGroup.leave()
            }
        }
        taskGroup.wait()
    }
}

