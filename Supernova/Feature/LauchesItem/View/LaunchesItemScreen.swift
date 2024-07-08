//
//  LauchesScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit
import SkeletonView
import YouTubeiOSPlayerHelper
import GoogleMobileAds
import MapKit

protocol LaunchesItemScreenProtocols: AnyObject {
    func playButtonAction()
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
    
    lazy var adsView: GADBannerView = {
        let ads = GADBannerView()
        ads.contentMode = .scaleToFill
        ads.isSkeletonable = true
        ads.layer.masksToBounds = true
        ads.layer.cornerRadius = 12
        ads.translatesAutoresizingMaskIntoConstraints = false
        return ads
    }()
    
    lazy var adsUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var adLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Publicity"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
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
    
    lazy var playerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 4
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Stream becomes available one hour before launch"
        return label
    }()
    
    lazy var playerView: YTPlayerView = {
        let yt = YTPlayerView()
        yt.translatesAutoresizingMaskIntoConstraints = false
        yt.layer.masksToBounds = true
        yt.layer.cornerRadius = 10
        yt.webView?.configuration.allowsPictureInPictureMediaPlayback = true
        return yt
    }()
    
    lazy var playerViewBackgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var playerViewPlayButton: UIImageView = {
        let image = UIImage(named: "playbutton")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var playerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func playerButtonTapped() {
        self.delegate?.playButtonAction()
    }
    
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
    
    // --
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var padNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 10
        mapView.mapType = .satellite
        mapView.showsUserLocation = false
        if #available(iOS 11, *) {
            
        }
        return mapView
    }()
    
    lazy var padView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var locationPadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var missionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var missionNameLabel: UILabel = {
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
    
    lazy var missionDescriptionLabel: UILabel = {
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
        // -- YT Player
        self.LaunchesStackView.addArrangedSubview(self.playerInfoLabel)
        self.LaunchesStackView.addArrangedSubview(self.playerView)
        self.playerView.addSubview(self.playerViewBackgroundImage)
        self.playerViewBackgroundImage.addSubview(self.playerViewPlayButton)
        self.playerView.addSubview(self.playerButton)
        // -- Launches Stats
        self.LaunchesStackView.addArrangedSubview(self.launchInformationsView)
        self.launchInformationsView.addSubview(self.totalLaunchesLabel)
        self.launchInformationsView.addSubview(self.totalLaunchesIntLabel)
        self.launchInformationsView.addSubview(self.successLaunchesLabel)
        self.launchInformationsView.addSubview(self.successLaunchesIntLabel)
        self.launchInformationsView.addSubview(self.failedLaunchesLabel)
        self.launchInformationsView.addSubview(self.failedLaunchesIntLabel)
        // -- Rocket Button
        self.LaunchesStackView.addArrangedSubview(self.rocketUIView)
        self.rocketUIView.addSubview(self.chevronImageView)
        self.rocketUIView.addSubview(self.labelRocketNameLabel)
        self.rocketUIView.addSubview(self.rocketButton)
        // -- Ad
        self.LaunchesStackView.addArrangedSubview(self.adsUIView)
        self.adsUIView.addSubview(self.adsView)
        self.adsUIView.addSubview(self.adLabel)
        
        // -- Pad View
        self.LaunchesStackView.addArrangedSubview(self.padView)
        self.padView.addSubview(self.padNameLabel)
        self.padView.addSubview(self.mapView)
        self.padView.addSubview(self.locationPadLabel)
        
        
        self.LaunchesStackView.addArrangedSubview(self.missionView)
        self.missionView.addSubview(self.missionNameLabel)
        self.missionView.addSubview(self.missionDescriptionLabel)
        self.missionView.addSubview(self.rocketImageView)

        //--
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
            
            self.playerView.heightAnchor.constraint(equalToConstant: 200),
            self.rocketUIView.heightAnchor.constraint(equalToConstant: 45),
            
            self.playerViewBackgroundImage.topAnchor.constraint(equalTo: self.playerView.topAnchor),
            self.playerViewBackgroundImage.leadingAnchor.constraint(equalTo: self.playerView.leadingAnchor),
            self.playerViewBackgroundImage.trailingAnchor.constraint(equalTo: self.playerView.trailingAnchor),
            self.playerViewBackgroundImage.bottomAnchor.constraint(equalTo: self.playerView.bottomAnchor),
            
            self.playerViewPlayButton.centerXAnchor.constraint(equalTo: self.playerViewBackgroundImage.centerXAnchor),
            self.playerViewPlayButton.centerYAnchor.constraint(equalTo: self.playerViewBackgroundImage.centerYAnchor),
            self.playerViewPlayButton.heightAnchor.constraint(equalToConstant: 80),
            self.playerViewPlayButton.widthAnchor.constraint(equalToConstant: 80),
            
            self.playerButton.topAnchor.constraint(equalTo: self.playerView.topAnchor),
            self.playerButton.leadingAnchor.constraint(equalTo: self.playerView.leadingAnchor),
            self.playerButton.trailingAnchor.constraint(equalTo: self.playerView.trailingAnchor),
            self.playerButton.bottomAnchor.constraint(equalTo: self.playerView.bottomAnchor),

            self.chevronImageView.trailingAnchor.constraint(equalTo: self.rocketUIView.trailingAnchor, constant: -20),
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.rocketUIView.centerYAnchor),

            self.labelRocketNameLabel.centerYAnchor.constraint(equalTo: self.chevronImageView.centerYAnchor),
            self.labelRocketNameLabel.leadingAnchor.constraint(equalTo: self.rocketUIView.leadingAnchor, constant: 15),
            self.labelRocketNameLabel.trailingAnchor.constraint(equalTo: self.chevronImageView.leadingAnchor, constant: 15),

            self.rocketButton.topAnchor.constraint(equalTo: self.rocketUIView.topAnchor),
            self.rocketButton.leadingAnchor.constraint(equalTo: self.rocketUIView.leadingAnchor),
            self.rocketButton.trailingAnchor.constraint(equalTo: self.rocketUIView.trailingAnchor),
            self.rocketButton.bottomAnchor.constraint(equalTo: self.rocketUIView.bottomAnchor),
            
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

            // -- Separator
            
            self.separator.heightAnchor.constraint(equalToConstant: 3),
            
            self.adsView.heightAnchor.constraint(equalToConstant: 100),
            
            self.adsView.topAnchor.constraint(equalTo: self.adsUIView.topAnchor, constant: 10),
            self.adsView.leadingAnchor.constraint(equalTo: self.adsUIView.leadingAnchor, constant: 10),
            self.adsView.trailingAnchor.constraint(equalTo: self.adsUIView.trailingAnchor, constant: -10),
            
            self.adLabel.centerXAnchor.constraint(equalTo: self.adsUIView.centerXAnchor),
            self.adLabel.topAnchor.constraint(equalTo: self.adsView.bottomAnchor, constant: 5),
            self.adLabel.bottomAnchor.constraint(equalTo: self.adsUIView.bottomAnchor, constant: -10),
            
            self.padNameLabel.topAnchor.constraint(equalTo: self.padView.topAnchor, constant: 16),
            self.padNameLabel.leftAnchor.constraint(equalTo: self.padView.leftAnchor, constant: 12),
            self.padNameLabel.rightAnchor.constraint(equalTo: self.padView.rightAnchor, constant: -12),
            
            self.locationPadLabel.topAnchor.constraint(equalTo: self.padNameLabel.bottomAnchor, constant: 12),
            self.locationPadLabel.leftAnchor.constraint(equalTo: self.padNameLabel.leftAnchor),
            self.locationPadLabel.rightAnchor.constraint(equalTo: self.padNameLabel.rightAnchor),
            
                        
            self.mapView.topAnchor.constraint(equalTo: self.locationPadLabel.bottomAnchor, constant: 12),
            self.mapView.leadingAnchor.constraint(equalTo: self.padView.leadingAnchor, constant: 20),
            self.mapView.trailingAnchor.constraint(equalTo: self.padView.trailingAnchor, constant: -20),
            self.mapView.bottomAnchor.constraint(equalTo: self.padView.bottomAnchor, constant: -16),
            self.mapView.heightAnchor.constraint(equalToConstant: 200),
                        
            self.missionNameLabel.topAnchor.constraint(equalTo: self.missionView.topAnchor, constant: 16),
            self.missionNameLabel.leftAnchor.constraint(equalTo: self.missionView.leftAnchor, constant: 12),
            self.missionNameLabel.rightAnchor.constraint(equalTo: self.missionView.rightAnchor, constant: -12),

            self.missionDescriptionLabel.topAnchor.constraint(equalTo: self.missionNameLabel.bottomAnchor, constant: 12),
            self.missionDescriptionLabel.leftAnchor.constraint(equalTo: self.missionNameLabel.leftAnchor),
            self.missionDescriptionLabel.rightAnchor.constraint(equalTo: self.missionNameLabel.rightAnchor),
            
            self.rocketImageView.topAnchor.constraint(equalTo: self.missionDescriptionLabel.bottomAnchor, constant: 12),
            self.rocketImageView.leftAnchor.constraint(equalTo: self.missionDescriptionLabel.leftAnchor),
            self.rocketImageView.rightAnchor.constraint(equalTo: self.missionDescriptionLabel.rightAnchor),
            self.rocketImageView.heightAnchor.constraint(equalToConstant: 200),
            self.rocketImageView.bottomAnchor.constraint(equalTo: self.missionView.bottomAnchor, constant: -16),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.playerView.setShadow(view: self.playerView)
        self.playerView.setBorder(view: self.playerView)
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}
