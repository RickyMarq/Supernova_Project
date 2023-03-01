//
//  OnboardingModel.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import Foundation

class OnboardingModel {
    
    struct Onboarding {
        let wavingAnimation: String
        let image: String
        let firstLabel: String
        let secondaryLabel: String
    }
    
    var model = [Onboarding]()
    
    
    func populateModel() -> [Onboarding] {
        model.append(contentsOf: [Onboarding(wavingAnimation: "stars.json", image: "hello.json", firstLabel: "Hey, Hello", secondaryLabel: "Thanks for downloading my app"),
                                  Onboarding(wavingAnimation: "stars.json", image: "", firstLabel: "Welcome to Supernova", secondaryLabel: "Here you can find all the informations about rocket lauches and everyting else."),
                                 Onboarding(wavingAnimation: "stars.json", image: "rocket.json", firstLabel: "So, let's start?", secondaryLabel: "Hit begin")])
        
        
        return model
        
    }
    
    
}
