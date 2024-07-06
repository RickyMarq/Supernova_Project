//
//  NewsItemViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation

class NewsItemViewModel: ObservableObject {
    
    var data: ResultedNewsSite?
    
    init(data: ResultedNewsSite? = nil) {
        self.data = data
    }
    

}
