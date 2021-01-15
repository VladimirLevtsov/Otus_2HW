//
//  NewsType.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import Foundation

enum NewsType: Int, CaseIterable, Identifiable {
    var id: Int {
        return rawValue
    }
    
    case top
    case all
    
    var strRepr: String {
        switch self {
        case .all: return "Everything"
        case .top: return "Top News"
        }
    }
}
