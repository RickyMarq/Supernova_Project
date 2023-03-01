//
//  EventsController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/02/23.
//

import UIKit

class EventsController: UIViewController {
    
    var eventsScreen: EventsScreen?
    var events = [ResultedEvents]()
    var page: Int = 10
    
    override func loadView() {
        self.eventsScreen = EventsScreen()
        self.view = eventsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventsScreen?.eventsCollectionViewProtocols(delegate: self, dataSource: self)
        self.configNavigationController()
    }
    
    func configNavigationController() {
        self.title = "Events"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
   
}

extension EventsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {return UICollectionViewCell()}
        return cell
    }
}
