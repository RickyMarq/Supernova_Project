//
//  LastLaunchesViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class LastLaunchesViewModel: ObservableObject {
    
    @State var dataObjc: [ResultedModel] = []
    @State var page = 0
    
    func getLastLaunchesData(page: Int) {
        AppleWatchService.sharedObjc.getLastLauches(limit: page) { result in
            
            switch result {
                
            case .success(let data):
                self.dataObjc.append(contentsOf: data ?? [])
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
