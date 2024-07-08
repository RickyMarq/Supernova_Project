//
//  ViewController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import SwiftUI
import SDWebImage
import SkeletonView
import GoogleMobileAds

class HomeController: UIViewController {
    
    var homeScreen: HomeScreen?
    var viewModel: HomeViewModel = HomeViewModel(services: HomeServices())
    var alerts: Alerts?
    var statusbarView: UIView?
        
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = HomeViewModel(services: HomeServices())
        viewModel.delegate(delegate: self)
        self.alerts = Alerts(controller: self)
        self.homeScreen?.homeCollectionViewProtocols(delegate: self, dataSource: self)
        self.getCompositionalLayout()
     
        // N ta funcionando.
     //   viewModel.getLastLaunches(limit: 10)
     //   viewModel.getFutureLaunches(limit: 15, startsAt: 0)
                
     //   viewModel.getLastEvents(limit: 10, startsAt: 0)
     //   viewModel.getLastPicturesOfTheDays(limit: 7)
     //     viewModel.getPictureOfTheDay()

        //
        
    //   viewModel.getNews(limit: 15, startsAt: 0)
    //    viewModel.getNextLaunch(limit: 1, startsAt: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Home"
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.deleteNotifications()
        self.navigationController?.navigationBar.tintColor = .primaryColour
    }
    
    func deleteNotifications() {
        if viewModel.isOn == false {
            print("User doest allow notification anymore")
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func showSkeleton() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.homeScreen?.homeCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
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

extension HomeController: HomeViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.homeScreen?.homeCollectionView.reloadData()
            self.homeScreen?.stopSkeletonAnimation()
            self.homeScreen?.homeCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    func failure(error: String) {
        DispatchQueue.main.async {
            self.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
        }
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch indexPath.section {
            
        case 2:
            return ExploreCollectionCell.identifier
        case 3:
            return ExploreCollectionCell.identifier
        case 4:
            return NewsCollectionCell.identifier
            
        default: return ExploreCollectionCell.identifier
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return 1
        case 1:
            return viewModel.buttonsCount
        case 2:
            return viewModel.nextLaunchCount
        case 3:
            return viewModel.futureLauchesCount
        case 4:
            return 1
        case 5:
            return viewModel.lastLaunchesCount
        case 6:
            return viewModel.newsCount
        case 7:
            return viewModel.eventsCount
        case 8:
            return viewModel.picturesOfTheDaysCount
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCellImage.identifier, for: indexPath) as? HomeCollectionCellImage else {return UICollectionViewCell()}
            guard let unwrapped = viewModel.pictureOfTheDayImage else {return cell}
            cell.pictureOfTheDayImageView.hideSkeleton()
            cell.configCell(with: unwrapped)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionCell.identifier, for: indexPath) as? ButtonCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.buttonsIndexPath(indexPath: indexPath))
            cell.backgroundColor = .primaryColour.withAlphaComponent(0.3)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingLaunchCell.identifier, for: indexPath) as? UpcomingLaunchCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.nextLaunchIndexPath(indexPath: indexPath))
            cell.startCountdown(data: viewModel.nextLaunchIndexPath(indexPath: indexPath))
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.futureLauchesIndexPath(indexPath: indexPath))
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAdCell.identifier, for: indexPath) as? HomeAdCell else {return UICollectionViewCell()}
            cell.backgroundColor = .clear
            cell.adsView.rootViewController = self
            cell.adsView.load(GADRequest())
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.lastLauchesIndexPath(indexPath: indexPath))
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.newsIndexPath(indexPath: indexPath))
            cell.backgroundColor = .tertiarySystemBackground
            cell.newsProviderLabel.isHidden = false
            return cell
            
        case 7:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else {return UICollectionViewCell()}
            cell.configCell(with: viewModel.eventsIndexPath(indexPath: indexPath))
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case 8:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesOfTheDaysCell.identifier, for: indexPath) as? PicturesOfTheDaysCell else {return UICollectionViewCell()}
            cell.newsImageView.sd_setImage(with: URL(string: viewModel.picturesOfTheDays(indexPath: indexPath).url ?? ""))
            cell.pictureOfTheDayLabel.text = viewModel.picturesOfTheDays(indexPath: indexPath).title
            return cell
        default: break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            guard let unwrapped = viewModel.pictureOfTheDayImage else {return}
            let vc = ImageViewerController(imageViewerViewModel: ImageViewerViewModel(data: unwrapped))
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 1:
            switch indexPath.item {
            case 0:
                self.navigationController?.pushViewController(LaunchesController(index: 0), animated: true)
            case 1:
                self.navigationController?.pushViewController(NewsController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(EventsController(), animated: true)
            case 3:
                let vc = NasaObservatoryView()
                let host = UIHostingController(rootView: vc)
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationController?.pushViewController(host, animated: true)
            default: break
            }
            
        case 2:
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: viewModel.nextLaunchIndexPath(indexPath: indexPath)))
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: viewModel.futureLauchesIndexPath(indexPath: indexPath)))
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: viewModel.lastLauchesIndexPath(indexPath: indexPath)))
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            self.openSafariPageWith(url: viewModel.newsIndexPath(indexPath: indexPath).url ?? "Error")
        case 7:
            let vc = EventsItem(viewModel: EventsItemViewModel(events: viewModel.eventsIndexPath(indexPath: indexPath)))
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = ImageViewerController(imageViewerViewModel: ImageViewerViewModel(data: viewModel.picturesOfTheDays(indexPath: indexPath)))
            self.present(vc, animated: true)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            switch indexPath.section {
                
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleReusable.identifier, for: indexPath) as? TitleReusable
                header?.titleCollectionLabel.text = "Explore"
                return header ?? UICollectionReusableView()
            case 2:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleReusable.identifier, for: indexPath) as? TitleReusable
                header?.titleCollectionLabel.text = "Next Launch"
                return header ?? UICollectionReusableView()
            case 4:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleReusable.identifier, for: indexPath) as? TitleReusable
                header?.titleCollectionLabel.text = "Ad"
                return header ?? UICollectionReusableView()
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Future Lauches"
                header?.seeAllButton.tag = 2
                header?.lastUpdatedLabel.isHidden = false
                header?.lastUpdatedLabel.text = "Last Updated at \(viewModel.lastUpdated)"
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 5:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Past Launches"
                header?.seeAllButton.tag = 3
                header?.lastUpdatedLabel.isHidden = true
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 6:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Last News"
                header?.seeAllButton.tag = 4
                header?.lastUpdatedLabel.isHidden = true
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 7:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 5
                header?.titleCollectionLabel.text = "Last Events"
                header?.lastUpdatedLabel.isHidden = true
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 8:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 6
                header?.lastUpdatedLabel.isHidden = true
                header?.titleCollectionLabel.text = "Nasa Observatory"
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            default: break
            }
        default:
            break
        }
        return UICollectionReusableView()
    }
    
}

