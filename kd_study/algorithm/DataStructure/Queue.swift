//
//  Queue.swift
//  KDTool
//
//  Created by hour on 2018/8/7.
//

/*
 Queue
 
 A queue is a list where you can only insert new items at the back and
 remove items from the front. This ensures that the first item you enqueue
 is also the first item you dequeue. First come, first serve!
 
 A queue gives you a FIFO or first-in, first-out order. The element you
 inserted first is also the first one to come out again. It's only fair!
 
 In this implementation, enqueuing is an O(1) operation, dequeuing is O(n).
 */

/*
public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}
 */

/*
 First-in first-out queue (FIFO)
 
 New elements are added to the end of the queue. Dequeuing pulls elements from
 the front of the queue.
 
 Enqueuing and dequeuing are O(1) operations.
 */
public struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}
