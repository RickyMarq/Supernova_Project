//
//  NewsItem.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 28/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsItem: View {
    
    var viewModel: NewsItemViewModel
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(viewModel.data?.title ?? "")
                        .bold()
                    
                    WebImage(url: URL(string: viewModel.data?.imageURL ?? ""))
                        .resizable()
                        .placeholder(content: {
                            Rectangle().foregroundColor(Color.gray)
                        })
                        .transition(.fade(duration: 0.5))
                    
                        .cornerRadius(10)
                        .scaledToFill()
                        .shadow(color: Color.accentColor, radius: 0.5, x: 0, y: 0.5)
                    
                    Text(viewModel.data?.summary ?? "")
                        .foregroundColor(Color.secondary)
                    
                    HStack {
                        Spacer()
                        Text(viewModel.data?.newsSite ?? "")
                            .foregroundColor(Color.primary)
                            .bold()
                            .multilineTextAlignment(.trailing)
                    }
                    .padding()
                }
            .padding(.horizontal, 5)
        }
            .navigationTitle("News")
    }
}

struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsItem(viewModel: NewsItemViewModel(data: ResultedNewsSite(id: 3, title: "Sierra Space describes long-term plans for Dream Chaser and inflatable modules", url: "", imageURL: "https://i0.wp.com/spacenews.com/wp-content/uploads/2022/05/dc-shootingstar.jpg", newsSite: "SpaceNews", summary: "WASHINGTON — As Sierra Space continues to prepare for the first flight of its Dream Chaser vehicle, it is outlining long-term ambitions for both that vehicle and space station modules", publishedAt: "")))
    }
}
