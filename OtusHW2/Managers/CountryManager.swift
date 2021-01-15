//
//  CountryManager.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import Foundation

protocol CountryManager {
    func fetchCountries() -> [Country]
}

final class LocalCountryManager: CountryManager {
    
    func fetchCountries() -> [Country] {
        guard let file = Bundle.main.url(forResource: "countries.json", withExtension: nil),
              let data = try? Data(contentsOf: file),
              let cities = try? JSONDecoder().decode([Country].self, from: data)
            else {
                return []
        }
        return cities
    }
    
    func randomCity() -> Country? {
        return fetchCountries().randomElement()
    }
    
    func fetchCity(by id: String) -> Country? {
        return fetchCountries().first(where: {$0.id == id})
    }
    
}
