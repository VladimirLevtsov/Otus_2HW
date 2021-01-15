//
//  CountryRow.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 29.12.2020.
//

import SwiftUI

struct CountryRowViewModel: Identifiable {
    var id: String
    let cityName: String
}

struct CountryRow: View {
    let viewModel: CountryRowViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.cityName)
            Spacer()
            Image(systemName: "chevron.right")
                
        }
            .padding()
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(viewModel: CountryRowViewModel(id: "0", cityName: "test") )
            .previewLayout(.sizeThatFits)
    }
}
