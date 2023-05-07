//
//  RocketScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 15/03/23.
//

import UIKit
import SkeletonView


protocol RocketScreenProtocols: AnyObject {
    func companyButtonAction()
    func wikiButtonAction()
}

class RocketScreen: UIView {
    
    weak var delegate: RocketScreenProtocols?
    
    func delegate(delegate: RocketScreenProtocols?) {
        self.delegate = delegate
    }
    
    lazy var rocketViewScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var rocketContentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        return contentView
    }()
    
    lazy var rocketItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
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
    
    lazy var companyUIView: UIView = {
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
    
    lazy var labelCompanyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var companyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(companyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func companyButtonTapped() {
        self.delegate?.companyButtonAction()
    }
    
    lazy var launchInformationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Company"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var launchInformationsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var companyInformationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Launches Informations"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var companyInfoUIView: UIView = {
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
        label.text = "Launch Count"
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
        label.text = "Failed Launches"
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
        label.text = "Successful Launches"
        return label
    }()
    
    lazy var successLaunchesIntLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    lazy var companyLinksUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var companyLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Wikipedia"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var companyLinkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(companyLinkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func companyLinkButtonTapped() {
        self.delegate?.wikiButtonAction()
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension RocketScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.rocketViewScrollView)
        self.rocketViewScrollView.addSubview(self.rocketContentView)
        self.rocketContentView.addSubview(self.rocketItemsStackView)
        self.rocketItemsStackView.addArrangedSubview(self.rocketNameLabel)
        self.rocketItemsStackView.addArrangedSubview(self.rocketDescriptionLabel)
        self.rocketItemsStackView.addArrangedSubview(self.rocketImageView)
        
   
        self.rocketItemsStackView.addArrangedSubview(self.launchInformationTitle)
        self.rocketItemsStackView.addArrangedSubview(self.companyUIView)
//        self.rocketItemsStackView.addArrangedSubview(self.companyInformationTitle)
        
        self.rocketItemsStackView.addArrangedSubview(self.companyInfoUIView)
        self.companyInfoUIView.addSubview(self.totalLaunchesLabel)
        self.companyInfoUIView.addSubview(self.totalLaunchesIntLabel)
        self.companyInfoUIView.addSubview(self.failedLaunchesLabel)
        self.companyInfoUIView.addSubview(self.failedLaunchesIntLabel)
        self.companyInfoUIView.addSubview(self.successLaunchesLabel)
        self.companyInfoUIView.addSubview(self.successLaunchesIntLabel)

        
        self.companyUIView.addSubview(self.chevronImageView)
        self.companyUIView.addSubview(self.labelCompanyNameLabel)
        self.companyUIView.addSubview(self.companyButton)
        
        self.rocketItemsStackView.addArrangedSubview(self.companyLinksUIView)
        self.companyLinksUIView.addSubview(self.companyLinkLabel)
        self.companyLinksUIView.addSubview(self.companyLinkButton)
        
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.rocketViewScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.rocketViewScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.rocketViewScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.rocketViewScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.rocketContentView.topAnchor.constraint(equalTo: self.rocketViewScrollView.topAnchor),
            self.rocketContentView.leadingAnchor.constraint(equalTo: self.rocketViewScrollView.leadingAnchor),
            self.rocketContentView.trailingAnchor.constraint(equalTo: self.rocketViewScrollView.trailingAnchor),
            self.rocketContentView.bottomAnchor.constraint(equalTo: self.rocketViewScrollView.bottomAnchor),
            self.rocketContentView.widthAnchor.constraint(equalTo: self.rocketViewScrollView.widthAnchor),
                        
            self.rocketItemsStackView.topAnchor.constraint(equalTo: self.rocketContentView.topAnchor, constant: 20),
            self.rocketItemsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.rocketItemsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.rocketItemsStackView.bottomAnchor.constraint(equalTo: self.rocketContentView.bottomAnchor, constant: -20),
            
        
//            self.rocketNameLabel.topAnchor.constraint(equalTo: self.rocketContentView.topAnchor, constant: 16),
//
//            self.rocketNameLabel.leadingAnchor.constraint(equalTo: self.rocketContentView.leadingAnchor, constant: 20),
//            self.rocketNameLabel.trailingAnchor.constraint(equalTo: self.rocketContentView.trailingAnchor, constant: -20),
//
//            self.rocketDescriptionLabel.topAnchor.constraint(equalTo: self.rocketNameLabel.bottomAnchor, constant: 20),
//            self.rocketDescriptionLabel.leadingAnchor.constraint(equalTo: self.rocketNameLabel.leadingAnchor),
//            self.rocketDescriptionLabel.trailingAnchor.constraint(equalTo: self.rocketNameLabel.trailingAnchor),
//
//
//            self.rocketImageView.topAnchor.constraint(equalTo: self.rocketDescriptionLabel.bottomAnchor, constant: 20),
//            self.rocketImageView.leadingAnchor.constraint(equalTo: self.rocketDescriptionLabel.leadingAnchor),
//            self.rocketImageView.trailingAnchor.constraint(equalTo: self.rocketDescriptionLabel.trailingAnchor),
           self.rocketImageView.heightAnchor.constraint(equalToConstant: 200),
//
//            self.launchInformationTitle.topAnchor.constraint(equalTo: self.rocketImageView.bottomAnchor, constant: 20),
//            self.launchInformationTitle.leadingAnchor.constraint(equalTo: self.rocketImageView.leadingAnchor),
//            self.launchInformationTitle.trailingAnchor.constraint(equalTo: self.rocketImageView.trailingAnchor),
//
//
//            self.companyUIView.topAnchor.constraint(equalTo: self.launchInformationTitle.bottomAnchor, constant: 10),
//            self.companyUIView.leadingAnchor.constraint(equalTo: self.rocketImageView.leadingAnchor),
//            self.companyUIView.trailingAnchor.constraint(equalTo: self.rocketImageView.trailingAnchor),
            self.companyUIView.heightAnchor.constraint(equalToConstant: 45),
//
            self.chevronImageView.trailingAnchor.constraint(equalTo: self.companyUIView.trailingAnchor, constant: -20),
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.companyUIView.centerYAnchor),
//
            self.labelCompanyNameLabel.centerYAnchor.constraint(equalTo: self.chevronImageView.centerYAnchor),
            self.labelCompanyNameLabel.leadingAnchor.constraint(equalTo: self.companyUIView.leadingAnchor, constant: 15),
            self.labelCompanyNameLabel.trailingAnchor.constraint(equalTo: self.chevronImageView.leadingAnchor, constant: 15),
