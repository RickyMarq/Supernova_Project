//
//  ViewModel.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 26/01/24.
//

import SwiftUI

@Observable
class ViewModel {
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Hello World"
    
    // Picture of the Day
    
    var isShowingInfo: Bool = false
    var infoTitle: String = "Show info"

    var data = [
        itemsModel(name: "Rocket Launches", icon: "sparkles", view: AnyView(Launch()), children: [itemsModel(name: "Upcoming Launches", icon: "fireworks", view: AnyView(UpcomingLaunches())), itemsModel(name: "Past Launches", icon: "house", view: AnyView(UpcomingLaunches()))]),
        itemsModel(name: "Picture of the day", icon: "photo.on.rectangle", view: AnyView(PictureDay(pictureOfTheDay: PictureOfTheDay(date: "", explanation: "", title: "", url: "")))),
        itemsModel(name: "Nasa Observatory", icon: "moon.haze", view: AnyView(NasaObservatory()))
    ]
}
