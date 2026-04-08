//
//  CPUTaskScheduler.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 12/13/25.
//

import Foundation

private struct RunnableTask: Comparable {
    let task: Character
    let taskCount: Int
    static func < (lhs: RunnableTask, rhs: RunnableTask) -> Bool {
        return lhs.taskCount < rhs.taskCount
    }
}

private struct SleepingTask {
    let task: Character
    let taskCount: Int
    let sleepUntil: Int
}

class CPUTaskScheduler {
    
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var waitQueue: [SleepingTask] = []
        let readyQueue = BinaryHeap<RunnableTask> { lhs, rhs in
            return lhs.taskCount > rhs.taskCount
        }
        var taskPool: [Character: Int] = [:]
        for task in tasks {
            if taskPool[task] != nil {
                taskPool[task]? += 1
            } else {
                taskPool[task] = 1
            }
        }
        for (task, taskCount) in taskPool {
            let runnableTask = RunnableTask(task: task, taskCount: taskCount)
            readyQueue.insert(runnableTask)
        }
        
        var time = 0
        var scheduledTasks: [Character] = []
        while waitQueue.isEmpty == false || readyQueue.isEmpty() == false {
            //Move tasks from waitQueue to runQueue if eligible
            while !waitQueue.isEmpty {
                if let frontTask = waitQueue.first {
                    if frontTask.sleepUntil <= time {
                        let runnableTask = RunnableTask(task: frontTask.task, taskCount: frontTask.taskCount)
                        readyQueue.insert(runnableTask)
                        waitQueue.removeFirst()
                    } else {
                        break
                    }
                }
            }
            //Now run task if possible and move to wait queue
            if let runnableTask = readyQueue.pop() {
                scheduledTasks.append(runnableTask.task)
                let sleepingTask = SleepingTask(task: runnableTask.task, taskCount: runnableTask.taskCount - 1, sleepUntil: time + n + 1)
                if sleepingTask.taskCount > 0 {
                    waitQueue.append(sleepingTask)
                }
            } else {
                //This means we are idling
                scheduledTasks.append(" ")
            }
            time += 1
        }
        
        return scheduledTasks.count
    }
    
}