//
            self.companyButton.topAnchor.constraint(equalTo: self.companyUIView.topAnchor),
            self.companyButton.leadingAnchor.constraint(equalTo: self.companyUIView.leadingAnchor),
            self.companyButton.trailingAnchor.constraint(equalTo: self.companyUIView.trailingAnchor),
            self.companyButton.bottomAnchor.constraint(equalTo: self.companyUIView.bottomAnchor),
//
//            self.launchInformationsView.topAnchor.constraint(equalTo: self.companyUIView.bottomAnchor, constant: 20),
//            self.launchInformationsView.leadingAnchor.constraint(equalTo: self.companyUIView.leadingAnchor),
//            self.launchInformationsView.trailingAnchor.constraint(equalTo: self.companyUIView.trailingAnchor),
//            self.launchInformationsView.bottomAnchor.constraint(equalTo: self.rocketContentView.bottomAnchor, constant: -20),
            
//            self.companyInfoUIView.heightAnchor.constraint(equalToConstant: 100),
            
            self.totalLaunchesLabel.leftAnchor.constraint(equalTo: self.companyInfoUIView.leftAnchor, constant: 12),
            self.totalLaunchesLabel.topAnchor.constraint(equalTo: self.companyInfoUIView.topAnchor, constant: 10),
            
            self.totalLaunchesIntLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.topAnchor),
            self.totalLaunchesIntLabel.rightAnchor.constraint(equalTo: self.companyInfoUIView.rightAnchor, constant: -20),
            
            self.failedLaunchesLabel.leftAnchor.constraint(equalTo: self.totalLaunchesLabel.leftAnchor),
            self.failedLaunchesLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.bottomAnchor, constant: 12),
            
            self.failedLaunchesIntLabel.rightAnchor.constraint(equalTo: self.totalLaunchesIntLabel.rightAnchor),
            self.failedLaunchesIntLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.topAnchor),
            
            self.successLaunchesLabel.leftAnchor.constraint(equalTo: self.failedLaunchesLabel.leftAnchor),
            self.successLaunchesLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.bottomAnchor, constant: 12),
            self.successLaunchesLabel.bottomAnchor.constraint(equalTo: self.companyInfoUIView.bottomAnchor, constant: -10),

            self.successLaunchesIntLabel.rightAnchor.constraint(equalTo: self.failedLaunchesIntLabel.rightAnchor),
            self.successLaunchesIntLabel.topAnchor.constraint(equalTo: self.successLaunchesLabel.topAnchor),
            self.successLaunchesIntLabel.bottomAnchor.constraint(equalTo: self.companyInfoUIView.bottomAnchor, constant: -10),
            
            self.companyLinksUIView.heightAnchor.constraint(equalToConstant: 45),
            
            self.companyLinkLabel.centerYAnchor.constraint(equalTo: self.companyLinksUIView.centerYAnchor),
            self.companyLinkLabel.leadingAnchor.constraint(equalTo: self.companyLinksUIView.leadingAnchor, constant: 15),
//            self.companyLinkLabel.trailingAnchor.constraint(equalTo: self.chevronImageView.leadingAnchor, constant: 15),
//
            self.companyLinkButton.topAnchor.constraint(equalTo: self.companyLinksUIView.topAnchor),
            
            self.companyLinkButton.leadingAnchor.constraint(equalTo: self.companyLinksUIView.leadingAnchor),
            
            self.companyLinkButton.trailingAnchor.constraint(equalTo: self.companyLinksUIView.trailingAnchor),
            
            self.companyLinkButton.bottomAnchor.constraint(equalTo: self.companyLinksUIView.bottomAnchor),
            
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
    
}
