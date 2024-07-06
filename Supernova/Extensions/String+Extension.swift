//
//  String+Extension.swift
//  Supernova
//
//  Created by Henrique Marques on 07/03/23.
//

import Foundation
import UIKit

extension String {
    
    static let appVersion = "Version 2.1.1"
       
    var capitalizedSentence: String {
            let firstLetter = self.prefix(1).capitalized
            let remainingLetters = self.dropFirst().lowercased()
            return firstLetter + remainingLetters
        }

 
}


func convertDateFormatter(_ date: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
       dateFormatter.timeZone =  TimeZone.current
       dateFormatter.locale = Locale(identifier: "pt-BR")
       let convertedDate = dateFormatter.date(from: date)

       guard dateFormatter.date(from: date) != nil else {
             assert(false, "no date from string")
           return ""
       }
       dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
       dateFormatter.timeZone = TimeZone.current
       let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
       return timeStamp
   }

func convertDayOfWeekFormatter(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormatter.timeZone =  TimeZone.current
    let location = Locale.current
    dateFormatter.locale = Locale(identifier: location.identifier)
    
    guard let convertedDate = dateFormatter.date(from: date) else {
        print("Invalid date format: \(date)")
        return ""
    }
    
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.timeZone = TimeZone.current
    
    let timeStamp = dateFormatter.string(from: convertedDate)
    return timeStamp
}

func convertHourNewsFormatter(_ date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormatter.timeZone =  TimeZone.current
    dateFormatter.locale = Locale(identifier: "pt-BR")
    let convertedDate = dateFormatter.date(from: date)
    
    if convertedDate == nil {
        print("Invalid date format, setting default value.")
        return Date()
    }
    
    dateFormatter.dateFormat = "dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return convertedDate ?? Date()
}

func convertDateToDayFormatter(_ date: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm':00Z'"
       dateFormatter.timeZone =  TimeZone.current
       dateFormatter.locale = Locale(identifier: "pt-BR")
       let convertedDate = dateFormatter.date(from: date)

       guard dateFormatter.date(from: date) != nil else {
           assert(false, "no date from string")
           return ""
       } 
       dateFormatter.dateFormat = "dd"
       dateFormatter.timeZone = TimeZone.current
       let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
       return timeStamp
   }

func convertDateToMonthFormatter(_ date: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm':00Z'"
       dateFormatter.timeZone =  TimeZone.current
       dateFormatter.locale = Locale(identifier: "en_us")
       let convertedDate = dateFormatter.date(from: date)

       guard dateFormatter.date(from: date) != nil else {
           assert(false, "no date from string")
           return ""
       }

       dateFormatter.dateFormat = "MMM"
       dateFormatter.timeZone = TimeZone.current
       let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
       return timeStamp
   }

func convertDateEventsFormatter(_ date: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm':00Z'"
       dateFormatter.timeZone =  TimeZone.current
       let location = Locale.current
       dateFormatter.locale = Locale(identifier: location.identifier)
 
    guard let convertedDate = dateFormatter.date(from: date) else {
          print("Invalid date format: \(date)")
          return ""
      }
  
       dateFormatter.dateFormat = "MMMM dd, yyyy"
       dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: convertedDate)
        return timeStamp
   }

func convertHourEventsFormatter(_ date: String) -> Date {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
       dateFormatter.timeZone =  TimeZone.current
       dateFormatter.locale = Locale(identifier: "en_us")
       let convertedDate = dateFormatter.date(from: date)

       guard dateFormatter.date(from: date) != nil else {
             assert(false, "no date from string")
           return Date()
       }

       dateFormatter.dateFormat = "HH:mm"
       dateFormatter.timeZone = TimeZone.current
       return convertedDate ?? Date()
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
    
    dateFormatter.dateFormat = outPut
    dateFormatter.timeZone = TimeZone.current
    let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
    return timeStamp
}

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

func convertDateHourEventsFormatter(_ date: String) -> String {
    let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let outputDateFormat = "HH:mm"

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputDateFormat
    dateFormatter.timeZone = TimeZone.current
    let location = Locale.current
    dateFormatter.locale = Locale(identifier: location.identifier)
    
    guard let convertedDate = dateFormatter.date(from: date) else {
        print("Invalid date format, setting default value.")
        return ""
    }
    
    dateFormatter.dateFormat = outputDateFormat
    let formattedTime = dateFormatter.string(from: convertedDate)
    return formattedTime
}
