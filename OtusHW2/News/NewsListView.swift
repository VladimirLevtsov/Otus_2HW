//
//  NewsListView.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 29.12.2020.
//

import SwiftUI
import UIComponents
import Combine

struct NewsListView: View {
    @EnvironmentObject var newsListViewModel: NewsListViewModel
    
    var body: some View {
        let binding = Binding<Int>.init { () -> Int in
            return self.newsListViewModel.currentFilter.rawValue
        } set: { (value) in
            self.newsListViewModel.currentFilter = NewsType(rawValue: value) ?? .top
        }

        ZStack {
            VStack {
                Picker("", selection: binding) {
                    ForEach(NewsType.allCases) { type in
                        Text(type.strRepr).tag(type.rawValue)
                    }
                }
                
                .pickerStyle(SegmentedPickerStyle())
                
                List(newsListViewModel.articleVMs) { article in
                    CustomNavigationLink(destination: NewsDetailsView()
                                            .environmentObject(newsListViewModel.newsDetailsViewModel(for: article) )
                    ) {
                        ArticleRowView(viewModel: article)
                            .onAppear {
                                if newsListViewModel.articleVMs.isLast(article) && newsListViewModel.currentFilter == .all {
                                    newsListViewModel.fetchFeedNews()
                                }
                            }
                    }
                }
                
            }
            
            ActivityIndicator(isAnimating: $newsListViewModel.isFetching, style: .large)
                
        }
        .onAppear {
            if newsListViewModel.articleVMs.isEmpty {
                newsListViewModel.refreshNews()
            }
            
        }
        
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}

