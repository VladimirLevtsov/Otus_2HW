//
//  City.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 29.12.2020.
//

import Foundation

struct City: Decodable {
    let country: String?
    let geonameid: Int
    let name: String
    let subcountry: String?
}
