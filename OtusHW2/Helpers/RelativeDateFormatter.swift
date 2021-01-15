//
//  RelativeDateFormatter.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation

class RelativeDateFormatter {
    
    @available(iOS 13.0, *)
    private lazy var builtInRelativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        return formatter
    }()
    
    private lazy var yearDateFormatter: DateFormatter = DateFormatter.formatter(.ddMMMMyyyy)

    private lazy var currentYearDateFormatter: DateFormatter = DateFormatter.formatter(.ddMMMM)
    
    private lazy var timeFormatter: DateFormatter = DateFormatter.formatter(.HHmm)
    
    func format(date: Date) -> String {
        if #available(iOS 13.0, *) {
            return builtInRelativeFormatter.localizedString(for: date, relativeTo: Date())
        } else {
            let time = timeFormatter.string(from: date)
            let prefix: String
            if date.isYesterday {
                prefix = NSLocalizedString("yesterday".capitalized, comment: "")
            } else if date.isToday {
                prefix = NSLocalizedString("today".capitalized, comment: "")
            } else if date.isTomorrow {
                prefix = NSLocalizedString("tomorrow".capitalized, comment: "")
            } else if date.isCurrentYear {
                prefix = currentYearDateFormatter.string(from: date)
            } else {
                prefix = yearDateFormatter.string(from: date)
            }
            
            return [prefix, time].joined(separator: " ")
        }
    }
}
