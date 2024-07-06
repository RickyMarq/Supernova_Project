//
//  NewsViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    
    @State var dataObjc: [ResultedNewsSite] = []
    @State var isLoaded = true
    @State var page = 1
    
    func getNewsData(page: Int) {
        AppleWatchService.sharedObjc.getFirstArticles(page: page) { result in
            
            switch result {
                
            case .success(let data):
                self.dataObjc.append(contentsOf: data ?? [])
                self.isLoaded = false
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
}
