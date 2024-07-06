//
//  EventsItemViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 17/08/23.
//

import Foundation

protocol EventsItemViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class EventsItemViewModel {
    
    var events: ResultedEvents?
    weak var delegate: EventsItemViewModelProtocol?
    
    init(events: ResultedEvents? = nil) {
        self.events = events
    }
    
    func delegate(delegate: EventsItemViewModelProtocol) {
        self.delegate = delegate
    }
    
    var rocket: Rocket? {
        return events?.launches[0].rocket ?? nil
    }
    
    var videoURL: String {
        return events?.videoURL ?? ""
    }
    
    var eventID: Int {
        return events?.id ?? 0
    }
    
    var eventName: String {
        return events?.name ?? ""
    }
    
    var eventDescription: String {
        return events?.description ?? ""
    }
    
    var eventsImage: String {
        return events?.featureImage ?? ""
    }
    
    var eventsLocation: String {
        return events?.location ?? ""
    }
    
    var eventsDate: String {
        return events?.date ?? ""
    }
    
    // --
    
    var launchesData: [Launch]? {
        return events?.launches ?? []
    }
    
    var latitude: String {
        return events?.launches[0].pad.latitude ?? ""
    }
    
    var longitude: String {
        return events?.launches[0].pad.longitude ?? ""
    }
    
    var rocketName: String {
        return events?.launches[0].rocket.configuration.name ?? ""
    }
    
    var missionName: String {
        return events?.launches[0].mission?.name ?? ""
    }
    
    var padName: String {
        return events?.launches[0].pad.name ?? ""
    }
    
    var padLocation: String {
        return events?.launches[0].pad.location.name ?? ""
    }
    
    var padID: Int {
        return events?.launches[0].pad.agencyID ?? 0
    }
    
    var padLaunchCount: Int {
        return events?.launches[0].pad.launchCount ?? 0
    }
    
    var missionDescription: String {
        return events?.launches[0].mission?.description ?? ""
    }
    
    var missionImage: String {
        return events?.featureImage ?? ""
    }
    
    
//    self.titleMissionLabel.text = events?.launches[0].mission?.name
//    self.padNameLabel.text = events?.launches[0].pad.name
//    self.padLocation.text = "Location: \(events?.launches[0].pad.location.name ?? "Not Found")"
//    self.padId.text = "#\(events?.launches[0].pad.agencyID ?? 0)"
//    self.launchCountInt.text = "\(events?.launches[0].pad.launchCount ?? 0)"
    
    
//    self.missionDescription.text = events?.launches[0].mission?.description
//    self.eventsImageView.sd_setImage(with: URL(string: events?.featureImage ?? ""))
}
