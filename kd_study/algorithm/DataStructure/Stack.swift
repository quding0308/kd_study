//
//  Stack.swift
//  KDTool
//
//  Created by hour on 2018/8/7.
//

/*
 Stack
 
 A stack is like an array but with limited functionality. You can only push
 to add a new element to the top of the stack, pop to remove the element from
 the top, and peek at the top element without popping it off.
 
 A stack gives you a LIFO or last-in first-out order. The element you pushed
 last is the first one to come off with the next pop.
 
 Push and pop are O(1) operations.
 */

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}
