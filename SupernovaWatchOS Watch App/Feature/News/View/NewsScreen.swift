//
//  NewsScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 28/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsScreen: View {
    
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataObjc) { datum in
                NavigationLink(destination: NewsItem(viewModel: NewsItemViewModel(data: datum))) {
                    VStack(alignment: .leading) {
                        Text(datum.title ?? "")
                            .bold()
                        
                        if let publishedAt = datum.publishedAt {
                            Text(publishedAt.convertHourNewsFormatter(datum.publishedAt ?? ""))
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
            }
            
            VStack(alignment: .center) {
                ProgressView()
                    .progressViewStyle(.circular)
                
            }
            
            .onAppear {
                viewModel.getNewsData(page: viewModel.page)
                viewModel.page += 10
            }
        }
        .navigationTitle("News")
        
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
