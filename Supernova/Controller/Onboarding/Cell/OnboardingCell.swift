//
//  OnboardingCell.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import UIKit
import Lottie

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    lazy var onBoardingAnimationView: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill
        animationView.tintColor = .systemPurple
        animationView.play()
        return animationView
    }()
    
    lazy var onBoardingAnimation: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.tintColor = .systemPurple
        animationView.play()
        return animationView
    }()
    
    lazy var OnboardingPrimaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy var OnboardingSecondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension OnboardingCell: ViewCode {
 
    func configureSubViews() {
//        self.addSubview(self.onBoardingAnimationView)
        self.addSubview(self.onBoardingAnimation)
        self.addSubview(self.OnboardingPrimaryLabel)
        self.addSubview(self.OnboardingSecondaryLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
//            self.onBoardingAnimationView.topAnchor.constraint(equalTo: onBoardingAnimation.topAnchor),
//            self.onBoardingAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.onBoardingAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            self.onBoardingAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.onBoardingAnimationView.heightAnchor.constraint(equalToConstant: 300),

            
            self.onBoardingAnimation.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
//            self.onBoardingAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            self.onBoardingAnimation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.onBoardingAnimation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.onBoardingAnimation.heightAnchor.constraint(equalToConstant: 250),
            
            self.OnboardingPrimaryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.OnboardingPrimaryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.OnboardingPrimaryLabel.topAnchor.constraint(equalTo: self.onBoardingAnimation.bottomAnchor, constant: 50),
        
            self.OnboardingSecondaryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.OnboardingSecondaryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.OnboardingSecondaryLabel.topAnchor.constraint(equalTo: self.OnboardingPrimaryLabel.bottomAnchor, constant: 12),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .backgroundColour
    }
    
    func configureAccessibility() {
        
    }
    
    
}
