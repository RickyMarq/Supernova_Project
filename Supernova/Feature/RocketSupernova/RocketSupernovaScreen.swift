//
//  RocketSupernovaScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 22/06/23.
//

import UIKit

class RocketSupernovaScreen: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var rocketSupernovaContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var LaunchesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
 //       stackView.backgroundColor = .red
        return stackView
    }()
    
 // Fill, FIll Propor,equalSPacing, .
    
    lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
 //       stackView.backgroundColor = .blue
        return stackView
    }()
    
    lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var rocketManufactureLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    lazy var rocketDiameterLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var rocketMassLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    lazy var launchInformationsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RocketSupernovaScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.rocketSupernovaContentView)
        self.rocketSupernovaContentView.addSubview(self.LaunchesStackView)
        self.rocketSupernovaContentView.addSubview(self.imageStackView)
        self.LaunchesStackView.addArrangedSubview(self.rocketNameLabel)
        self.LaunchesStackView.addArrangedSubview(self.rocketManufactureLabel)
        self.LaunchesStackView.addArrangedSubview(self.rocketDiameterLabel)
        self.LaunchesStackView.addArrangedSubview(self.rocketMassLabel)
        self.imageStackView.addArrangedSubview(self.rocketImageView)
        
        self.rocketSupernovaContentView.addSubview(self.launchInformationsView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        
            self.rocketSupernovaContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.rocketSupernovaContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.rocketSupernovaContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.rocketSupernovaContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.rocketSupernovaContentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.LaunchesStackView.topAnchor.constraint(equalTo: self.rocketSupernovaContentView.topAnchor, constant: 20),
            self.LaunchesStackView.leadingAnchor.constraint(equalTo: self.rocketSupernovaContentView.leadingAnchor, constant: 15),
            self.LaunchesStackView.trailingAnchor.constraint(equalTo: self.rocketSupernovaContentView.centerXAnchor, constant: -15),
 //           self.LaunchesStackView.bottomAnchor.constraint(equalTo: self.launchInformationsView.topAnchor, constant: -20),
//            self.LaunchesStackView.bottomAnchor.constraint(equalTo: self.rocketSupernovaContentView.bottomAnchor, constant: -20),
            
            self.imageStackView.topAnchor.constraint(equalTo: self.rocketSupernovaContentView.topAnchor, constant: 20),
            self.imageStackView.leadingAnchor.constraint(equalTo: self.rocketSupernovaContentView.centerXAnchor, constant: 10),
            self.imageStackView.trailingAnchor.constraint(equalTo: self.rocketSupernovaContentView.trailingAnchor, constant: -10),
//            self.imageStackView.bottomAnchor.constraint(equalTo: self.launchInformationsView.topAnchor, constant: -20),
 //           imageStackView.bottomAnchor.constraint(equalTo: self.rocketSupernovaContentView.bottomAnchor, constant: -20),
            
            self.rocketImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7),
            
            self.launchInformationsView.topAnchor.constraint(equalTo: self.LaunchesStackView.bottomAnchor, constant: 10),
            self.launchInformationsView.leadingAnchor.constraint(equalTo: self.rocketSupernovaContentView.leadingAnchor, constant: 20),
            self.launchInformationsView.trailingAnchor.constraint(equalTo: self.rocketSupernovaContentView.trailingAnchor, constant: -20),
            self.launchInformationsView.bottomAnchor.constraint(equalTo: self.rocketSupernovaContentView.bottomAnchor, constant: -10),
            
  //          self.launchInformationsView.heightAnchor.constraint(equalToConstant: 150),
            
            
//            self.rocketImageView.topAnchor.constraint(equalTo: self.rocketSupernovaContentView.topAnchor, constant: 20),
//            self.rocketImageView.trailingAnchor.constraint(equalTo: self.rocketSupernovaContentView.trailingAnchor, constant: 10),
//            self.rocketImageView.leadingAnchor.constraint(equalTo: self.rocketSupernovaContentView.leadingAnchor, constant: -10),
//            self.rocketImageView.bottomAnchor.constraint(equalTo: self.rocketSupernovaContentView.bottomAnchor, constant: -20),

        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}
