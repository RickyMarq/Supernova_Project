//
//  LaunchItemViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 15/08/23.
//

import Foundation

protocol LaunchingItemViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class LaunchingItemViewModel {
    
    weak var delegate: LaunchingItemViewModelProtocol?
    var launches: ResultedModel
    var youtubeModel: [ItemYT] = []


    init(launches: ResultedModel) {
        self.launches = launches
    }
    
    func delegate(delegate: LaunchingItemViewModelProtocol) {
        self.delegate = delegate
    }
    
    // -- Data --
        
    var windowStartLaunch: String {
        return launches.windowStart ?? ""
    }
    
    // -- Player --
    
    func getVideo(nameOfLaunch: String) {
        YoutubeInternetServices.sharedObjc.getVideosByName(name: nameOfLaunch) { [weak self] result in
            guard let strongSelf = self else {return}

            switch result {
            case .success(let model):
                strongSelf.youtubeModel.append(contentsOf: model ?? [])
                print("DEBUG MODE \(model?[0].id?.videoID)")
                strongSelf.delegate?.success()
            case .failure(let error):
                strongSelf.delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    var videoID: String {
        return youtubeModel[0].id?.videoID ?? ""
    }
    
    // -- Config Data --
    
    var launchName: String {
        return launches.name ?? ""
    }
    
    var launchID: Int {
        return launches.rocket?.id ?? 0
    }
    
    var rocketDescription: String {
        return launches.mission?.description ?? ""
    }
    
    var rocketImage: String {
        return launches.image ?? ""
    }
    
    var rocketConfigName: String {
        return launches.rocket?.configuration.name ?? ""
    }
    

    // -- Launch Data --
    
    var totalLaunch: Int {
        return launches.orbitalLaunchAttemptCount ?? 0
    }
    
    var successfulLaunch: Int {
        return launches.padLaunchAttemptCount ?? 0
    }
    
    var failedLaunch: Int {
        return launches.locationLaunchAttemptCount ?? 0
    }

    // -- Pad --
    
    var padName: String {
        return launches.pad?.name ?? ""
    }
    
    var padLocation: String {
        return launches.pad?.location.name ?? ""
    }
    
    // -- Mission --
    
    var missionName: String {
        return launches.mission?.name ?? ""
    }
    
    var missionDescription: String {
        return launches.mission?.description ?? ""
    }
    
    // -- Map --
    
    var latitude: String {
        return launches.pad?.latitude ?? ""
    }
    
    var longitude: String {
        return launches.pad?.longitude ?? ""
    }
        
}
