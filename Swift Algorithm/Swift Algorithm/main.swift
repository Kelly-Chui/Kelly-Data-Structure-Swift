//
//  main.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/17/23.
//

import Foundation

//// Type of element to be stored inside the heap
//struct someElement {
//    var value: Int
//}
//
//let someArray = [someElement](repeating: someElement(value: Int.random(in: 1...100)), count: 10)
//
//// Converting [someElement] array to heap
//var heap = Heap<someElement>(container: someArray, compareFunction: { (pre, post) -> Bool in
//    pre.value < post.value
//})

let integerArray = [Int](repeating: Int.random(in: 1...100), count: 10)

// Converting [Int] array to heap
var heap = Heap<Int>()
heap.push(10)
print(heap.count)
// 1
