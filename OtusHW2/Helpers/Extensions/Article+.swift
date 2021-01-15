//
//  News+.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation
import Network

extension Article: DateOrdered {
    
    var date: Date? {
        self.publishedAt
    }
    
}
