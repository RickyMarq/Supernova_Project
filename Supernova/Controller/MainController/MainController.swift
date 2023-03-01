//
//  MainController.swift
//  Supernova
//
//  Created by Henrique Marques on 14/02/23.
//

import UIKit

class MainController: UIViewController {
    
    var mainScreen: MainScreen?
    
    override func loadView() {
        self.mainScreen = MainScreen()
        self.view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLauchscreenAnimation()
    }
    
    func showLauchscreenAnimation() {
        self.mainScreen?.lottieAnimation.play { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.mainScreen?.lottieAnimation.alpha = 0
            }, completion: { _ in
                self.mainScreen?.lottieAnimation.isHidden = true
                self.mainScreen?.lottieAnimation.removeFromSuperview()
            })
        }
    }
}
