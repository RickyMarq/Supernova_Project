//
//  LaunchAnimationController.swift
//  Supernova
//
//  Created by Henrique Marques on 07/07/24.
//

import UIKit

class LaunchAnimationController: UIViewController {
    
    var launchAnimationScreen: LaunchAnimationScreen?
    var wasAnimated = false
    
    override func loadView() {
        launchAnimationScreen = LaunchAnimationScreen()
        view = launchAnimationScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        launchAnimationScreen?.setUpView()
        launchAnimationScreen?.setUpConstraints()
        
        launchAnimationScreen?.animationView.play(completion: { finished in
            if finished {
                self.transitionToTabBar()
            }
        })
    }
    
    func transitionToTabBar() {
        let tabBarVC = TabBarController()
        tabBarVC.modalTransitionStyle = .crossDissolve
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
}
