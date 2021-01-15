//
//  NewsDetailsView.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import SwiftUI
import AsyncImage
import UIComponents

struct NewsDetailsView: View {
    @EnvironmentObject var viewModel: NewsDetailsViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AsyncImage(url: viewModel.imageUrl,
                               placeholder: { ActivityIndicator(isAnimating: .constant(true), style: .medium) },
                               image: { Image(uiImage: $0).resizable()}
                    )
                        .frame(idealHeight: UIScreen.main.bounds.width)
                        .aspectRatio(contentMode: .fit)
                    
                    Text(viewModel.title)
                        .font(.title)
                        .padding(.all)
                    Divider()
                    Text(viewModel.description)
                        .padding(.all)
                    HStack {
                        Text(viewModel.published)
                        Spacer()
                        VStack {
                            Text(viewModel.sourceName)
                            if let url = viewModel.originalUrl {
                                Link("Источник", destination: url)
                            }
                        }
                    }
                    .padding(.all)
                }
            }
        }
    }
}

struct NewsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailsView()
    }
}
