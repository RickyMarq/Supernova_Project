//
//  MainScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 14/02/23.
//

import UIKit
import Lottie

class MainScreen: UIView {
    
    lazy var lottieAnimation: LottieAnimationView = {
        let animation = LottieAnimationView(name: "lauchscreen.json")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundColor = .black
        animation.animationSpeed = 2
        animation.loopMode = .playOnce
        animation.contentMode = .scaleAspectFill
        return animation
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension MainScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.lottieAnimation)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.lottieAnimation.topAnchor.constraint(equalTo: self.topAnchor),
            self.lottieAnimation.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.lottieAnimation.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.lottieAnimation.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}
