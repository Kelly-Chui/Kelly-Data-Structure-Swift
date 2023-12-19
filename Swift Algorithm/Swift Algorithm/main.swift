//
//  main.swift
//  Swift Algorithm
//
//  Created by KellyChui on 12/17/23.
//

import Foundation

var list = LinkedList<Int>()
for i in 0..<10 {
    list.push(i)
}
print(list)

list.push(99, at: 3)

for i in 0..<10 {
    print(list[i])
}
print("*******")

var a = list.pop(at: 3)
print(a)
print("*******")
for i in 0..<10 {
    print(list[i])
}
