//
//  Queue.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/17/23.
//

import Foundation

struct Heap<Element> {
    private var container: [Element] = []
    private var compareFunction: (Element, Element) -> Bool
    var isEmpty: Bool { container.isEmpty }
    var count: Int { container.count }
    
    init(compareFunction: @escaping (Element, Element) -> Bool) {
        self.compareFunction = compareFunction
    }
    init(container: [Element], compareFunction: @escaping (Element, Element) -> Bool) {
        self.container = container
        self.compareFunction = compareFunction
        heapify()
    }
    
    mutating func push(_ value: Element) {
        container.append(value)
        heapifyUp(container.count - 1)
    }
    mutating func pop() -> Element? {
        guard !isEmpty else { return nil }
        let popElement = container[0]
        container.swapAt(0, container.count - 1)
        container.removeLast()
        heapifyDown(0)
        return popElement
    }
    
    mutating func heapify() {
        for i in (0...(count/2 - 1)).reversed() {
            heapifyDown(i)
        }
    }
    mutating private func heapifyDown(_ index: Int) {
        var current = index
        while current * 2 + 1 < count {
            let left = current * 2 + 1
            let right = left + 1
            var minChild = left
            if right < count && compareFunction(container[right], container[left]) {
                minChild = right
            }
            if compareFunction(container[minChild], container[current]) {
                container.swapAt(minChild, current)
                current = minChild
            } else {
                break
            }
        }
    }
    mutating private func heapifyUp(_ index: Int) {
        var current = index
        while current > 0 {
            let parent = (current - 1) / 2
            if compareFunction(container[current], container[parent]) {
                container.swapAt(current, parent)
                current = parent
            } else {
                break
            }
        }
    }
}

//MARK: - When 'Element' conforms 'Comparable' Protocols

extension Heap where Element: Comparable {
    
    init() {
        self.compareFunction = { (pre, post) -> Bool in
            pre < post
        }
    }
    
    init(container: [Element]) {
        self.init()
        self.container = container
        heapify()
    }
}
