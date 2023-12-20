# Kelly Swift Algorithm

## Heap
Swift로 구현된 최소 힙 입니다.

```swift
struct Heap<Element>
```

***
### Overview

Array를 기반으로 구현한 최소 힙 자료구조 입니다. 원소가 들어온 순서에 상관 없이 항상 최솟값을 리턴하며, 원소의 타입에 상관하지 않습니다.

다음과 같은 방법으로 빈 힙을 생성할 수 있습니다:
```swift
// Type of element to be stored inside the heap
struct SomeElement {
    var value: Int
}

// Create an empty Heap that stores elements of the type 'SomeElement'
var heap = Heap<SomeElement>(compareFunction: { (pre, post) -> Bool in
    pre.value < post.value
})

```
원소의 크고 작음을 판별하기 위해 파라미터로 `compareFuction`을 받습니다. 위 예시에서는 `SomeElement`의`value` 프로퍼티로 원소간의 대소를 판별하게 됩니다.

만약 `Element`가 `Comparable` 프로토콜을 컨펌한다면, 더 간단한 방법으로 빈 원소를 생성할 수 있습니다:
```swift
// Create an Empty Heap that stores 'Int' type elements that conform to the Comparable protocol
var heap = Heap<Int>()

```
`Int` 타입을 원소를 사용하면 `Comparable` 프로토콜을 컨펌하므로, `CompareFunction` 파라미터 없이 빈 힙을 생성할 수 있습니다.

기존에 존재하는 배열을 힙으로 변환하고 싶으면 `init(container: [Element], compareFunction: @escaping (Element, Element) -> Bool)`을 사용하면 됩니다. 다음은 이 이니셜라이저를 사용하여 배열을 힙으로 변환하는 예시입니다:
```swift
// Type of element to be stored inside the heap
struct SomeElement {
    var value: Int
}

let someArray = [SomeElement](repeating: SomeElement(value: Int.random(in: 1...100)), count: 10)

// Converting [SomeElement] array to heap
var heap = Heap<SomeElement>(container: someArray, compareFunction: { (pre, post) -> Bool in
    pre.value < post.value
})
```
힙으로 변환할 배열 `container`와 앞서 사용했던 것과 같이 `compareFunction`을 작성하면 위 코드와 같이 `SomeElement` 타입을 원소로 가지는 배열 `someArray`를 간단하게 힙으로 변환시킬 수 있습니다.

마찬가지로 `Element`가 `Comparable` 프로토콜을 컨펌한다면, `compareFunction` 클로저가 필요없이 배열을 힙으로 변환할 수 있습니다.

```swift
let integerArray = [Int](repeating: Int.random(in: 1...100), count: 10)

// Converting [Int] array to heap
var heap = Heap<Int>(container: integerArray)

```

### Insertion and deletion of values
값의 삽입과 삭제는 `push(_ value: Element)`와 `pop() -> Element?`에 의해 이루어 집니다.

힙 내부에 값을 삽입하려면 `push(_ value: Element)` 메소드를 사용합니다:
```swift
var heap = Heap<Int>()
heap.push(1)
heap.push(3)
heap.push(2)
```
위 코드의 실행 결과로 힙은 `1, 3, 2` 세 원소를 가지게 됩니다. 이는 입력 순서에 따라 나열한 것이며, 값이 리턴되는 순서와는 상관이 없습니다.

힙에서 값을 삭제하려면(혹은 힙에서 값을 꺼내려면) `pop()` 메소드를 사용합니다:
```swift
print(heap.pop())
print(heap.pop())
print(heap.pop())
print(heap.pop())
//Optional(1)
//Optional(2)
//Optional(3)
//nil
```
힙에 원소들이 삽입된 순서와 상관 없이 작은 원소부터 값이 차례대로 나온것을 알 수 있습니다. `pop()` 메소드는 옵셔널 값을 리턴하며, 만약 heap이 비어있는 상태에서 `pop()` 메소드를 사용하면 `nil`이 리턴됩니다.

### properties

#### isEmpty
```swift
var isEmpty: Bool
```
힙이 비어있는지 알려주는 부울리안 값 입니다. 만약 힙이 비어있으면 `true`, 그렇지 않다면 `false`를 리턴합니다.

```swift
var heap = Heap<Int>()
print(heap.isEmpty)
// true
```

#### count
```swift
var count: Int
```
힙 내부에 있는 원소의 개수를 리턴합니다.

```swift
var heap = Heap<Int>()
heap.push(10)
print(heap.count)
// 1
```
