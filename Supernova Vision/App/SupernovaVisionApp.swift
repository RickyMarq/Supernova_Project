//
//  SupernovaVisionApp.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 07/11/23.
//

import SwiftUI

@main
struct SupernovaVisionApp: App {
    
    @State var model = ViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(model)
        }
        
        WindowGroup(id: "pictureOfDayDetails") {
            PictureDetails()
        }
        .defaultSize(width: 100, height: 500)
        .windowResizability(.contentSize)
        
        WindowGroup(id: "ImmersiveRocketSpace") {
            Rocket()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
    }
}
