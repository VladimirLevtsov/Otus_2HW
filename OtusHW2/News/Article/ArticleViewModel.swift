//
//  ArticleViewModel.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 15.01.2021.
//

import Foundation

struct ArticleViewModel: Identifiable {
    var id: String
    let title: String
    let published: String
    let url: URL?
}
