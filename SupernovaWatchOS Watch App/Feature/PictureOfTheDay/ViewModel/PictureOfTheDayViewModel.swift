//
//  PictureOfTheDayViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI


class PictureOfTheDayViewModel: ObservableObject {
    
    @Published var dataObjc: [PictureOfTheDayModel] = []
    @Published var isLoading = true
    
    func getPictureOfTheDay() {
        AppleWatchService.sharedObjc.getPictureOfTheDay { data, error in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.dataObjc.append(data)
                self.isLoading = false
            }
        }
    }
}
