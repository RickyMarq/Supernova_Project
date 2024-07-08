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
    
    var alerts: Alerts?
    var viewModel: EventsItemViewModel?
    
    init(viewModel: EventsItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "EventsScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func rocketButton(_ sender: Any) {
        guard let rocket = viewModel?.rocket else {return}
        let vc = RocketItem(viewModel: RocketItemViewModel(services: RocketServices()), rocket: rocket)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func youtubeButtonTouched(_ sender: Any) {
        let trimmed = viewModel?.videoURL.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        self.youtubePlayerView.load(withVideoId: "\(trimmed ?? "")")
        self.youtubePlayerView.playVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.configYoutubePlayer()
        self.titleLabel.text = viewModel?.eventName
        self.summaryLabel.text = viewModel?.eventDescription
        self.id.text = "#\(viewModel?.eventID ?? 0)"
        self.youtubeImageView.sd_setImage(with: URL(string: viewModel?.eventsImage ?? ""), placeholderImage: UIImage(named: "loading"))
        self.locationLabel.text = "\(viewModel?.eventsLocation ?? "Not Found")"
        
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
        let day = convertDateToDayFormatter(viewModel?.eventsDate ?? "")
        let month = convertDateToMonthFormatter(viewModel?.eventsDate ?? "")
        let formatted = month.replacingOccurrences(of: ".", with: " ")
        let hour = convertHourEventsFormatter(viewModel?.eventsDate ?? "")
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let date = formatter.localizedString(for: hour, relativeTo: Date())
        self.hours.text = "\(date.capitalizedSentence)"
     
        self.monthLabel.text = formatted.uppercased()
        self.dayLabel.text = day
        self.setRocketButton()
    }
        
    func configYoutubePlayer() {
        self.youtubePlayerView.setShadow(view: self.youtubePlayerView)
        self.youtubePlayerView.clipsToBounds = true
        self.youtubePlayerView.layer.cornerRadius = 10
        self.youtubePlayerView.setBorder(view: self.youtubePlayerView)
        
        self.youtubePlayerView.delegate = self
        _ = viewModel?.videoURL.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
    }
    
    func setMapLocation() {
        if viewModel?.launchesData?.isEmpty == true {
            self.locationMap.removeFromSuperview()
        } else {
            let lat = (viewModel?.latitude as? NSString)?.doubleValue
            let lon = (viewModel?.longitude as? NSString)?.doubleValue
            let center = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.locationMap.setRegion(region, animated: true)
            self.rocketLabel.text = viewModel?.rocketName
        }
    }
    
    func setRocketButton() {
        if viewModel?.launchesData?.isEmpty == true {
            self.rocketView.removeFromSuperview()
            self.titleMissionLabel.removeFromSuperview()
            self.padView.removeFromSuperview()
            self.launchPadView.removeFromSuperview()
            self.missionDescription.removeFromSuperview()
            self.separatorPad.removeFromSuperview()
            self.separatorMission.removeFromSuperview()
            self.eventsImageView.removeFromSuperview()
        } else {
            self.rocketLabel.text = viewModel?.rocketName
            self.titleMissionLabel.text = viewModel?.missionName
            self.padView.removeFromSuperview()
            self.launchCountInt.text = "\(viewModel?.padLaunchCount ?? 0)"
            self.missionDescription.text = viewModel?.missionDescription
            self.eventsImageView.sd_setImage(with: URL(string: viewModel?.missionImage ?? ""))
        }
    }
}

extension EventsItem: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youtubePlayerView.playVideo()
    }
}
