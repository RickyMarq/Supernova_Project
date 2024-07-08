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
        setUpTabBar()
        configTabBar()
    }
    
    func setUpTabBar() {
        
        let home: UINavigationController = {
            let vc = HomeController()
            let nv = UINavigationController(rootViewController: vc)
            nv.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            nv.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
            return nv
        }()
        
        let settings: UINavigationController = {
            let vc = SettingsController()
            let nv = UINavigationController(rootViewController: vc)
            nv.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 1)
            nv.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
            return nv
        }()
        
        viewControllers = [home, settings]
    }
    
    
    func configTabBar() {
        tabBar.tintColor = .primaryColour
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.black.cgColor
    }
}
