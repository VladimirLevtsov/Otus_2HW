//
//  DateFormatter+.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation

extension DateFormatter {

    enum Format: String {
        case dd             = "dd"
        case mmss           = "mm:ss"
        case HHmm           = "HH:mm"
        case HHmmss         = "HH:mm:ss"
        case ddMMyyyy       = "dd.MM.yyyy"
        case ddMMMM         = "dd MMMM"
        case dMMMM         = "d MMMM"
        case ddMMM         = "dd MMM"
        case dMMM         = "d MMM"
        case ddMMMMyyyy     = "dd MMMM yyyy"
        case yyyyMMdd       = "yyyy-MM-dd"
        case yyyyMMddHHmm   = "yyyy-MM-dd'T'HH:mm"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case EE = "EE"
        case EEEE = "EEEE"
        case ddMMMMyyyyHHmm = "dd MMMM yyyy | HH:mm"
    }

    static func formatter(by stringFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        return formatter
    }

    static func formatter(_ format: Format) -> DateFormatter {
        return formatter(by: format.rawValue)
    }

}
