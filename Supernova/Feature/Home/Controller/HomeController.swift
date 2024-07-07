//
//  ViewController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import SwiftUI
import Combine
import SDWebImage
import SkeletonView
import GoogleMobileAds
import ActivityKit

class HomeController: UIViewController {
    
    var homeScreen: HomeScreen?
    var alerts: Alerts?
    var objc = [UpcomingModel]()
    var lastLauchesObjc = [ResultedModel]()
    var futureLauchesObjc = [ResultedModel]()
    var nextLaunchObjc = [ResultedModel]()
    var news = [ResultedNewsSite]()
    var events = [ResultedEvents]()
    var pictureOfTheDay: PictureOfTheDay?
    var buttonsModel = HomeSectionButtonsModel().populateModel()
    var picturesOfTheDays = [PictureOfTheDay]()
    var rocketsObjc = [SupernovaRocketModel]()
    
    var lastUpdated = ""
    var statusbarView: UIView?
    
    let isOn = UserDefaults.standard.bool(forKey: "PermissionForNotification")
    var ind: Int = 0
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.alerts = Alerts(controller: self)
        self.homeScreen?.homeCollectionViewProtocols(delegate: self, dataSource: self)
        self.getCompositionalLayout()
        self.showLauchscreenAnimation()
        
//        self.getLastLaunches(limit: 10)
//        self.getFutureLaunches(limit: 15, startsAt: 0)
//        self.getLastEvents(limit: 10, startsAt: 0)
//        self.getLastPicturesOfTheDays(limit: 7)
//        self.getNews(limit: 15, startsAt: 0)
//        self.getPictureOfTheDay()
//        self.getNextLaunch(limit: 1, startsAt: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Home"
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.deleteNotifications()
        self.navigationController?.navigationBar.tintColor = .primaryColour
    }
    
    func deleteNotifications() {
        if isOn == false {
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
    
    func showLauchscreenAnimation() {
        self.homeScreen?.LaunchingLottieAnimation.play { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.homeScreen?.LaunchingLottieAnimation.alpha = 0
            }, completion: { _ in
                self.homeScreen?.LaunchingLottieAnimation.isHidden = true
                DispatchQueue.main.async {
                    self.tabBarController?.tabBar.isHidden = false
                }
                self.homeScreen?.LaunchingLottieAnimation.removeFromSuperview()
            })
        }
    }
    
    
    func getUpcomingLaunches() {
        SpaceExInternetServices.sharedObjc.getPastLaunches { result in
            
            switch result {
                
            case .success(let model):
                self.objc = model ?? []
                
                DispatchQueue.main.async {
                    self.homeScreen?.homeCollectionView.reloadData()
                }
                
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getRockets() {
        SupernovaInternetServices.sharedObjc.getRockets { result in
            
            switch result {
                
            case .success(let model):
                
                self.rocketsObjc = model ?? []
                
                DispatchQueue.main.async {
                    self.homeScreen?.homeCollectionView.reloadData()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getPictureOfTheDay() {
        NasaInternetService.sharedObjc.getPictureOfTheDay { [weak self] picture, error in
            guard let strongSelf = self else {return}
            strongSelf.pictureOfTheDay = picture
            
            DispatchQueue.main.async {
                strongSelf.homeScreen?.homeCollectionView.reloadData()
                strongSelf.homeScreen?.stopSkeletonAnimation()
                strongSelf.homeScreen?.homeCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
    }
    
    func getLastPicturesOfTheDays(limit: Int) {
        NasaInternetService.sharedObjc.getLastPicturesOfTheDays(images: limit) { [weak self] pictures in
            
            switch pictures {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.picturesOfTheDays = model ?? []
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getLastLaunches(limit: Int) {
        SpaceDevsInternetServices.sharedObjc.getLastLauches(limit: limit) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.lastLauchesObjc = model ?? []
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                }
                
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getNextLaunch(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFutureLauches(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.nextLaunchObjc = model ?? []
                if strongSelf.isOn == true {
                    let fullHours = convertHoursForCountDownLaunchesFormatter(strongSelf.nextLaunchObjc[0].windowStart ?? "", outPut: "HH:mm:ss")
                    let timeInterval = fullHours.timeIntervalSince(Date())
                    let convertion = Int(timeInterval)
                    let identifier = strongSelf.nextLaunchObjc[0].name
                    let notificationTrigger = convertion - 3600
                    
                    if notificationTrigger <= 0 {
                        print("Time has passed")
                    } else {
                        NotificationController.sharedObjc.requestUpcomingLaunchNotification(title: "\(strongSelf.nextLaunchObjc[0].name ?? "") is almost launching", body: "Livestream is now available to come along and watch", timeInterval: Double(notificationTrigger).rounded(), identifier: identifier ?? "Default_Identifier")
                    }
                    
                    
                } else {
                    
                }
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getFutureLaunches(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFutureLauches(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.futureLauchesObjc = model ?? []
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                let formattedHour = formatter.string(from: Date())
                
                strongSelf.lastUpdated = formattedHour
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    
    func getNews(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFirstArticles(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.news = model ?? []
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                    strongSelf.homeScreen?.stopSkeletonAnimation()
                    strongSelf.homeScreen?.homeCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
    }
    func getLastEvents(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getLastEvents(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.events = model ?? []
                
                DispatchQueue.main.async {
                    self?.homeScreen?.homeCollectionView.reloadData()
                }
                
                
            case .failure(_):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
                }
            }
        }
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
    
    func startLiveActivity() {
        let activityData = HomeLaunchActivity.ContentState()
        
        let widgetData = HomeLaunchActivity(minutesLeft: 150, rocketName: "SpaceFlight 10")
        
        do {
            if #available(iOS 16.1, *) {
                let activity = try Activity<HomeLaunchActivity>.request(attributes: widgetData, contentState: activityData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension HomeController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let statusBarManager = view.window?.windowScene?.statusBarManager {
            let statusBarHeight = statusBarManager.statusBarFrame.height
            
            if scrollView.contentOffset.y > -scrollView.contentInset.top + 300 {
                UIView.animate(withDuration: 0.3) {
                    if #available(iOS 13.0, *) {
                        let newStatusBarView = UIView()
                        newStatusBarView.backgroundColor = UIColor.secondarySystemBackground
                        self.view.addSubview(newStatusBarView)
                        
                        newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                        newStatusBarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
                        newStatusBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                        newStatusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        newStatusBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        self.statusbarView?.removeFromSuperview()
                        self.statusbarView = newStatusBarView
                        
                    } else {
                        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                        statusBar?.backgroundColor = UIColor.black
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    if #available(iOS 13.0, *) {
                        let newStatusBarView = UIView()
                        newStatusBarView.isOpaque = false
                        newStatusBarView.backgroundColor = .clear
                        self.view.addSubview(newStatusBarView)
                        
                        newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                        newStatusBarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
                        newStatusBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                        newStatusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        newStatusBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        
                        self.statusbarView?.removeFromSuperview()
                        self.statusbarView = newStatusBarView
                    } else {
                        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                        statusBar?.backgroundColor = UIColor.clear
                    }
                }
            }
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
            return buttonsModel.count
        case 2:
            return nextLaunchObjc.count
        case 3:
            return futureLauchesObjc.count
        case 4:
            return 1
        case 5:
            return lastLauchesObjc.count
        case 6:
            return news.count
        case 7:
            return events.count
        case 8:
            return picturesOfTheDays.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCellImage.identifier, for: indexPath) as? HomeCollectionCellImage else {return UICollectionViewCell()}
            guard let unwrapped = pictureOfTheDay else {return cell}
            cell.pictureOfTheDayImageView.hideSkeleton()
            cell.configCell(with: unwrapped)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionCell.identifier, for: indexPath) as? ButtonCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: buttonsModel[indexPath.row])
            cell.backgroundColor = .primaryColour.withAlphaComponent(0.3)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingLaunchCell.identifier, for: indexPath) as? UpcomingLaunchCell else {return UICollectionViewCell()}
            cell.configCell(with: nextLaunchObjc[indexPath.item])
            cell.startCountdown(data: nextLaunchObjc[indexPath.item])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {return UICollectionViewCell()}
            cell.configCell(with: futureLauchesObjc[indexPath.item])
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAdCell.identifier, for: indexPath) as? HomeAdCell else {return UICollectionViewCell()}
            cell.backgroundColor = .clear
            cell.adsView.rootViewController = self
            cell.adsView.load(GADRequest())
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: lastLauchesObjc[indexPath.row])
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: news[indexPath.row])
            cell.backgroundColor = .tertiarySystemBackground
            cell.newsProviderLabel.isHidden = false
            return cell
            
        case 7:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else {return UICollectionViewCell()}
            cell.configCell(with: events[indexPath.row])
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case 8:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesOfTheDaysCell.identifier, for: indexPath) as? PicturesOfTheDaysCell else {return UICollectionViewCell()}
            cell.newsImageView.sd_setImage(with: URL(string: picturesOfTheDays[indexPath.row].url ?? ""))
            cell.pictureOfTheDayLabel.text = picturesOfTheDays[indexPath.row].title
            return cell
        default: break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            guard let unwrapped = pictureOfTheDay else {return}
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
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: nextLaunchObjc[indexPath.item]))
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: futureLauchesObjc[indexPath.item]))
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: lastLauchesObjc[indexPath.item]))
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            self.openSafariPageWith(url: news[indexPath.row].url ?? "Error")
        case 7:
            let vc = EventsItem(viewModel: EventsItemViewModel(events: events[indexPath.row]))
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = ImageViewerController(imageViewerViewModel: ImageViewerViewModel(data: picturesOfTheDays[indexPath.row]))
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
                // Tirar header... (AD)
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleReusable.identifier, for: indexPath) as? TitleReusable
                header?.titleCollectionLabel.text = "Ad"
                return header ?? UICollectionReusableView()
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Future Lauches"
                header?.seeAllButton.tag = 2
                header?.lastUpdatedLabel.isHidden = false
                header?.lastUpdatedLabel.text = "Last Updated at \(lastUpdated)"
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

extension HomeController {
    
    func getCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            
            switch sectionNumber {
            case 0:
                return LayoutType.ImageViewer.getLayout()
            case 1:
                return LayoutType.largeButtonsLayout.getLayout()
            case 2:
                return LayoutType.NextLaunchSection.getLayout()
            case 3:
                return LayoutType.future.getLayout()
            case 4:
                return LayoutType.adView.getLayout()
            case 5:
                return LayoutType.LastLauchesLayout.getLayout()
            case 6:
                return LayoutType.tableLayout.getLayout()
            case 7:
                return LayoutType.tableLayout.getLayout()
            case 8:
                return LayoutType.pictureOfTheDay.getLayout()
            default:
                return LayoutType.tableLayout.getLayout()
            }
        }
        self.homeScreen?.homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}
