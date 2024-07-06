//
//  UIDate+Extension.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 06/07/24.
//

import Foundation
    
func convertHoursForCountDownLaunchesFormatter(_ date: String, outPut: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.timeZone =  TimeZone.current
    let location = Locale.current
    dateFormatter.locale = Locale(identifier: location.identifier)
    let convertedDate = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
        assert(false, "no date from string")
        return Date()
    }
    
    dateFormatter.dateFormat = outPut
    dateFormatter.timeZone = TimeZone.current
    return convertedDate ?? Date()
}
    
