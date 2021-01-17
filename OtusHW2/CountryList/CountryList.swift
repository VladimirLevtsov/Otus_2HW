//
//  CountryList.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 29.12.2020.
//

import SwiftUI
import UIComponents

struct CountryList: View {
    private var vm: CountryListViewModelType = CountryListViewModel()
    
    var body: some View {
        List(vm.getCountryVMList()) { countryVM in
            CustomNavigationLink(destination: NewsListView()
                                                        .environmentObject(NewsListViewModel(country: countryVM.id))) {
                CountryRow(viewModel: countryVM)
            }
        }
    }
}

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList()
    }
}