func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    
    switch indexPath.section {
        
    case 1:
        guard let cell = collectionView.cellForItem(at: indexPath) as? ButtonCollectionCell else {return}
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 2:
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpcomingLaunchCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 3:
        guard let cell = collectionView.cellForItem(at: indexPath) as? LaunchesCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 4:
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeAdCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 5:
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 6:
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    case 7:
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
        
    case 8:
        guard let cell = collectionView.cellForItem(at: indexPath) as? PicturesOfTheDaysCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    default: break
    }
}

func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    
    switch indexPath.section {
        
    case 1:
        guard let cell = collectionView.cellForItem(at: indexPath) as? ButtonCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
        
    case 2:
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpcomingLaunchCell else {return}
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    case 3:
        guard let cell = collectionView.cellForItem(at: indexPath) as? LaunchesCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    case 4:
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeAdCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    case 5:
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    case 6:
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
            
        }
    case 7:
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
        
    case 8:
        guard let cell = collectionView.cellForItem(at: indexPath) as? PicturesOfTheDaysCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    default: break
    }
}

extension HomeController: TitleCollectionProtocol {
    
    func seeAllAction(reusable: TitleCollection) {
        
        switch reusable.seeAllButton.tag {
            
        case 2:
            self.navigationController?.pushViewController(LaunchesController(index: 0), animated: true)
        case 3:
            self.navigationController?.pushViewController(LaunchesController(index: 1), animated: true)
        case 4:
            let vc = NewsController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = EventsController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = NasaObservatoryView()
            self.navigationController?.navigationBar.prefersLargeTitles = true
            let host = UIHostingController(rootView: vc)
            self.navigationController?.pushViewController(host, animated: true)
        default: break
        }
    }
}
