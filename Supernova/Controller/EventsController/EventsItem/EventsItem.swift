//
//  EventsController.swift
//  Supernova
//
//  Created by Henrique Marques on 13/02/23.
//

import UIKit
import YouTubeiOSPlayerHelper
import MapKit

class EventsItem: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    @IBOutlet weak var youtubeImageView: UIImageView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var rocketView: UIView!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var titleMissionLabel: UILabel!
    @IBOutlet weak var padView: UIView!
    @IBOutlet weak var padId: UILabel!
    @IBOutlet weak var padNameLabel: UILabel!
    @IBOutlet weak var padLocation: UILabel!
    @IBOutlet weak var launchPadView: UIView!
    @IBOutlet weak var launchCountInt: UILabel!
    @IBOutlet weak var missionDescription: UILabel!
    @IBOutlet weak var separatorPad: UIView!
    @IBOutlet weak var separatorMission: UIView!
    
    
    
    @IBAction func rocketButton(_ sender: Any) {
        guard let rocket = events?.launches[0].rocket else {return}
        let vc = RocketItem(rocket: rocket)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func youtubeButtonTouched(_ sender: Any) {
        let trimmed = events?.videoURL?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        self.youtubePlayerView.load(withVideoId: "\(trimmed ?? "")")
        self.youtubePlayerView.playVideo()
        
    }
    var events: ResultedEvents?
    var alerts: Alerts?
    
    init(events: ResultedEvents) {
        self.events = events
        super.init(nibName: "EventsScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.configYoutubePlayer()
        self.titleLabel.text = events?.name
        self.summaryLabel.text = events?.description
        self.id.text = "#\(events?.id ?? 0)"
        
        self.youtubeImageView.sd_setImage(with: URL(string: events?.featureImage ?? ""), placeholderImage: UIImage(named: "loading"))
        
        
        self.locationLabel.text = "\(events?.location ?? "Not Found")"
        
        self.dateView.clipsToBounds = true
        self.dateView.layer.masksToBounds = true
        self.dateView.layer.cornerRadius = 10
        self.infoView.layer.cornerRadius = 10
        self.eventsImageView.layer.cornerRadius = 10
        self.locationMap.layer.cornerRadius = 10
        self.rocketView.layer.cornerRadius = 10
        self.padView.layer.masksToBounds = true
        self.padView.layer.cornerRadius = 10
        self.stateView.layer.cornerRadius = 10
        self.launchPadView.layer.cornerRadius = 10
        self.locationMap.setBorder(view: self.locationMap)
        self.locationMap.isUserInteractionEnabled = false
        self.setMapLocation()
        let day = convertDateToDayFormatter(events?.date ?? "")
        let month = convertDateToMonthFormatter(events?.date ?? "")
        let formatted = month.replacingOccurrences(of: ".", with: " ")
        
        let hour = convertHourEventsFormatter(events?.date ?? "")
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let date = formatter.localizedString(for: hour, relativeTo: Date())
        self.hours.text = "\(date.capitalizedSentence)"
     
        print("DEBUG MODE: Month -> \(month)")
        self.monthLabel.text = formatted.uppercased()
        self.dayLabel.text = day
        self.setRocketButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.configCustomNavigationController()
        print("DEBUG MODE: LOC \(events?.location ?? "")")

    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.locationMap.removeFromSuperview()
//    }
    
    func configYoutubePlayer() {
        print(events?.videoURL)
        self.youtubePlayerView.setShadow(view: self.youtubePlayerView)
//        self.youtubePlayerView.layer.masksToBounds = true
        self.youtubePlayerView.clipsToBounds = true
        self.youtubePlayerView.layer.cornerRadius = 10
        self.youtubePlayerView.setBorder(view: self.youtubePlayerView)
        
        self.youtubePlayerView.delegate = self
        let trimmed = events?.videoURL?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
//        self.youtubePlayerView.load(withVideoId: "\(trimmed ?? "")")
//        self.youtubePlayer.loadVideo(byURL: "https://www.youtube.com/watch?v=bsM1qdGAVbU&ab_channel=iOSAcademy", startSeconds: 1.0)
    }
    
    func setMapLocation() {
        if events?.launches.isEmpty == true {
            self.locationMap.removeFromSuperview()
//            let lat =  28.60822681
//            let lon =  -80.60428186
//            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            self.locationMap.setRegion(region, animated: true)
        } else {
            let lat = (events?.launches[0].pad.latitude as? NSString)?.doubleValue
            let lon = (events?.launches[0].pad.longitude as? NSString)?.doubleValue
            let center = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.locationMap.setRegion(region, animated: true)
            self.rocketLabel.text = events?.launches[0].rocket.configuration.name

        }
    }
    
    func setRocketButton() {
        if events?.launches.isEmpty == true {
            self.rocketView.removeFromSuperview()
            self.titleMissionLabel.removeFromSuperview()
            self.padView.removeFromSuperview()
            self.launchPadView.removeFromSuperview()
            self.missionDescription.removeFromSuperview()
            self.separatorPad.removeFromSuperview()
            self.separatorMission.removeFromSuperview()
            self.eventsImageView.removeFromSuperview()
        } else {
            self.rocketLabel.text = events?.launches[0].rocket.configuration.name
            self.titleMissionLabel.text = events?.launches[0].mission?.name
            
            self.padNameLabel.text = events?.launches[0].pad.name
            self.padLocation.text = "Location: \(events?.launches[0].pad.location.name ?? "Not Found")"
            self.padId.text = "#\(events?.launches[0].pad.agencyID ?? 0)"
            self.launchCountInt.text = "\(events?.launches[0].pad.launchCount ?? 0)"
            self.missionDescription.text = events?.launches[0].mission?.description
            self.eventsImageView.sd_setImage(with: URL(string: events?.featureImage ?? ""))
             
  //          self.titleMissionLabel.text = events?.launches[0].mission?.description
        }
    }
}

extension EventsItem: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youtubePlayerView.playVideo()
    }
}
