//
//  RocketItemViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation

protocol RocketItemViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class RocketItemViewModel {
    
    var rocket: Rocket?
    var rocketObjc: RocketModel?
    var services: RocketServices?
    weak var delegate: RocketItemViewModelProtocol?
    
    init(services: RocketServices? = nil, rocket: Rocket? = nil) {
        self.services = services
        self.rocket = rocket
    }
    
    func delegate(delegate: RocketItemViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getRocket(url: String) {
        print("DEBUG URL -> \(url)")
        services?.getRockets(url: url, completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let data):
                self.rocketObjc = data
                self.delegate?.success()
            case .failure(let error):
                print("DEBUG MODE: ERROR OCORRURED")
                delegate?.failure(error: error.localizedDescription)
            }
        })
    }
    
    var rocketURL: String {
        return rocket?.configuration.url ?? ""
    }
    
    var rocketName: String {
        return rocketObjc?.name ?? ""
    }
    
    var rocketDescription: String {
        return rocketObjc?.description ?? ""
    }
    
    var rocketCompanyName: String {
        return rocketObjc?.manufacturer.name ?? ""
    }
    
    var totalLaunch: Int {
        return rocketObjc?.total_launch_count ?? 0
    }
    
    var successfulLaunch: Int {
        return rocketObjc?.successful_launches ?? 0
    }
    
    var failedLaunch: Int {
        return rocketObjc?.failed_launches ?? 0
    }
    
    var image: String {
        return rocketObjc?.manufacturer.imageURL ?? ""
    }
    
    var rocketManufacturer: Manufacturer? {
        if let manufacturerData = rocketObjc?.manufacturer {
            return manufacturerData
        } else {
            return nil
        }
    }
    
    var wikiURL: String {
        return rocketObjc?.wiki_url ?? ""
    }
        
}
