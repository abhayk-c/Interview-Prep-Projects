
import Foundation

/// Data structures that implement the insert and pop actions.
enum DataStructure: String, CustomStringConvertible {
   /// First in, last out. Last in, first out.
   case stack
   /// First in, first out.
   case queue
   /// Lowest value out first.
   case priority

   var description: String {
       return rawValue
   }
}

/// An action that can appear in a trace on a DataStructure
enum Action {
   /// Action that represents an integer being placed into the data structure.
   /// Associated value is the value that is inserted.
   case insert(Int)
   /// Action that represents an integer being popped from the data structure.
   /// Associated value is the value that is popped.
   case pop(Int)
}

/// Returns a set containing zero or more DataStructures indicating which data structures
/// the trace can represent.
func dataStructures(_ traces: [Action]) -> Set<DataStructure> {
    var arrayStack: [Int] = []
    var arrayQueue: [Int] = []
    let minPriorityQueue = BinaryHeap<Int>({ (lhs, rhs) -> Bool in
        return lhs < rhs
    })
    var dataStructures = Set<DataStructure>([.stack, .queue, .priority])
    for trace in traces {
        switch trace {
            case .insert(let insertedValue):
                for dataStructure in dataStructures {
                    if dataStructure == .stack {
                        arrayStack.append(insertedValue)
                    } else if dataStructure == .queue {
                        arrayQueue.append(insertedValue)
                    } else {
                        minPriorityQueue.insert(insertedValue)
                    }
                }
            case .pop(let poppedValue):
                var dataStructuresToEliminate: [DataStructure] = []
                for dataStructure in dataStructures {
                    if dataStructure == .stack {
                        if !arrayStack.isEmpty {
                            let stackPoppedValue = arrayStack.removeLast()
                            if stackPoppedValue != poppedValue {
                                dataStructuresToEliminate.append(.stack)
                            }
                        } else {
                            dataStructuresToEliminate.append(.stack)
                        }
                    } else if dataStructure == .queue {
                        if !arrayQueue.isEmpty {
                            let queuePoppedValue = arrayQueue.removeFirst()
                            if queuePoppedValue != poppedValue {
                                dataStructuresToEliminate.append(.queue)
                            }
                        } else {
                            dataStructuresToEliminate.append(.queue)
                        }
                    } else {
                        if let priorityQueuePoppedValue = minPriorityQueue.pop() {
                            if priorityQueuePoppedValue != poppedValue {
                                dataStructuresToEliminate.append(.priority)
                            }
                        } else {
                            dataStructuresToEliminate.append(.priority)
                        }
                    }
                }
                for removeDataStructure in dataStructuresToEliminate {
                    dataStructures.remove(removeDataStructure)
                }
        }
    }
    return dataStructures
}
