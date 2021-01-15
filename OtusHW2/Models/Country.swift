//
//  Country.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let capital: String
    let population: Int
    let area: Double?
    let latlng: [Double]
    let alpha2Code: String
}

extension Country {
    var id: String {
        return alpha2Code.lowercased()
    }
}
