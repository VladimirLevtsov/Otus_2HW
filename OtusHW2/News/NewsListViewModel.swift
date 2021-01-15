//
//  NewsListViewModel.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import SwiftUI
import Network

protocol NewsListViewModelType: ObservableObject {
    func refreshNews(for type: NewsType)
    func fetchFeedNews()
}

final class NewsListViewModel: ObservableObject {
    
    private lazy var manager: NewsManager = APINewsManager()
    private let country: String
    private lazy var pagination = OffsetPagination(count: 10)
    private var rDateFormatter = RelativeDateFormatter()
    
    @Published private (set) var articleVMs = [ArticleViewModel]()
    @Published var isFetching: Bool = false
    private var articles = [Article]() {
        didSet {
            articleVMs = articles.map({mapArticle($0)})
        }
    }
    
    func refreshNews(for type: NewsType) {
        articles = []
        pagination.drop()
        switch type {
        case .all:
            fetchFeedNews()
        case .top:
            fetchTopNews()
        }
    }
    
    private func fetchTopNews() {
        isFetching = true
        manager.fetchTopNews(for: country) { [weak self] (result) in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case .success(let news):
                self.articles.append(contentsOf: news.articles ?? [])
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func fetchFeedNews() {
        guard !isFetching else { return }
        isFetching = true
        manager.fetchEverything(pagination: pagination) { [weak self] (result) in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case .success(let news):
                guard let articles = news.articles else { return }
                self.articles.append(contentsOf: news.articles ?? [])
                self.pagination.handle(array: articles)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    private func mapArticle(_ article: Article) -> ArticleViewModel {
        return ArticleViewModel(
                                id: article.id,
                                title: article.title ?? "",
                                published: rDateFormatter.format(date: article.publishedAt ?? Date()),
                                url: URL(string: article.urlToImage ?? ""))
    }

    init(country: String) {
        self.country = country
    }
    
    func newsDetailsViewModel(for article: ArticleViewModel) -> NewsDetailsViewModel {
        let article = articles.first(where: {$0.id == article.id})!
        
        return NewsDetailsViewModel(article: article)
    }
}

extension Article: Identifiable {
    public var id: String {
        return title ?? UUID().uuidString
    }
}

struct NewsListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
