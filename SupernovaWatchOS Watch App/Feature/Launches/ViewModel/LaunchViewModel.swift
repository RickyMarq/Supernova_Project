//
//  LaunchViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class LaunchViewModel: ObservableObject {
    
    @State var objcData: [ResultedModel] = []
    @State var page = 0
    
    func getLaunchData(page: Int) {
        AppleWatchService.sharedObjc.getFutureLauches(limit: 5, startsAt: page) { result in
            
            switch result {
                
            case .success(let data):
                self.objcData.append(contentsOf: data ?? [])
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            }
        }
    }
}
