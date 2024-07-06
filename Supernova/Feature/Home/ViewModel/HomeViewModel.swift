//
//  HomeViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 23/08/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    var services: HomeServices?
    
    init(services: HomeServices?) {
        self.services = services
    }
        
    func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
}
