//
//  ArticleRowView.swift
//  OtusHW2
//
//  Created by VLADIMIR LEVTSOV on 14.01.2021.
//

import SwiftUI
import AsyncImage
import UIComponents

struct ArticleRowView: View {
    let viewModel: ArticleViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                AsyncImage(url: viewModel.url, placeholder: { ActivityIndicator(isAnimating: .constant(true), style: .medium) }, image: { Image(uiImage: $0).resizable() })
                    .frame(width: 50, height: 50, alignment: .center)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2))
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.title)
                    Text(viewModel.published)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
            
        }
        .padding()
    }
}

struct NewsListRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(viewModel: ArticleViewModel(id: "0", title: "test", published: "yesterday", url: nil) )
            .previewLayout(.sizeThatFits)
    }
}
