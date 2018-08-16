//
//  Heap.swift
//  KDTool
//
//  Created by hour on 2018/8/7.
//

public struct Heap<T> {
    
    /** The array that stores the heap's nodes. */
    var nodes = [T]()
    
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    public var count: Int {
        return nodes.count
    }
    
}
