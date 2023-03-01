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
        tabBar.tintColor = .primaryColour
        let home = UINavigationController(rootViewController: HomeController())
        let settings = UINavigationController(rootViewController: SettingsController())
        
        let explore = UINavigationController(rootViewController: SectionController())
        let news = UINavigationController(rootViewController: NewsController())
        
        let onboarding = UINavigationController(rootViewController: OnboardingController())
        
        self.setViewControllers([home, onboarding, settings], animated: true)
        
        guard let items = tabBar.items else {return}
        
        items[0].image = UIImage(systemName: "house")
        items[0].title = "Home"
        
        items[1].image = UIImage(systemName: "bolt")
        items[1].title = "Onboarding"
        
//        items[2].image = UIImage(systemName: "newspaper")
//        items[2].title = "News"
        
        items[2].image = UIImage(systemName: "gear")
        items[2].title = "Settings"
    }
    
}
