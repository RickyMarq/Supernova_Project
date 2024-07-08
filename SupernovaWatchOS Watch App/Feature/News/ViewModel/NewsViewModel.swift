//
//  NewsViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    
    @Published var dataObjc: [ResultedNewsSite] = []
    @Published var isLoaded = true
    @Published var page = 1
    
    func getNewsData(page: Int) {
        AppleWatchService.sharedObjc.getFirstArticles(page: page) { result in
            
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self.dataObjc.append(contentsOf: data ?? [])
                    self.isLoaded = true
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
}
