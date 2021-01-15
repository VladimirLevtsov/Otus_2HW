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
    @State private var selectedSegment = 0
    
    var body: some View {
        let binding = Binding<Int>.init { () -> Int in
            return self.selectedSegment
        } set: { (value) in
            self.selectedSegment = value
            self.newsListViewModel.refreshNews(for: value == 0 ? .top : .all)
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
                                if newsListViewModel.articleVMs.isLast(article) && selectedSegment == 1 {
                                    newsListViewModel.fetchFeedNews()
                                }
                            }
                    }
                }
                
            }
            
            ActivityIndicator(isAnimating: $newsListViewModel.isFetching, style: .large)
                
        }
        .onAppear {
           // guard newsListViewModel.articleVMs.isEmpty else { return }
            newsListViewModel.refreshNews(for: NewsType(rawValue: selectedSegment) ?? .top)
        }
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}

