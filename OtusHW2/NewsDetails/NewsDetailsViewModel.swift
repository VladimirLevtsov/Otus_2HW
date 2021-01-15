//
//  NewsDetailsViewModel.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation
import Network

protocol NewsDetailsViewModelType {
    
}

class NewsDetailsViewModel: NewsDetailsViewModelType, ObservableObject {
    private (set) var imageUrl: URL?
    private (set) var title: String
    private (set) var description: String
    private (set) var published: String
    private (set) var originalUrl: URL?
    private (set) var sourceName: String
    private var df = DateFormatter.formatter(.ddMMMMyyyyHHmm)
    
    init(article: Article) {
        self.imageUrl = URL(string: article.urlToImage ?? "")
        self.title = article.title ?? ""
        self.description = article.description ?? ""
        self.published = df.string(from: article.publishedAt ?? Date())
        self.originalUrl = URL(string: article.url ?? "")
        self.sourceName = article.source?.name ?? ""
    }
}
