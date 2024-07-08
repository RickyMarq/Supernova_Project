//
//  HomeViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 23/08/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class HomeViewModel {
    
    private weak var delegate: HomeViewModelProtocol?
    private var services: HomeServices?
    private var objc = [UpcomingModel]()
    private var lastLauchesObjc = [ResultedModel]()
    private var futureLauchesObjc = [ResultedModel]()
    private var nextLaunchObjc = [ResultedModel]()
    private var news = [ResultedNewsSite]()
    private var events = [ResultedEvents]()
    private var pictureOfTheDay: PictureOfTheDay?
    private var buttonsModel = HomeSectionButtonsModel().populateModel()
    private var picturesOfTheDays = [PictureOfTheDay]()
    var lastUpdated = ""
    let isOn = UserDefaults.standard.bool(forKey: "PermissionForNotification")
    
    init(services: HomeServices?) {
        self.services = services
    }
        
    func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getUpcomingLaunches() {
        services?.getPastLaunches { result in
            
            switch result {
                
            case .success(let model):
                self.objc = model ?? []
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getPictureOfTheDay() {
        services?.getPictureOfTheDay { [weak self] picture, error in
            guard let self = self else {return}
            self.pictureOfTheDay = picture
            self.delegate?.success()
        }
    }
    
    func getLastPicturesOfTheDays(limit: Int) {
        services?.getLastPicturesOfTheDays(images: limit) { [weak self] pictures in
            
            switch pictures {
                
            case .success(let model):
                guard let self = self else {return}
                self.picturesOfTheDays = model ?? []
                self.delegate?.success()
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getLastLaunches(limit: Int) {
       services?.getLastLauches(limit: limit) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let self = self else {return}
                self.lastLauchesObjc = model ?? []
                self.delegate?.success()
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getNextLaunch(limit: Int, startsAt: Int) {
        services?.getFutureLauches(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let self = self else {return}
                self.nextLaunchObjc = model ?? []
                if self.isOn == true {
                    let fullHours = convertHoursForCountDownLaunchesFormatter(self.nextLaunchObjc[0].windowStart ?? "", outPut: "HH:mm:ss")
                    let timeInterval = fullHours.timeIntervalSince(Date())
                    let convertion = Int(timeInterval)
                    let identifier = self.nextLaunchObjc[0].name
                    let notificationTrigger = convertion - 3600
                    
                    if notificationTrigger <= 0 {
                        print("Time has passed")
                    } else {
                        NotificationController.sharedObjc.requestUpcomingLaunchNotification(title: "\(self.nextLaunchObjc[0].name ?? "") is almost launching", body: "Livestream is now available to come along and watch", timeInterval: Double(notificationTrigger).rounded(), identifier: identifier ?? "Default_Identifier")
                    }
                }
                
                self.delegate?.success()
                
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getFutureLaunches(limit: Int, startsAt: Int) {
        services?.getFutureLauches(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let self = self else {return}
                self.futureLauchesObjc = model ?? []
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                let formattedHour = formatter.string(from: Date())
                
                self.lastUpdated = formattedHour
                
                self.delegate?.success()
                
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getNews(limit: Int, startsAt: Int) {
        services?.getFirstArticles(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let self = self else {return}
                self.news = model ?? []
                
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    func getLastEvents(limit: Int, startsAt: Int) {
        services?.getLastEvents(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let self = self else {return}
                self.events = model ?? []
                self.delegate?.success()
            case .failure(let error):
                guard let self = self else {return}
                self.delegate?.failure(error: error.localizedDescription)
            }
        }
    }

    // Button Count
    
    var buttonsCount: Int {
        return buttonsModel.count
    }
    
    // Next Launch Count
    
    var nextLaunchCount: Int {
        return nextLaunchObjc.count
    }
    
    // Future Launches
    
    var futureLauchesCount: Int {
        return futureLauchesObjc.count
    }
    
    //lastLauchesObjc

    var lastLaunchesCount: Int {
        return lastLauchesObjc.count
    }
      
    // News
    
    var newsCount: Int {
        return news.count
    }
    
    var eventsCount: Int {
        return events.count
    }
    
    var picturesOfTheDaysCount: Int {
        return picturesOfTheDays.count
    }
    
    // -- Item
    
    var pictureOfTheDayImage: PictureOfTheDay? {
        return pictureOfTheDay 
    }
    
    // Home Buttons
    
    func buttonsIndexPath(indexPath: IndexPath) -> HomeButtons {
        return buttonsModel[indexPath.row]
    }
 
    func nextLaunchIndexPath(indexPath: IndexPath) -> ResultedModel {
        return nextLaunchObjc[indexPath.row]
    }
    
    func futureLauchesIndexPath(indexPath: IndexPath) -> ResultedModel {
        return futureLauchesObjc[indexPath.row]
    }
    
    func lastLauchesIndexPath(indexPath: IndexPath) -> ResultedModel {
        return lastLauchesObjc[indexPath.row]
    }
    
    func newsIndexPath(indexPath: IndexPath) -> ResultedNewsSite {
        return news[indexPath.row]
    }
    
    func eventsIndexPath(indexPath: IndexPath) -> ResultedEvents {
        return events[indexPath.row]
    }
    
    func picturesOfTheDays(indexPath: IndexPath) -> PictureOfTheDay {
        return picturesOfTheDays[indexPath.row]
    }
    
}
