//
//  OnboardingViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import Foundation

class OnboardingViewModel {

    var onboardingModel: [Onboarding] = []
    
    func populateModel() {
        
        onboardingModel.append(contentsOf:
                        
        [Onboarding(wavingAnimation: "stars.json", image: "rocket.json", firstLabel: "Welcome to Supernova", secondaryLabel: "Here you can find all the informations about rocket launches and spacial events."),

        Onboarding(wavingAnimation: "news.json", image: "news.json", firstLabel: "Stay up to date with news", secondaryLabel: "Stay up to launches, events and all"),
        
        Onboarding(wavingAnimation: "", image: "notifications.json", firstLabel: "Can we send you notifications ?", secondaryLabel: "We use it to warn you when a next launch is ready to start"),
        
        Onboarding(wavingAnimation: "stars.json", image: "79912-white-rocket.json", firstLabel: "Let's begin ?", secondaryLabel: "Hit the begin button to start")
        
        ])
    }
    
    var count: Int {
        return onboardingModel.count
    }
    
    func indexPath(indexPath: IndexPath) -> Onboarding {
        return onboardingModel[indexPath.row]
    }
    
}
