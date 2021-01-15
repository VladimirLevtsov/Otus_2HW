//
//  OffsetPagination.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import Foundation

protocol DateOrdered {
    var date: Date? { get }
}

struct OffsetPagination: Equatable {
    private(set) var earliestTimestamp = Int(Date().timeIntervalSince1970)
    let count: Int
    private(set) var hasNext: Bool = true
    
    mutating func handle(array: [DateOrdered]) {
        if let earliestDate = array.lazy.compactMap(\.date).last {
            earliestTimestamp = Int(earliestDate.timeIntervalSince1970)
            hasNext = array.count >= count
        } else {
            hasNext = false
        }
    }
    
    mutating func drop() {
        earliestTimestamp = Int(Date().timeIntervalSince1970)
        hasNext = true
    }
    
}
