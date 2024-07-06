//
//  OnboardingCellViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 08/08/23.
//

import Foundation

class OnboardingCellViewModel {
    
    var onboardingData: Onboarding?
    
    init(onboardingData: Onboarding? = nil) {
        self.onboardingData = onboardingData
    }
    
    var primaryLabel: String {
        return onboardingData?.firstLabel ?? ""
    }
    
    var secondaryLabel: String {
        return onboardingData?.secondaryLabel ?? ""
    }
    
    var animationString: String {
        return onboardingData?.image ?? ""
    }
    
}
