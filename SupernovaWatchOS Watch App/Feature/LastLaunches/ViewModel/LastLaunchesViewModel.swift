//
//  LastLaunchesViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class LastLaunchesViewModel: ObservableObject {
    
    @Published var dataObjc: [ResultedModel] = []
    @Published var page = 0
    
    func getLastLaunchesData(page: Int) {
        AppleWatchService.sharedObjc.getLastLauches(limit: page) { result in
            
            switch result {
                
            case .success(let data):

                DispatchQueue.main.async {
                    self.dataObjc.append(contentsOf: data ?? [])
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
