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
    
    var lauches: ResultedModel?
    var lauchesScreen: LaunchesItemScreen?
    var youtubeModel = [ItemYT]()

    
    override func loadView() {
        self.lauchesScreen = LaunchesItemScreen()
        self.view = lauchesScreen
    }
    
    init(lauches: ResultedModel) {
        self.lauches = lauches
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lauchesScreen?.delegate(delegate: self)
        self.lauchesScreen?.playerView.delegate = self
        self.configMissionSection()
        self.configPadSection()
        self.configMap()
        self.lauchesScreen?.launchNameLabel.text = lauches?.name
        self.lauchesScreen?.idLabel.text = "#\(lauches?.rocket?.id ?? 0)"
        self.lauchesScreen?.rocketDescriptionLabel.text = lauches?.mission?.description
        self.lauchesScreen?.rocketImageView.sd_setImage(with: URL(string: lauches?.image ?? ""))
        self.lauchesScreen?.playerViewBackgroundImage.sd_setImage(with: URL(string: lauches?.image ?? ""))
        
        self.lauchesScreen?.labelRocketNameLabel.text = lauches?.rocket?.configuration.name
        
        
        self.lauchesScreen?.totalLaunchesIntLabel.text = "\(lauches?.orbitalLaunchAttemptCount ?? 0)"
        self.lauchesScreen?.successLaunchesIntLabel.text = "\(lauches?.padLaunchAttemptCount ?? 0)"
        self.lauchesScreen?.failedLaunchesIntLabel.text = "\(lauches?.locationLaunchAttemptCount ?? 0)"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // DEBUG: Ad Text
        // self.lauchesScreen?.adsView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = ""
        self.isOneHourApart()
        self.lauchesScreen?.adsView.rootViewController = self
        self.lauchesScreen?.adsView.delegate = self
        // ca-app-pub-7460518702464601/2402708926
        self.lauchesScreen?.adsView.adUnitID = "ca-app-pub-7460518702464601/2402708926"

        self.lauchesScreen?.adsView.load(GADRequest())
 //       GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "432909f03960989416fd100d405a3191" ]
 //       print("DEBUG MODE: GAD \(GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Launches"
    }
    
    func configPadSection() {
        self.lauchesScreen?.padNameLabel.text = "Pad: \(lauches?.pad?.name ?? "")"
        self.lauchesScreen?.locationPadLabel.text = "Location: \(lauches?.pad?.location.name ?? "")"
    }
    
    func configMissionSection() {
        self.lauchesScreen?.missionNameLabel.text = lauches?.mission?.name
        self.lauchesScreen?.missionDescriptionLabel.text = lauches?.mission?.description
    }
    
    func configMap() {
        let lat = (lauches?.pad?.latitude as? NSString)?.doubleValue
        let lon = (lauches?.pad?.longitude as? NSString)?.doubleValue
        let center = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.lauchesScreen?.mapView.setRegion(region, animated: true)

    }
    
    func isOneHourApart() {
        let fullHours = convertHoursForCountDownLaunchesFormatter(lauches?.windowStart ?? "", outPut: "HH:mm:ss")
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
        } else {
            self.lauchesScreen?.playerView.removeFromSuperview()
        }
    }
    
    func getVideo(nameOfLaunch: String) {        
        YoutubeInternetServices.sharedObjc.getVideosByName(name: nameOfLaunch) { [weak self] result in
            
            switch result {
    
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.youtubeModel.append(contentsOf: model ?? [])
                
                print("DEBUG MODE \(model?[0].id?.videoID)")

                DispatchQueue.main.async {
                    strongSelf.lauchesScreen?.playerView.load(withVideoId: strongSelf.youtubeModel[0].id?.videoID ?? "")
                    strongSelf.lauchesScreen?.playerView.playVideo()

                    
//                    strongSelf.lauchesScreen?.playerViewBackgroundImage.removeFromSuperview()
                }

            case .failure(let error):
                print("DEBUG MODE  ERROR")
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       print("DEBUG MODE: TODO OPEN PIP")
    }
    
    
    
}

extension LaunchesItemController: LaunchesItemScreenProtocols {
   
    func playButtonAction() {
        guard let title = lauches?.name else {return}
        self.getVideo(nameOfLaunch: title)
    }
    
    func rocketButtonAction() {
        guard let rocket = lauches?.rocket else {return}
        let vc = RocketItem(rocket: rocket)
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
