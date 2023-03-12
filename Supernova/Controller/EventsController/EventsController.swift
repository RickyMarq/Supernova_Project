//
//  EventsController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/02/23.
//

import UIKit
import SkeletonView

class EventsController: UIViewController {
    
    var alerts: Alerts?
    var eventsScreen: EventsScreen?
    var events = [ResultedEvents]()
    var page: Int = 10
    
    override func loadView() {
        self.eventsScreen = EventsScreen()
        self.view = eventsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.eventsScreen?.eventsCollectionViewProtocols(delegate: self, dataSource: self)
        self.getLastEvents(limit: 15, startsAt: 0)
    }
    
    func configNavigationController() {
        self.title = "Events"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configNavigationController()
        events.isEmpty ? showSkeletonView() : updateOnTheMainThread()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func updateOnTheMainThread() {
        DispatchQueue.main.async {
            self.eventsScreen?.eventsCollectionView.reloadData()
        }
    }
    
    func showSkeletonView() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.eventsScreen?.eventsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
    }
    
    func getLastEvents(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getLastEvents(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.events = model ?? []
                
                DispatchQueue.main.async {
                    strongSelf.eventsScreen?.eventsCollectionView.reloadData()
                    strongSelf.eventsScreen?.stopSkeletonAnimation()
                    strongSelf.eventsScreen?.eventsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }
                
            case .failure(let error):
                guard let strongSelf = self else {return}
                DispatchQueue.main.async {
                    strongSelf.alerts?.getAlert(title: "Error", message: "Error: \(error)", buttonMessage: "Cancel")
                }
            }
        }
    }
    
   
}

extension EventsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return NewsCollectionCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
        let index = events[indexPath.row]
        cell.newsImageView.sd_setImage(with: URL(string: index.featureImage ?? ""))
        cell.newsNameLabel.text = index.name
        cell.newsDescriptionLabel.text = index.description
        cell.backgroundColor = .secondarySystemBackground
        cell.newsDateLabel.text = index.location
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // -> Original
 //       return CGSize(width: UIScreen.main.bounds.width - 28, height: 420)
        
        return CGSize(width: UIScreen.main.bounds.width - 28, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EventsItem(events: events[indexPath.item])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    }
}
