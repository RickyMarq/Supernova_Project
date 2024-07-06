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
    var viewModel: EventViewModel?
    var page: Int = 0
    
    override func loadView() {
        self.eventsScreen = EventsScreen()
        self.view = eventsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = EventViewModel(service: EventsServices())
        self.viewModel?.delegate(delegate: self)
        self.alerts = Alerts(controller: self)
        self.eventsScreen?.delegate(delegate: self)
        self.eventsScreen?.eventsCollectionViewProtocols(delegate: self, dataSource: self)
        self.viewModel?.getEventsData()
//        self.getLastEvents(limit: 15, startsAt: 0)
    }
    
    func configNavigationController() {
        self.title = "Events"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configNavigationController()
        viewModel?.eventsData.isEmpty ?? false ? showSkeletonView() : updateOnTheMainThread()
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
                strongSelf.events.append(contentsOf: model ?? [])
                
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

extension EventsController: EventsScreenProtocols {
    
    func pullToRefreshAction() {
        DispatchQueue.main.async {
            self.events = []
            self.getLastEvents(limit: 15, startsAt: 0)
            self.showSkeletonView()
            self.eventsScreen?.pullToRefresh.endRefreshing()
        }
    }
}

extension EventsController: EventsViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.eventsScreen?.eventsCollectionView.reloadData()
            self.eventsScreen?.stopSkeletonAnimation()
            self.eventsScreen?.eventsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    func failure(error: String) {
        alerts?.getAlert(title: "Error occurred", message: "\(error)", buttonMessage: "Cancel")
    }
}

extension EventsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return EventsCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else {return UICollectionViewCell()}
        guard let data = viewModel?.indexPath(indexPath: indexPath) else {return.init()}
        cell.configCell(with: data)
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // -> Original
        // return CGSize(width: UIScreen.main.bounds.width - 28, height: 420)
        return CGSize(width: UIScreen.main.bounds.width - 28, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel?.indexPath(indexPath: indexPath) else {return}
        let vc = EventsItem(viewModel: EventsItemViewModel(events: data))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - 350
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 16
            self.getLastEvents(limit: 15, startsAt: page)
            
        }
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
