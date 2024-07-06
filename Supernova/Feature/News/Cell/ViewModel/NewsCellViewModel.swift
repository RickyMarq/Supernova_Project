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
    
    
//    self.newsImageView.sd_setImage(with: URL(string: data.imageURL ?? "Error"))
//    self.newsProviderLabel.text = data.newsSite
//    self.newsNameLabel.text = data.title
//    self.newsDescriptionLabel.text = data.title
//    
//    let hour = convertHourNewsFormatter(data.publishedAt ?? "")
//    let day = convertDayOfWeekFormatter(data.publishedAt ?? "")
//    let formatter = RelativeDateTimeFormatter()
//    formatter.unitsStyle = .full
//    formatter.locale = Locale.current
//    let date = formatter.localizedString(for: hour, relativeTo: Date())
//    self.newsDateLabel.text = "\(day.capitalizedSentence) • \(date)"
    
}
