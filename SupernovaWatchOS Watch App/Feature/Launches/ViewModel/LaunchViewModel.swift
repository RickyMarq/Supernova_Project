//
//  LaunchViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class LaunchViewModel: ObservableObject {
    
    @Published var objcData: [ResultedModel] = []
    @Published var page = 0
    
    func getLaunchData(page: Int) {
        AppleWatchService.sharedObjc.getFutureLauches(limit: 5, startsAt: page) { result in
            
            switch result {
                
            case .success(let data):

                DispatchQueue.main.async {
                    self.objcData.append(contentsOf: data ?? [])
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
}
