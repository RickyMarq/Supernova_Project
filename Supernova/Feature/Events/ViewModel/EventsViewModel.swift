//
//  EventsViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation

protocol EventsViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class EventViewModel {
    
    var service: EventsServices?
    weak var delegate: EventsViewModelProtocol?
    var eventsData: [ResultedEvents] = []
    var eventsHomeData: LastEventsModel?
    var nextPage: String?

    
    init(service: EventsServices? = nil) {
        self.service = service
    }
    
    func delegate(delegate: EventsViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getEventsData() {
        service?.getEvents(completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let data):
                self.eventsHomeData = data
                self.nextPage = eventsHomeData?.name
                self.eventsData.append(contentsOf: eventsHomeData?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
                
            }
        })
    }
    
    var count: Int {
        return eventsData.count
    }
    
    func indexPath(indexPath: IndexPath) -> ResultedEvents {
        return eventsData[indexPath.row]
    }
}
