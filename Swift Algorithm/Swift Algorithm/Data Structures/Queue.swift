//
//  Queue.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/18/23.
//

import Foundation

struct Queue<Value> {
    private var list = LinkedList<Value>()
    
    var isEmpty: Bool { list.isEmpty }
    var count: Int { list.count }
    
    mutating func push(_ v: Value) {
        list.push(v)
    }
    
    @discardableResult
    mutating func pop() -> Value? {
        return list.popFirst()
    }
}
