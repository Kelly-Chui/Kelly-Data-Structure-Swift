//
//  LinkedList.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/18/23.
//

import Foundation

class LinkedListElement<Value> {
    fileprivate var preElement: LinkedListElement?
    fileprivate var postElement: LinkedListElement?
    var value: Value
    
    init(preElement: LinkedListElement? = nil, postElement: LinkedListElement? = nil, value: Value) {
        self.preElement = preElement
        self.postElement = postElement
        self.value = value
    }
}

struct LinkedList<Value> {
    private var head: LinkedListElement<Value>?
    private var tail: LinkedListElement<Value>?
    var isEmpty: Bool { head == nil }
    var count: Int = 0
    
    // MARK: pushing methods
    
    // Method used to add an element at the beginning of a list
    mutating func pushHead(_ value: Value) {
        let addedElement = LinkedListElement(postElement: self.head, value: value)
        head?.preElement = addedElement
        head = addedElement
        count += 1
    }
    
    // Method used to add an element at the end of a list
    mutating func push(_ value: Value) {
        let addedElement = LinkedListElement(preElement: self.tail, value: value)
        if count == 0 {
            head = addedElement
        }
        tail?.postElement = addedElement
        tail = addedElement
        count += 1
    }
    
    // Method used to add an element to the middle of a list
    mutating func push(_ value: Value, at index: Int) {
        guard index >= 0, index <= count else {
            fatalError("Index out of bounds")
        }
        if index == 0 {
            pushHead(value)
            return
        }
        if index == count {
            push(value)
            return
        }
        var current = head
        for _ in 0..<index - 1 {
            current = current?.postElement
        }
        let addedElement = LinkedListElement(preElement: current?.preElement, postElement: current, value: value)
        current?.preElement?.postElement = addedElement
        current?.preElement = addedElement
        count += 1
    }
    
    // MARK: popping methods
    mutating func popFirst() -> Value? {
        guard head != nil else {
            return nil
        }
        let firstValue = head?.value
        head = head?.postElement
        head?.preElement = nil
        count -= 1
        return firstValue
    }
    
    mutating func popLast() -> Value? {
        guard tail != nil else {
            return nil
        }
        let lastValue = tail?.value
        tail = tail?.preElement
        tail?.postElement = nil
        count -= 1
        return lastValue
    }
    
    mutating func pop(at index: Int) -> Value? {
        guard index >= 0, index < count else {
            fatalError("Index out of bounds")
        }

        if index == 0 {
            return popFirst()
        } else if index == count - 1 {
            return popLast()
        } else {
            var current = head
            for _ in 0..<index - 1 {
                current = current?.postElement
            }
            let value = current?.value
            let preElement = current?.preElement
            let postElement = current?.postElement

            preElement?.postElement = postElement
            postElement?.preElement = preElement

            count -= 1
            return value
        }
    }
    
    // MARK: subscripts
    
    // Accessing index using subscripts
    subscript(index: Int) -> Value? {
        guard index >= 0, index < count else {
            fatalError("Index out of bounds")
        }
        
        var current = head
        for _ in 0..<index {
            current = current?.postElement
        }
        return current?.value
    }
}
