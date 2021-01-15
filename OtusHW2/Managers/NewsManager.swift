//
//  ForecastManager.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import Foundation
import Network

enum NewsManagerError: Error {
    case network
}

protocol NewsManager {
    func fetchTopNews(for country: String, completion: @escaping (_ result: Result<News, NewsManagerError>) -> Void)
    func fetchEverything(pagination: OffsetPagination, completion: @escaping (_ result: Result<News, NewsManagerError>) -> Void)
}

class APINewsManager: NewsManager {
    func fetchTopNews(for country: String, completion: @escaping (_ result: Result<News, NewsManagerError>) -> Void) {
        MainAPI.topNews(country: country, apiKey: "18c080256ab94ca89662dbf2b6e0c1d3") { (news, error) in
            if error != nil {
                completion(.failure(.network))
            } else if let news = news {
                completion(.success(news))
            }
        }
    }
    
    func fetchEverything(pagination: OffsetPagination, completion: @escaping (Result<News, NewsManagerError>) -> Void) {
        let date = Date(timeIntervalSince1970: TimeInterval(pagination.earliestTimestamp))
        MainAPI.everything(q: "apple",
                           apiKey: "18c080256ab94ca89662dbf2b6e0c1d3",
                           pageSize: pagination.count,
                           from: "2021-01-01",
                           to: DateFormatter.formatter(.yyyyMMddHHmmss).string(from: date.addingTimeInterval(-10)),
                           sortBy: "publishedAt" ) { (news, error) in
            if error != nil {
                DateFormatter().locale = nil
                completion(.failure(.network))
            } else if let news = news {
                completion(.success(news))
            }
        }
    }
    
}
