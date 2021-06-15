//
//  Stack.swift
//  Markly
//
//  Created by Ramon Torres on 5/2/21.
//

// Stack data structure
struct Stack<T> {
    private var items: [T] = []

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func top() -> T? {
        return items.last
    }
}
