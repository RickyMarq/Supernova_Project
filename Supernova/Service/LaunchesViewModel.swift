//
//  LaunchesViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/08/23.
//

import Foundation

protocol LaunchesViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class LaunchesViewModel {
    
    weak var delegate: LaunchesViewModelProtocol?
    var service = LaunchesServices()
    var futureLaunchData: LastLauchesModel?
    var resultData: [ResultedModel] = []
    var futureLaunchesNextPage: String?
    var lastLaunchData: LastLauchesModel?
    var lastResultData: [ResultedModel] = []
    var lastLaunchesNextPage: String?
    
    
    init(service: LaunchesServices) {
        self.service = service
    }
    
    func delegate(delegate: LaunchesViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getFutureLaunchesData() {
        service.getFutureLaunches { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.futureLaunchData = data
                self.futureLaunchesNextPage = futureLaunchData?.next
                self.resultData.append(contentsOf: futureLaunchData?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    func getLastLaunches() {
        service.getLastLauches { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let data):
                self.lastLaunchData = data
                self.lastLaunchesNextPage = lastLaunchData?.next
                self.lastResultData.append(contentsOf: lastLaunchData?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
            }
        }
    }
    
    var futureLaunchesCount: Int {
        return resultData.count
    }
    
    func futureLaunchesIndexPath(indexPath: IndexPath) -> ResultedModel {
        return resultData[indexPath.row]
    }
    
    var lastLaunchesCount: Int {
        return lastResultData.count
    }
    
    func lastLaunchesIndexPath(indexPath: IndexPath) -> ResultedModel {
        return lastResultData[indexPath.row]
    }
}
