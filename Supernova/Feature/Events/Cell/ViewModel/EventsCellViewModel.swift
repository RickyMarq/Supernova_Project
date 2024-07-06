//
//  EventsCellViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation

class EventsCellViewModel {
    
    var data: ResultedEvents
    
    init(data: ResultedEvents) {
        self.data = data
    }
    
    var eventsImage: String {
        return data.featureImage ?? ""
    }
    
    var eventsName: String {
        return data.name ?? ""
    }
    
    var eventsDescription: String {
        return data.description ?? ""
    }
    
    var eventsLocation: String {
        return data.location ?? ""
    }

    var dateEvent: String {
        return convertDateEventsFormatter(data.date ?? "")
    }
    
    var dateHour: String {
        return convertDateHourEventsFormatter(data.date ?? "")
    }
    
    var webCastLive: Bool {
        return data.webcastLive ?? false
    }
}
