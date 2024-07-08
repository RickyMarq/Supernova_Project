//
//  NewsCellViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 18/08/23.
//

import Foundation

class NewsCellViewModel {
    
    var data: ResultedNewsSite?
    
    init(data: ResultedNewsSite? = nil) {
        self.data = data
    }
    
    var newsImage: String {
        return data?.imageURL ?? ""
    }
    
    var newsProvider: String {
        return data?.newsSite ?? ""
    }
    
    var newsTitle: String {
        return data?.title ?? ""
    }
    
    var newsSummary: String {
        return data?.summary ?? ""
    }
    
    var hour: Date {
        return convertHourNewsFormatter(data?.publishedAt ?? "")
    }
    
    var day: String {
        return convertDayOfWeekFormatter(data?.publishedAt ?? "")
    }

}
