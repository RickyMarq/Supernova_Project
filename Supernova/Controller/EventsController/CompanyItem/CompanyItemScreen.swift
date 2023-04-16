//
//  CompanyItemScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 17/03/23.
//

import UIKit
import SkeletonView

protocol CompanyItemScreenProtocols: AnyObject {
    func companyLinkAction()
}

class CompanyItemScreen: UIView {
    
    weak var delegate: CompanyItemScreenProtocols?
    
    func delegate(delegate: CompanyItemScreenProtocols) {
        self.delegate = delegate
    }
    
    lazy var companyItemScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var companyContentView: UIView = {
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
    
    lazy var companyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.roundCorners(.allCorners, radius: 10)
        return imageView
    }()
    
    lazy var companyNameLabel: UILabel = {
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
    
    lazy var FoundingYearLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
 //       label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    lazy var companyDescriptionLabel: UILabel = {
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
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var separatorSecondaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
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
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    lazy var companyLinkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(companyLinkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func companyLinkButtonTapped() {
        self.delegate?.companyLinkAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension CompanyItemScreen: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.companyItemScrollView)
        self.companyItemScrollView.addSubview(self.companyContentView)
        self.companyContentView.addSubview(self.rocketItemsStackView)
        self.rocketItemsStackView.addArrangedSubview(self.companyLogoImageView)
        self.rocketItemsStackView.addArrangedSubview(self.companyNameLabel)
        self.rocketItemsStackView.addArrangedSubview(self.FoundingYearLabel)
        self.rocketItemsStackView.addArrangedSubview(self.companyDescriptionLabel)
        self.rocketItemsStackView.addArrangedSubview(self.companyInformationTitle)
        
        self.rocketItemsStackView.addArrangedSubview(self.companyInfoUIView)
        self.companyInfoUIView.addSubview(self.totalLaunchesLabel)
        self.companyInfoUIView.addSubview(self.totalLaunchesIntLabel)
        
//        self.companyInfoUIView.addSubview(self.separatorView)
        
        self.companyInfoUIView.addSubview(self.failedLaunchesLabel)
        self.companyInfoUIView.addSubview(self.failedLaunchesIntLabel)
        
//        self.companyInfoUIView.addSubview(self.separatorSecondaryView)
        
        self.companyInfoUIView.addSubview(self.successLaunchesLabel)
        self.companyInfoUIView.addSubview(self.successLaunchesIntLabel)
        
        
        
        self.rocketItemsStackView.addArrangedSubview(self.companyLinksUIView)
        
        self.companyLinksUIView.addSubview(self.companyLinkLabel)
        self.companyLinksUIView.addSubview(self.chevronImageView)
        self.companyLinksUIView.addSubview(self.companyLinkButton)
        
        
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.companyItemScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.companyItemScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.companyItemScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.companyItemScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.companyContentView.topAnchor.constraint(equalTo: self.companyItemScrollView.topAnchor),
            self.companyContentView.leadingAnchor.constraint(equalTo: self.companyItemScrollView.leadingAnchor),
            self.companyContentView.trailingAnchor.constraint(equalTo: self.companyItemScrollView.trailingAnchor),
            self.companyContentView.bottomAnchor.constraint(equalTo: self.companyItemScrollView.bottomAnchor),
            self.companyContentView.widthAnchor.constraint(equalTo: self.companyItemScrollView.widthAnchor),
            
            self.rocketItemsStackView.topAnchor.constraint(equalTo: self.companyContentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.rocketItemsStackView.leadingAnchor.constraint(equalTo: self.companyContentView.leadingAnchor, constant: 20),
            self.rocketItemsStackView.trailingAnchor.constraint(equalTo: self.companyContentView.trailingAnchor, constant: -20),
            self.rocketItemsStackView.bottomAnchor.constraint(equalTo: self.companyContentView.bottomAnchor, constant: -20),
            
//            self.companyLogoImageView.topAnchor.constraint(equalTo: self.companyContentView.safeAreaLayoutGuide.topAnchor, constant: 20),
//            self.companyLogoImageView.leadingAnchor.constraint(equalTo: self.companyContentView.leadingAnchor, constant: 20),
//            self.companyLogoImageView.trailingAnchor.constraint(equalTo: self.companyContentView.trailingAnchor, constant: -20),
            self.companyLogoImageView.heightAnchor.constraint(equalToConstant: 150),
            
//            self.companyNameLabel.topAnchor.constraint(equalTo: self.companyLogoImageView.bottomAnchor, constant: 20),
//            self.companyNameLabel.leadingAnchor.constraint(equalTo: self.companyLogoImageView.leadingAnchor),
//            self.companyNameLabel.trailingAnchor.constraint(equalTo: self.companyLogoImageView.trailingAnchor),
            
            
//            self.companyDescriptionLabel.topAnchor.constraint(equalTo: self.companyNameLabel.bottomAnchor, constant: 20),
//            self.companyDescriptionLabel.leadingAnchor.constraint(equalTo: self.companyNameLabel.leadingAnchor),
//            self.companyDescriptionLabel.trailingAnchor.constraint(equalTo: self.companyNameLabel.trailingAnchor),
            
//            self.companyInfoUIView.topAnchor.constraint(equalTo: self.companyDescriptionLabel.bottomAnchor, constant: 20),
//            self.companyInfoUIView.leadingAnchor.constraint(equalTo: self.companyDescriptionLabel.leadingAnchor),
//            self.companyInfoUIView.trailingAnchor.constraint(equalTo: self.companyDescriptionLabel.trailingAnchor),
//            self.companyInfoUIView.bottomAnchor.constraint(equalTo: self.companyContentView.bottomAnchor, constant: -20),
            self.companyInfoUIView.heightAnchor.constraint(equalToConstant: 100),
            
            self.totalLaunchesLabel.leftAnchor.constraint(equalTo: self.companyInfoUIView.leftAnchor, constant: 12),
            self.totalLaunchesLabel.topAnchor.constraint(equalTo: self.companyInfoUIView.topAnchor, constant: 10),
            
            self.totalLaunchesIntLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.topAnchor),
            self.totalLaunchesIntLabel.rightAnchor.constraint(equalTo: self.companyInfoUIView.rightAnchor, constant: -20),
            
//            self.separatorView.topAnchor.constraint(equalTo: self.totalLaunchesIntLabel.bottomAnchor, constant: 4),
//            self.separatorView.leftAnchor.constraint(equalTo: self.companyInfoUIView.leftAnchor, constant: 20),
//            self.separatorView.rightAnchor.constraint(equalTo: self.companyInfoUIView.rightAnchor),
//            self.separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            self.failedLaunchesLabel.leftAnchor.constraint(equalTo: self.totalLaunchesLabel.leftAnchor),
            self.failedLaunchesLabel.topAnchor.constraint(equalTo: self.totalLaunchesLabel.bottomAnchor, constant: 12),
            
            self.failedLaunchesIntLabel.rightAnchor.constraint(equalTo: self.totalLaunchesIntLabel.rightAnchor),
            self.failedLaunchesIntLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.topAnchor),
            
//            self.separatorSecondaryView.topAnchor.constraint(equalTo: self.failedLaunchesIntLabel.bottomAnchor, constant: 4),
//            self.separatorSecondaryView.leftAnchor.constraint(equalTo: self.companyInfoUIView.leftAnchor, constant: 20),
//            self.separatorSecondaryView.rightAnchor.constraint(equalTo: self.companyInfoUIView.rightAnchor),
//            self.separatorSecondaryView.heightAnchor.constraint(equalToConstant: 1),
            
            
            self.successLaunchesLabel.leftAnchor.constraint(equalTo: self.failedLaunchesLabel.leftAnchor),
            self.successLaunchesLabel.topAnchor.constraint(equalTo: self.failedLaunchesLabel.bottomAnchor, constant: 12),
            self.successLaunchesLabel.bottomAnchor.constraint(equalTo: self.companyInfoUIView.bottomAnchor, constant: -10),

            self.successLaunchesIntLabel.rightAnchor.constraint(equalTo: self.failedLaunchesIntLabel.rightAnchor),
            self.successLaunchesIntLabel.topAnchor.constraint(equalTo: self.successLaunchesLabel.topAnchor),
            self.successLaunchesIntLabel.bottomAnchor.constraint(equalTo: self.companyInfoUIView.bottomAnchor, constant: -10),
            
            
            
            
            self.companyLinksUIView.heightAnchor.constraint(equalToConstant: 45),
            self.chevronImageView.trailingAnchor.constraint(equalTo: self.companyLinksUIView.trailingAnchor, constant: -20),
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.companyLinksUIView.centerYAnchor),
//
            self.companyLinkLabel.centerYAnchor.constraint(equalTo: self.chevronImageView.centerYAnchor),
            self.companyLinkLabel.leadingAnchor.constraint(equalTo: self.companyLinksUIView.leadingAnchor, constant: 15),
            self.companyLinkLabel.trailingAnchor.constraint(equalTo: self.chevronImageView.leadingAnchor, constant: 15),
//
            self.companyLinkButton.topAnchor.constraint(equalTo: self.companyLinksUIView.topAnchor),
            self.companyLinkButton.leadingAnchor.constraint(equalTo: self.companyLinksUIView.leadingAnchor),
            self.companyLinkButton.trailingAnchor.constraint(equalTo: self.companyLinksUIView.trailingAnchor),
            self.companyLinkButton.bottomAnchor.constraint(equalTo: self.companyLinksUIView.bottomAnchor),
//
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
}
