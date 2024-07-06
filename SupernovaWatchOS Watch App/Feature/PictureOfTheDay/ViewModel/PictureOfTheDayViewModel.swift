//
//  PictureOfTheDayViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI


class PictureOfTheDayViewModel: ObservableObject {
    
    @State var dataObjc: [PictureOfTheDayModel] = []
    @State var isLoading = true
    
    func getPictureOfTheDay() {
        AppleWatchService.sharedObjc.getPictureOfTheDay { data, error in
            print(data)
print(error)
            guard let data = data else {return}
            self.dataObjc.append(data)
            self.isLoading = false
        }
    }
}
