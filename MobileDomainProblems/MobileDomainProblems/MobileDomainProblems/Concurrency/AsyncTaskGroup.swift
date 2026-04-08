//
//  AsyncTaskGroup.swift
//  MobileDomainProblems
//
//  Created by Abhay Curam on 11/12/25.
//

import Foundation

private class AsyncTaskObserver {
    let observer: (() -> Void)
    let observerQueue: DispatchQueue
    public init(_ observer: @escaping (() -> Void), _ observerQueue: DispatchQueue) {
        self.observer = observer
        self.observerQueue = observerQueue
    }
}

class AsyncTaskGroup {
    
    private var condition: NSCondition = NSCondition()
    private var taskCount: Int = 0
    private var notificationObservers: [AsyncTaskObserver] = []
    
    public func enter() {
        condition.lock()
        taskCount += 1
        condition.unlock()
    }
    
    public func leave() {
        condition.lock()
        taskCount -= 1
        if taskCount < 0 {
            assertionFailure("leave() has been called more times than enter()")
            condition.unlock()
            return
        }
        if taskCount == 0 {
            unsafelyNotifyAndDrainObservers()
            condition.broadcast()
        }
        condition.unlock()
    }
    
    public func wait() {
        condition.lock()
        while taskCount != 0 {
            condition.wait()
        }
        condition.unlock()
    }
    
    public func notify(queue: DispatchQueue, _ completion: @escaping (() -> Void)) {
        condition.lock()
        if taskCount == 0 {
            queue.async {
                completion()
            }
        } else {
            let taskObserver = AsyncTaskObserver(completion, queue)
            notificationObservers.append(taskObserver)
        }
        condition.unlock()
    }
    
    private func unsafelyNotifyAndDrainObservers() {
        while !notificationObservers.isEmpty {
            let taskObserver = notificationObservers.removeFirst()
            /**
             * Just like the notifyCallBack block is retained here by the block submitted to the DispatchQueue.
             * The DispatchQueue itself is retained by GCD until all work items submitted to a queue complete.
             * This makes it so if a thread context switch happens and the DispatchQueue is overwritten we need not worry.
             * Can apparently read up on this behavior here:
             * https://www.mikeash.com/pyblog/friday-qa-2015-07-17-lets-build-dispatch.html
             */
            taskObserver.observerQueue.async {
                taskObserver.observer()
            }
        }
    }
    
}
