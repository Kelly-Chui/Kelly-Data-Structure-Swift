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
    
    var first: Value? { head?.value }
    var last: Value? { tail?.value }
    var isEmpty: Bool { head == nil }
    var count: Int = 0
    
    private func find(index: Int) -> LinkedListElement<Value>? {
        var current = head
        for _ in stride(from: 0, to: index, by: 1) {
            current = current?.postElement
        }
        return current
        // TODO: Reversed is also required
    }
    
    // Method used to add an element at the end of a list
    mutating func push(_ value: Value) {
        let addedElement = LinkedListElement(preElement: self.tail, value: value)
        if count == 0 {
            head = addedElement
            tail = addedElement
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
        if index == count {
            push(value)
            return
        }
        let current = find(index: index)
        let addedElement = LinkedListElement(preElement: current?.preElement, postElement: current, value: value)
        if index == 0 {
            head = addedElement
        }
        if count == 0 {
            head = addedElement // If count == 0 is true, then index == 0 is also true, so this line is not actually necessary.
            tail = addedElement
        }
        current?.preElement?.postElement = addedElement
        current?.preElement = addedElement
        count += 1
    }
    
    @discardableResult
    mutating func popFirst() -> Value? {
        guard head != nil else {
            return nil
        }
        var headElement = head
        let headValue = headElement?.value
        head = head?.postElement
        head?.preElement = nil
        count -= 1
        headElement = nil
        return headValue
    }
    
    @discardableResult
    mutating func popLast() -> Value? {
        guard tail != nil else {
            return nil
        }
        var tailElement = tail
        let tailValue = tailElement?.value
        tail = tail?.preElement
        tail?.postElement = nil
        count -= 1
        tailElement = nil
        return tailValue
    }
    
    @discardableResult
    mutating func pop(at index: Int) -> Value? {
        guard index >= 0, index < count else {
            fatalError("Index out of bounds")
        }
        
        if index == 0 {
            return popFirst()
        }
        if index == count - 1 {
            return popLast()
        }
        var current = head
        current = find(index: index)
        let value = current?.value
        
        let preElement = current?.preElement
        let postElement = current?.postElement
        preElement?.postElement = postElement
        postElement?.preElement = preElement
        
        current = nil
        count -= 1
        return value
    }
    
    // Accessing values using subscripts
    subscript(index: Int) -> Value? {
        guard index >= 0, index < count else {
            fatalError("Index out of bounds")
        }
        
        var current = head
        current = find(index: index)
        return current?.value
    }
}

//MARK: - Conform Sequence Protocol

extension LinkedList: Sequence {
    struct LinkedListIterator: IteratorProtocol {
        var current: LinkedListElement<Value>?

        mutating func next() -> Value? {
            defer {
                current = current?.postElement
            }
            return current?.value
        }
    }

    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(current: head)
    }
}
