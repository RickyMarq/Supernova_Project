//
//  NewsScreen.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 28/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsScreen: View {
    
    @State var dataObjc: [ResultedNewsSite] = []
    @State var isLoaded = true
    @State var page = 1
    
    var body: some View {
            List {
                ForEach(dataObjc) { datum in
                    NavigationLink(destination: NewsItem(data: datum)) {
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
                    getNewsData(page: page)
                    page += 10
                    print("DEBUG MODE PAGE: \(page)")
                }
            }
//            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("News")

    }
    
    
    func getNewsData(page: Int) {
        AppleWatchService.sharedObjc.getFirstArticles(page: page) { result in
            
            switch result {
                
            case .success(let data):
                dataObjc.append(contentsOf: data ?? [])
                isLoaded = false
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
