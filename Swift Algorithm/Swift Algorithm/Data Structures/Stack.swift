//
//  Stack.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/26/23.
//

import Foundation

struct Stack<Value> {
    private var container: Array<Value> = []
    var isEmpty: Bool { container.isEmpty }
    var count: Int { container.count }
    
    mutating func push(_ value: Value) {
        container.append(value)
    }
    
    mutating func pop() -> Value? {
        guard !isEmpty else {
            return nil
        }
        return container.removeLast()
    }
}
