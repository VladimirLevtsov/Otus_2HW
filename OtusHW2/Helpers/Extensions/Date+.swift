//
//  Date+.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation

extension Date {
    
    var isYesterday: Bool {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return false }
        
        return isEqual(to: yesterday, granularity: [.year, .month, .day])
    }
    
    var isToday: Bool {
        isEqual(to: Date(), granularity: [.year, .month, .day])
    }
    
    var isTomorrow: Bool {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else { return false }
        
        return isEqual(to: tomorrow, granularity: [.year, .month, .day])
    }
    
    var isCurrentYear: Bool {
        isEqual(to: Date(), granularity: [.year])
    }
    
    func isEqual(to date: Date, granularity: [Calendar.Component]) -> Bool {
        let calendar = Calendar.current
        return granularity.reduce(true, { res, granularity in return res && calendar.isDate(self, equalTo: date, toGranularity: granularity) })
    }

    func yearsPassed(_ timeInterval: TimeInterval = .zero) -> Int? {
        return Calendar.current.dateComponents([.year], from: self, to: Date(timeIntervalSince1970: timeInterval)).year
    }

    var dayComps: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: self)
    }
    
}
