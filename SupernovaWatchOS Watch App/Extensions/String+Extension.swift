//
//  String+Extension.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 28/06/23.
//

import Foundation
import SwiftUI

extension String {
    
    func convertHourNewsFormatter(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone.current
        let location = Locale.current
        dateFormatter.locale = Locale(identifier: location.identifier)
        let convertedDate = dateFormatter.date(from: date)

        if convertedDate == nil {
            print("Invalid date format, setting default value.")
            return "" // Return an empty string as default value
        }

        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        let formattedDate = dateFormatter.string(from: convertedDate!)

        return formattedDate
    }
    
    func convertDateLaunchesFormatter(_ date: String) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           dateFormatter.timeZone =  TimeZone.current
           dateFormatter.locale = Locale(identifier: "en_us")
           let convertedDate = dateFormatter.date(from: date)

           guard dateFormatter.date(from: date) != nil else {
               assert(false, "no date from string")
               return ""
           }
           dateFormatter.dateFormat = "MMMM dd"
           dateFormatter.timeZone = TimeZone.current
           let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
           return timeStamp
       }
    
    func convertHourLaunchesFormatter(_ date: String, outPut: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone =  TimeZone.current
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        /// This is what you want to convert format
        dateFormatter.dateFormat = outPut
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
        return timeStamp
    }
    
}


