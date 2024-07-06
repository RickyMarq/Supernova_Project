//
//  LauchesController.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit
import YouTubeiOSPlayerHelper
import GoogleMobileAds
import MapKit
import AVKit


class LaunchesItemController: UIViewController {
    
    var alerts: Alerts?
    var viewModel: LaunchingItemViewModel?
    var lauches: ResultedModel?
    var lauchesScreen: LaunchesItemScreen?
    var youtubeModel = [ItemYT]()
    
    override func loadView() {
        self.lauchesScreen = LaunchesItemScreen()
        self.view = lauchesScreen
    }
    
    init(viewModel: LaunchingItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.lauchesScreen?.delegate(delegate: self)
        self.viewModel?.delegate(delegate: self)
        self.lauchesScreen?.playerView.delegate = self
        self.configMissionSection()
        self.configPadSection()
        self.configMap()
        self.lauchesScreen?.launchNameLabel.text = viewModel?.launchName
        self.lauchesScreen?.idLabel.text = "#\(viewModel?.launchID ?? 0)"
        self.lauchesScreen?.rocketDescriptionLabel.text = viewModel?.rocketDescription
        self.lauchesScreen?.rocketImageView.sd_setImage(with: URL(string: viewModel?.rocketImage ?? ""))
        self.lauchesScreen?.playerViewBackgroundImage.sd_setImage(with: URL(string: viewModel?.rocketImage ?? ""))


        self.lauchesScreen?.labelRocketNameLabel.text = viewModel?.rocketConfigName
        

        self.lauchesScreen?.totalLaunchesIntLabel.text = "\(viewModel?.totalLaunch ?? 0)"
        self.lauchesScreen?.successLaunchesIntLabel.text = "\(viewModel?.successfulLaunch ?? 0)"
        self.lauchesScreen?.failedLaunchesIntLabel.text = "\(viewModel?.failedLaunch ?? 0)"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // self.lauchesScreen?.adsView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = ""
        self.isOneHourApart()
        self.lauchesScreen?.adsView.rootViewController = self
        self.lauchesScreen?.adsView.delegate = self
        // ca-app-pub-7460518702464601/2402708926
        self.lauchesScreen?.adsView.adUnitID = "ca-app-pub-7460518702464601/2402708926"

        self.lauchesScreen?.adsView.load(GADRequest())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Launches"
    }
    
    func configPadSection() {
        self.lauchesScreen?.padNameLabel.text = "Pad: \(viewModel?.padName ?? "")"
        self.lauchesScreen?.locationPadLabel.text = "Location: \(viewModel?.padLocation ?? "")"
    }
    
    func configMissionSection() {
        self.lauchesScreen?.missionNameLabel.text = viewModel?.missionName
        self.lauchesScreen?.missionDescriptionLabel.text = viewModel?.missionDescription
    }
    
    func configMap() {
        let lat = (viewModel?.latitude as? NSString)?.doubleValue
        let lon = (viewModel?.longitude as? NSString)?.doubleValue
        let center = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.lauchesScreen?.mapView.setRegion(region, animated: true)

    }
    
    func isOneHourApart() {
        let fullHours = convertHoursForCountDownLaunchesFormatter(viewModel?.windowStartLaunch ?? "", outPut: "HH:mm:ss")
        print("DEBUG MODE FULLHOURS: \(fullHours)")
        let timeInterval = fullHours.timeIntervalSince(Date())
        print("DEBUG MODE: TIME INTERVEL (DATE ALREADY COMPARED \(timeInterval)")
        let convertion = Int(timeInterval)
        print("DEBUG MODE CONVERTION: \(convertion)")
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale.current
        let date = formatter.localizedString(for: fullHours, relativeTo: Date())
        print("DEBUG MODE DATE: \(date)")
        
        if convertion <= 3600 {
            self.lauchesScreen?.playerInfoLabel.removeFromSuperview()
        } else {
            self.lauchesScreen?.playerView.removeFromSuperview()
        }
    }
}

extension LaunchesItemController: LaunchingItemViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.lauchesScreen?.playerView.load(withVideoId: self.viewModel?.videoID ?? "")
            self.lauchesScreen?.playerView.playVideo()

        }
    }
    
    func failure(error: String) {
        self.alerts?.getAlert(title: "Error", message: "\(error)", buttonMessage: "Cancel")
    }
}

extension LaunchesItemController: LaunchesItemScreenProtocols {
   
    func playButtonAction() {
        guard let title = viewModel?.launchName else {return}
        self.viewModel?.getVideo(nameOfLaunch: title)
    }
    
    func rocketButtonAction() {
        guard let rocket = lauches?.rocket else {return}
        let vc = RocketItem(viewModel: RocketItemViewModel(services: RocketServices()), rocket: rocket)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LaunchesItemController: YTPlayerViewDelegate {
    
    
}

extension LaunchesItemController: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("DEBUG MODE: Ad carregado")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("DEBUG MODE: Error trying to receive ad \(error.localizedDescription)")
    }
    
}
