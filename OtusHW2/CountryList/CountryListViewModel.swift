//
//  CountryListViewModel.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation

protocol CountryListViewModelType {
    func getCountryVMList() -> [CountryRowViewModel]
}

class CountryListViewModel: CountryListViewModelType {
    private lazy var manager: CountryManager = LocalCountryManager()
    
    func getCountryVMList() -> [CountryRowViewModel] {
        let countries = manager.fetchCountries()
        return countries.map({ CountryRowViewModel(
                                id: $0.id,
                                cityName: $0.name)
                            })
        
    }
    
}
