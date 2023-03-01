//
//  OnboardingViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import Foundation

protocol OnboardingViewModelProtocols: AnyObject {
    func success()
    func failure()
}

class OnboardingViewModel {

    var model = OnboardingModel().populateModel()
    weak var delegate: OnboardingViewModelProtocols?

    init(delegate: OnboardingViewModelProtocols? = nil) {
        self.delegate = delegate
    }
    
    func getData() {
        
        
    }
    
    var count: Int {
        return model.count
    }
    
}
