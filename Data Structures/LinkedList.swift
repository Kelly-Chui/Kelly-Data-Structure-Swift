//
//  LinkedList.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/18/23.
//

import Foundation

class LinkedListElement<Value> {
    fileprivate weak var preElement: LinkedListElement?
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
    
    init() {}
    init(_ values: [Value]) {
        for value in values {
            self.push(value)
        }
    }

    private func find(index targetIndex: Int) -> LinkedListElement<Value>? {
        guard targetIndex >= 0 && targetIndex < count else { return nil }
        if targetIndex < count / 2 {
            var currentNode = head
            var currentIndex = 0
            while currentIndex < targetIndex {
                currentNode = currentNode?.postElement
                currentIndex += 1
            }
            return currentNode
        } else {
            var currentNode = tail
            var currentIndex = count - 1
            while currentIndex > targetIndex  {
                currentNode = currentNode?.preElement
                currentIndex -= 1
            }
            return currentNode
        }
    }
    // Method used to add an element at the end of a list
    mutating func push(_ value: Value) {
        let newNode = LinkedListElement(preElement: tail, value: value)
        tail?.postElement = newNode
        tail = newNode
        if isEmpty {
            head = newNode
        }
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
        let nextNode = find(index: index)
        let previousNode = nextNode?.preElement
        let newNode = LinkedListElement(preElement: previousNode, postElement: nextNode, value: value)
        previousNode?.postElement = newNode
        nextNode?.preElement = newNode
        if index == 0 { head = newNode }
        count += 1
    }
    @discardableResult
    mutating func popFirst() -> Value? {
        guard count > 0 else { return nil }
        let value = head?.value
        head = head?.postElement
        head?.preElement = nil
        count -= 1
        if count == 0 {
            tail = nil
        }
        return value
    }
    @discardableResult
    mutating func popLast() -> Value? {
        guard count > 0 else { return nil }
        let value = tail?.value
        tail = tail?.preElement
        tail?.postElement = nil
        count -= 1
        if count == 0 {
            head = nil
        }
        return value
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
        let targetNode = find(index: index)
        let value = targetNode?.value
        let previousNode = targetNode?.preElement
        let nextNode = targetNode?.postElement
        previousNode?.postElement = nextNode
        nextNode?.preElement = previousNode
        count -= 1
        return value
    }
    subscript(index: Int) -> Value? {
        guard index >= 0 && index < count else {
            return nil
        }
        return find(index: index)?.value
    }
}