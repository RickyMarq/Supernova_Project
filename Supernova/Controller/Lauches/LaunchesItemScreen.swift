//
//  LauchesScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit
import SkeletonView

protocol LaunchesItemScreenProtocols: AnyObject {
    func rocketButtonAction()
}

class LaunchesItemScreen: UIView {
    
    weak var delegate: LaunchesItemScreenProtocols?
    
    func delegate(delegate: LaunchesItemScreenProtocols) {
        self.delegate = delegate
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var LaunchesItemContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var LaunchesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "#"
        return label
    }()
    
    lazy var launchNameLabel: UILabel = {
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
    
    lazy var rocketDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 4
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.roundCorners(.allCorners, radius: 10)
        return imageView
    }()
    
    // --
    
    lazy var rocketUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    lazy var labelRocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var rocketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(rocketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // ---
    
    lazy var launchInformationViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var launchInformationsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var totalLaunchesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.text = "Orbital Launch Count"
        return label
    }()
    
    lazy var totalLaunchesIntLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    lazy var failedLaunchesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.text = "Pad Launch Count"
        return label
    }()
    
    lazy var failedLaunchesIntLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    lazy var successLaunchesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.text = "Agency Launch Count"
        return label
    }()
    
    lazy var successLaunchesIntLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    @objc func rocketButtonTapped() {
        self.delegate?.rocketButtonAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LaunchesItemScreen: ViewCode {
  
    func configureSubViews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.LaunchesItemContentView)
        self.LaunchesItemContentView.addSubview(self.LaunchesStackView)
        self.LaunchesStackView.addArrangedSubview(self.idLabel)
        self.LaunchesStackView.addArrangedSubview(self.launchNameLabel)
        self.LaunchesStackView.addArrangedSubview(self.rocketDescriptionLabel)
        self.LaunchesStackView.addArrangedSubview(self.rocketImageView)
        self.LaunchesStackView.addArrangedSubview(self.rocketUIView)
        self.rocketUIView.addSubview(self.chevronImageView)
        self.rocketUIView.addSubview(self.labelRocketNameLabel)
        self.rocketUIView.addSubview(self.rocketButton)

        
        // --
        
        self.LaunchesStackView.addArrangedSubview(self.launchInformationsView)
        self.launchInformationsView.addSubview(self.totalLaunchesLabel)
        self.launchInformationsView.addSubview(self.totalLaunchesIntLabel)
        self.launchInformationsView.addSubview(self.successLaunchesLabel)
        self.launchInformationsView.addSubview(self.successLaunchesIntLabel)
        self.launchInformationsView.addSubview(self.failedLaunchesLabel)
        self.launchInformationsView.addSubview(self.failedLaunchesIntLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        
            self.LaunchesItemContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.LaunchesItemContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.LaunchesItemContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.LaunchesItemContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.LaunchesItemContentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.LaunchesStackView.topAnchor.constraint(equalTo: self.LaunchesItemContentView.topAnchor, constant: 20),
            self.LaunchesStackView.leadingAnchor.constraint(equalTo: self.LaunchesItemContentView.leadingAnchor, constant: 20),
            self.LaunchesStackView.trailingAnchor.constraint(equalTo: self.LaunchesItemContentView.trailingAnchor, constant: -20),
            self.LaunchesStackView.bottomAnchor.constraint(equalTo: self.LaunchesItemContentView.bottomAnchor, constant: -20),
            
            self.rocketImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.rocketUIView.heightAnchor.constraint(equalToConstant: 45),

            self.chevronImageView.trailingAnchor.constraint(equalTo: self.rocketUIView.trailingAnchor, constant: -20),
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.rocketUIView.centerYAnchor),

            self.labelRocketNameLabel.centerYAnchor.constraint(equalTo: self.chevronImageView.centerYAnchor),
            self.labelRocketNameLabel.leadingAnchor.constraint(equalTo: self.rocketUIView.leadingAnchor, constant: 15),
            self.labelRocketNameLabel.trailingAnchor.constraint(equalTo: self.chevronImageView.leadingAnchor, constant: 15),

            self.rocketButton.topAnchor.constraint(equalTo: self.rocketUIView.topAnchor),
            self.rocketButton.leadingAnchor.constraint(equalTo: self.rocketUIView.leadingAnchor),
            self.rocketButton.trailingAnchor.constraint(equalTo: self.rocketUIView.trailingAnchor),
            self.rocketButton.bottomAnchor.constraint(equalTo: self.rocketUIView.bottomAnchor),
            
            self.launchInformationsView.heightAnchor.constraint(equalToConstant: 110),

            self.totalLaunchesLabel.leftAnchor.constraint(equalTo: self.launchInformationsView.leftAnchor, constant: 12),
            self.totalLaunchesLabel.topAnchor.constraint(equalTo: self.launchInformationsView.topAnchor, constant: 10),
            
            self.totalLaunchesIntLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.topAnchor),
            self.totalLaunchesIntLabel.rightAnchor.constraint(equalTo: self.launchInformationsView.rightAnchor, constant: -20),
            
            self.failedLaunchesLabel.leftAnchor.constraint(equalTo: self.totalLaunchesLabel.leftAnchor),
            self.failedLaunchesLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.bottomAnchor, constant: 12),
            
            self.failedLaunchesIntLabel.rightAnchor.constraint(equalTo: self.totalLaunchesIntLabel.rightAnchor),
            self.failedLaunchesIntLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.topAnchor),
            
            self.successLaunchesLabel.leftAnchor.constraint(equalTo: self.failedLaunchesLabel.leftAnchor),
            self.successLaunchesLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.bottomAnchor, constant: 12),
            self.successLaunchesLabel.bottomAnchor.constraint(equalTo: self.launchInformationsView.bottomAnchor, constant: -10),

            self.successLaunchesIntLabel.rightAnchor.constraint(equalTo: self.failedLaunchesIntLabel.rightAnchor),
            self.successLaunchesIntLabel.topAnchor.constraint(equalTo: self.successLaunchesLabel.topAnchor),
            self.successLaunchesIntLabel.bottomAnchor.constraint(equalTo: self.launchInformationsView.bottomAnchor, constant: -10),

            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}
