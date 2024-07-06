//
//  HomeItemsModel.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import Foundation
import UIKit


class HomeItemsModel {

    struct HomeItemsModel {
        let image: UIImage
        let text: String
        let viewController: UIViewController
    }

    var model = [HomeItemsModel]()

    func populateModel() -> [HomeItemsModel] {

        model.append(contentsOf: [HomeItemsModel(image: UIImage(named: "rocket") ?? UIImage(), text: "Lauches", viewController: UINavigationController(rootViewController: SettingsController())),
                                  HomeItemsModel(image: UIImage(named: "loading") ?? UIImage(), text: "Rockets", viewController: SettingsController()),
                                  HomeItemsModel(image: UIImage(named: "loading") ?? UIImage(), text: "Starlinik", viewController: SettingsController()),
                                  HomeItemsModel(image: UIImage(named: "loading") ?? UIImage(), text: "Crews", viewController: SettingsController())])
        
        
        
        return model
    }

    
    
}

