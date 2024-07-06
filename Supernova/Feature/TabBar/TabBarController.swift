//
//  TabBarController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }
    
    func setUpTabBar() {
        self.tabBar.isHidden = true
        self.tabBar.tintColor = .primaryColour

        let home = UINavigationController(rootViewController: HomeController())
        let settings = UINavigationController(rootViewController: SettingsController())
        
        self.setViewControllers([home, settings], animated: true)
        
        guard let items = tabBar.items else {return}
        
        items[0].image = UIImage(systemName: "house")
        items[0].title = "Home"
        
        items[1].image = UIImage(systemName: "gear")
        items[1].title = "Settings"
    }
    
}
