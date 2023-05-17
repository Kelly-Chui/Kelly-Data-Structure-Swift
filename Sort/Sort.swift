//
//  sort.swift
//  Kelly_Swift_DataStructure
//
//  Created by KellyChui on 2023/05/17.
//

import Foundation

// Sorting algorithms with time complexity O(n²)

// Bubble Sort
func bubbleSort<element: Comparable>(_ array: [element]) -> [element] {
    var sortedArray = array
    var end = 1
    while end != array.count {
        for idx in 0..<array.count - end {
            if sortedArray[idx] > sortedArray[idx + 1] {
                sortedArray.swapAt(idx, idx + 1)
            }
        }
        end += 1
    }
    return sortedArray
}

// Selection Sort
func selectionSort<element: Comparable>(_ array: [element]) -> [element] {
    var sortedArray = array
    var index = 0
    while index < sortedArray.count {
        let minValue = sortedArray[index...].min()!
        let minIndex = sortedArray[index...].firstIndex(of: minValue)!
        sortedArray.swapAt(minIndex, index)
        index += 1
    }
    return sortedArray
}

// Insertion Sort
func insertionSort<element: Comparable>(_ array: [element]) -> [element] {
    var sortedArray = array
    for i in 1..<array.count {
        let currentValue = sortedArray[i]
        for j in 0..<i {
            if sortedArray[j] > currentValue {
                sortedArray.remove(at: i)
                sortedArray.insert(currentValue, at: j)
                break
            }
        }
    }
    return sortedArray
}

// Quick Sort
func quickSort<element: Comparable>(_ array: [element]) -> [element] {
    return array
}

// Sorting algorithms with time complexity O(nLogn)

// Merge Sort
func mergeSort<element: Comparable>(_ array: [element]) -> [element] {
    func combine(_ leftSlice: [element], _ rightSlice: [element]) -> [element] {
        var combinedArray: [element] = []
        var pointer = (0, 0)
        while pointer.0 < leftSlice.count && pointer.1 < rightSlice.count {
            if leftSlice[pointer.0] < rightSlice[pointer.1] {
                combinedArray.append(leftSlice[pointer.0])
                pointer.0 += 1
            } else {
                combinedArray.append(rightSlice[pointer.1])
                pointer.1 += 1
            }
        }
        if pointer.0 < leftSlice.count {
            combinedArray += Array(leftSlice[pointer.0...])
        } else if pointer.1 < rightSlice.count {
            combinedArray += Array(rightSlice[pointer.1...])
        }
        return combinedArray
    }
    if array.count < 2 {
        return array
    }
    let mid = array.count / 2
    let leftSlice = mergeSort(Array(array[0..<mid]))
    let rightSlice = mergeSort(Array(array[mid...]))
    return combine(leftSlice, rightSlice)
}
