//
//  HomeViewModel.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 05/07/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @State var dataObjc: [PictureOfTheDayModel] = []
    
    @State var data: [HomeData] = [
        
        HomeData(name: "Launches", symbol: "mappin.and.ellipse", img: "", Screen: AnyView(LaunchesScreen())),
    
        HomeData(name: "Last Launches", symbol: "sparkles", img: "", Screen: AnyView(LastLaunchesScreen())),
        
        HomeData(name: "News", symbol: "newspaper", img: "", Screen: AnyView(NewsScreen())),
        
        HomeData(name: "Picture of The Day", symbol: "moon.stars", img: "IssMoon_Yang_960", Screen: AnyView(PictureOfTheDay(data: PictureOfTheDayModel(date: "", explanation: "", title: "", url: "", hdurl: ""))))]
}
