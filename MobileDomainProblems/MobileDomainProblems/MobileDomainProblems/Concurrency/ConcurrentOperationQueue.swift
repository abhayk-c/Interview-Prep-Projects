//
//  ConcurrentOperationQueue.swift
//
//  Created by Abhay Curam on 10/30/25.
//  Copyright © 2025 Tweeter. All rights reserved.
//

import Foundation

public typealias DidFinish = (() -> Void)
public typealias Operation = ((_ didFinish: @escaping DidFinish) -> Void)
public typealias BatchNotify = ((Bool) -> Void)

private class ConcurrentOperation {
    var operationBlock: Operation
    var didFinishBlock: DidFinish
    
    public init(_ operationBlock: @escaping Operation, _ didFinishBlock: @escaping DidFinish) {
        self.operationBlock = operationBlock
        self.didFinishBlock = didFinishBlock
    }
}

/**
 * This is basically a light weight NSOperationQueue.
 * This is a concurrent operation queue where operations (blocks) are executed
 * concurrently and the calling client can apply a "cap" on the maximum number of
 * concurrent operations executing at any given time.
 */
public class ConcurrentOperationQueue {
    
    private var operationCount: Int = 0
    private var pendingConcurrentJobQueue: [ConcurrentOperation] = []
    private let maxConcurrentOperations: Int
    
    private var mutex: NSLock = NSLock()
    private var concurrentDispatchQueue = DispatchQueue(label: "concurrent.operation", attributes: .concurrent)
    
    public init(_ maxConcurrentOperations: Int) {
        self.maxConcurrentOperations = maxConcurrentOperations
    }
    
    /**
     * Perform a concurrent operation.
     * An operation is just a Void Block/Closure.
     * The caller must call didFinish() when the operation is complete.
     * didFinish() should ONLY be called once, its up to the caller to manage that.
     */
    public func performOperationAsync(_ operation: @escaping Operation) {
        let concurrentOperation = createConcurrentOperation(operation)
        if safelyCheckedAndIncrementedOperationCount() {
            startConcurrentOperation(concurrentOperation)
        } else {
            safelyAppendOperationToConcurrentJobQueue(concurrentOperation)
        }
    }
    
    /**
     * Use this API to perform an array of Operations in "batch" concurrently.
     * This API tracks when all concurrent operations are done and notifies the caller.
     */
    public func performOperationsInBatchAsync(_ operations: [Operation],
                                              _ batchNotifyQueue: DispatchQueue,
                                              _ batchNotifyBlock: @escaping BatchNotify) {
        let taskGroup = AsyncTaskGroup()
        for operation in operations {
            let concurrentBatchOperation = createConcurrentBatchOperation(operation, taskGroup)
            if safelyCheckedAndIncrementedOperationCount() {
                startConcurrentOperation(concurrentBatchOperation)
            } else {
                safelyAppendOperationToConcurrentJobQueue(concurrentBatchOperation)
            }
        }
        taskGroup.notify(queue: batchNotifyQueue) {
            batchNotifyBlock(true)
        }
    }
    
    private func createConcurrentBatchOperation(_ operation: @escaping Operation,
                                                _ taskGroup: AsyncTaskGroup) -> ConcurrentOperation {
        taskGroup.enter()
        let didFinishCompletion: DidFinish = { [weak self] in
            if let strongSelf = self {
                if let pendingJob = strongSelf.safelyPopConcurrentOperationFromJobQueue() {
                    strongSelf.startConcurrentOperation(pendingJob)
                } else {
                    strongSelf.safelyDecrementOperationCount()
                }
            }
            taskGroup.leave()
        }
        return ConcurrentOperation(operation, didFinishCompletion)
    }
    
    private func createConcurrentOperation(_ operation: @escaping Operation) -> ConcurrentOperation {
        let didFinishCompletion: DidFinish = { [weak self] in
            if let strongSelf = self {
                if let pendingJob = strongSelf.safelyPopConcurrentOperationFromJobQueue() {
                    strongSelf.startConcurrentOperation(pendingJob)
                } else {
                    strongSelf.safelyDecrementOperationCount()
                }
            }
        }
        return ConcurrentOperation(operation, didFinishCompletion)
    }
    
    private func startConcurrentOperation(_ operation: ConcurrentOperation) {
        concurrentDispatchQueue.async {
            let didFinish = operation.didFinishBlock
            let operation = operation.operationBlock
            operation(didFinish)
        }
    }
    
    private func safelyCheckedAndIncrementedOperationCount() -> Bool {
        mutex.lock()
        var didIncrement = false
        if operationCount < maxConcurrentOperations {
            operationCount += 1
            didIncrement = true
        }
        mutex.unlock()
        return didIncrement
    }
    
    private func safelyDecrementOperationCount() -> Void {
        mutex.lock()
        operationCount = (operationCount == 0) ? 0 : operationCount - 1
        mutex.unlock()
    }
    
    private func safelyAppendOperationToConcurrentJobQueue(_ concurrentOperation: ConcurrentOperation) {
        mutex.lock()
        pendingConcurrentJobQueue.append(concurrentOperation)
        mutex.unlock()
    }
    
    private func safelyPopConcurrentOperationFromJobQueue() -> ConcurrentOperation? {
        mutex.lock()
        var firstOperation: ConcurrentOperation? = nil
        if !pendingConcurrentJobQueue.isEmpty {
            firstOperation = pendingConcurrentJobQueue.removeFirst()
        }
        mutex.unlock()
        return firstOperation
    }
    
    /**
     * Just exposed for testing.
     */
    public func getConcurrentOperationCount() -> Int {
        mutex.lock()
        let readCount = operationCount
        mutex.unlock()
        return readCount
    }
    
}
