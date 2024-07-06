//
//  LaunchesCellViewModel.swift.swift
//  Supernova
//
//  Created by Henrique Marques on 06/11/23.
//

import Foundation
 
class LaunchesCellViewModel {
    
    var data: ResultedModel?
    
    init(data: ResultedModel? = nil) {
        self.data = data
    }
    
    var launchName: String {
        return data?.name ?? ""
    }
    
    var companyName: String {
        return "Company: \(data?.launchServiceProvider?.name ?? "")"
    }
    
    var launchImage: String {
        return data?.image ?? ""
    }
    
    var formatedDate: String {
        return convertDateLaunchesFormatter(data?.windowStart ?? "")
    }
    
    var formatedHour: String {
        return convertHourLaunchesFormatter(data?.windowStart ?? "", outPut: "HH:mm zzz")
    }
    
    var launchLive: Bool {
        return data?.webcastLive ?? false
    }
}
