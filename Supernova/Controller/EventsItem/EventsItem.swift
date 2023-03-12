//
//  EventsController.swift
//  Supernova
//
//  Created by Henrique Marques on 13/02/23.
//

import UIKit
import YouTubeiOSPlayerHelper

class EventsItem: UIViewController {
    
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    var events: ResultedEvents?
    
    init(events: ResultedEvents) {
        self.events = events
        super.init(nibName: "EventsScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.configYoutubePlayer()
        self.titleLabel.text = events?.name
        self.summaryLabel.text = events?.description
        self.eventsImageView.sd_setImage(with: URL(string: events?.featureImage ?? ""))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configCustomNavigationController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func configYoutubePlayer() {
        print(events?.videoURL)
        self.youtubePlayerView.delegate = self
        let trimmed = events?.videoURL?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        self.youtubePlayerView.load(withVideoId: "\(trimmed ?? "")")
//        self.youtubePlayer.loadVideo(byURL: "https://www.youtube.com/watch?v=bsM1qdGAVbU&ab_channel=iOSAcademy", startSeconds: 1.0)
    }
    
    func configCustomNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundColour
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    

}

extension EventsItem: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youtubePlayerView.playVideo()
    }
}
