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
        self.title = events?.name
        self.configYoutubePlayer()
        

    }
    
    func configYoutubePlayer() {
        self.youtubePlayer.delegate = self
        let trimmed = events?.videoURL?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        self.youtubePlayer.load(withVideoId: "\(trimmed ?? "")")
//        self.youtubePlayer.loadVideo(byURL: "https://www.youtube.com/watch?v=bsM1qdGAVbU&ab_channel=iOSAcademy", startSeconds: 1.0)
    }
    

}

extension EventsItem: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.youtubePlayer.playVideo()
    }
}
