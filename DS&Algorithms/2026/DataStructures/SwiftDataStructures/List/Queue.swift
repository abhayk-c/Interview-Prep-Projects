//
//  Queue.swift
//  List
//
//  Created by Abhay Curam on 7/12/26.
//

public class Queue<T: Any> {
    
    private var list: List<T>
    
    public var count: Int {
        get {
            return list.count
        }
    }
    
    public var empty: Bool {
        get {
            return list.empty
        }
    }
    
    public init() {
        self.list = List<T>()
    }
    
    public func enqueue(_ element: T) {
        list.insertBack(element)
    }
    
    public func dequeue() -> T? {
        guard let frontElement = list.front?.value else { return nil }
        list.removeFront()
        return frontElement
    }
    
    public func front() -> T? {
        return list.front?.value
    }
    
    public func clear() {
        list.clear()
    }
    
}
