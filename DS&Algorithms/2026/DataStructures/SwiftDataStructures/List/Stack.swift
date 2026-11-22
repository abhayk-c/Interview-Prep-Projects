//
//  Stack.swift
//  List
//
//  Created by Abhay Curam on 7/12/26.
//

public class Stack<T: Any>
{
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
    
    public func push(_ element: T) {
        list.insertBack(element)
    }
    
    public func pop() -> T? {
        guard let topElement = list.back?.value else { return nil }
        list.removeBack()
        return topElement
    }
    
    public func top() -> T? {
        return list.back?.value
    }
    
    public func clear() {
        list.clear()
    }
    
}
