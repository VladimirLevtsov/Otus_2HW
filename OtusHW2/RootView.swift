//
//  ContentView.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 28.12.2020.
//

import SwiftUI
import UIComponents

struct RootView: View {
    var body: some View {
        CustomNavigationView(title: "News") {
            CountryList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
