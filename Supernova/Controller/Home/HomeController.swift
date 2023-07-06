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

    
//    typealias Datasource = UICollectionViewDiffableDataSource<Int,PagingInfo>
//    let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
//    private var datasource: Datasource!

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
        // DEBUG MODE: Deixando os métodos aqui para não sobrecarregar a api.
        
//        self.getUpcomingLaunches()
        
        
//        self.getLastLaunches(limit: 10)
//        self.getFutureLaunches(limit: 15, startsAt: 0)
//        self.getLastEvents(limit: 10, startsAt: 0)
        self.getLastPicturesOfTheDays(limit: 7)
//        self.getNews(limit: 15, startsAt: 0)
        
        
        self.getRockets()
        self.getPictureOfTheDay()

        // No deploy não esquece de voltar para 0 !!!
       self.getNextLaunch(limit: 1, startsAt: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Home"
        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.delegate = self
//        self.configCustomNavigationController()
        
  //      self.showSkeleton()
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
                
                
            case .failure(let model):
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
                print("DEBUG MODE \(model)")
                
                self.rocketsObjc = model ?? []
                
                DispatchQueue.main.async {
                    self.homeScreen?.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
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
                
                // TODO: NOTIFICAÇÃO
                
                // TODO: Quando o usuário ativa as ntfs depois, ele não entrega, resolver isto na 1.0.4.
                
                
                if strongSelf.isOn == true {
                    print("DEBUG MODE: NTF HAS SCHEDULE")
                    let fullHours = convertHoursForCountDownLaunchesFormatter(strongSelf.nextLaunchObjc[0].windowStart ?? "", outPut: "HH:mm:ss")
                    print("DEBUG MODE FULLHOURS: \(fullHours)")
                    let timeInterval = fullHours.timeIntervalSince(Date())
                    print("DEBUG MODE: TIME INTERVEL (DATE ALREADY COMPARED \(timeInterval)")
                    let convertion = Int(timeInterval)
                    print("DEBUG MODE CONVERTION: \(convertion)")
                    let identifier = strongSelf.nextLaunchObjc[0].name
                    let notificationTrigger = convertion - 3600
                    print("DEBUG MODE: INT NTF TRIGGER \(notificationTrigger)")
                    print("DEBUG MODE: DOUBLE NTF TRIGGER \(Double(notificationTrigger).rounded())")
                    
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
//                strongSelf.nextLaunchObjc.append(model?.first ?? <#default value#>)
                
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
                
                
            case .failure(let error):
                guard let strongSelf = self else {return}
                DispatchQueue.main.async {
                    self?.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again later", buttonMessage: "Cancel")
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
    
}

//extension HomeController: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if tabBarController.selectedIndex == 0 {
//            if let index = tabBarController.viewControllers?.firstIndex(of: viewController),  let tabView = tabBarController.tabBar.subviews[index+1] as? UIControl {
//                let label = tabView.subviews.compactMap { $0 as? UILabel }.first
//                if let label = label {
//                    UIView.animate(withDuration: 0.2) {
//                        label.transform = CGAffineTransform(translationX: 0, y: -5)
//                        label.alpha = 0
//                    } completion: { _ in
//                        UIView.animate(withDuration: 0.2) {
//                            label.transform = .identity
//                            label.alpha = 1
//                        }
//                    }
//                }
            
//            self.getSoftFeedbackGenerator()
 //           self.homeScreen?.homeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        } else if tabBarController.selectedIndex == 1 {
//            if let index = tabBarController.viewControllers?.firstIndex(of: viewController), let tabView = tabBarController.tabBar.subviews[index+1] as? UIControl {
//                let label = tabView.subviews.compactMap { $0 as? UILabel }.first
//                if let label = label {
//                    UIView.animate(withDuration: 0.2) {
//                        label.transform = CGAffineTransform(translationX: 0, y: -5)
//                        label.alpha = 0
//                    } completion: { _ in
//                        UIView.animate(withDuration: 0.2) {
//                            label.transform = .identity
//                            label.alpha = 1
//                        }
//                    }
//                }
//            }
//            self.getSoftFeedbackGenerator()
//       }
//    }
//}

extension HomeController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        if scrollView.contentOffset.y > -scrollView.contentInset.top + 300 {
            // user has scrolled past the top of the scroll view
            // your desired background color
            UIView.animate(withDuration: 0.3) {
                if #available(iOS 13.0, *) {
                    let app = UIApplication.shared
                    let statusBarHeight: CGFloat = app.statusBarFrame.size.height

                    let newStatusBarView = UIView()
                    newStatusBarView.backgroundColor = UIColor.secondarySystemBackground
                    self.view.addSubview(newStatusBarView)

                    newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                    newStatusBarView.heightAnchor
                        .constraint(equalToConstant: statusBarHeight).isActive = true
                    newStatusBarView.widthAnchor
                        .constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                    newStatusBarView.topAnchor
                        .constraint(equalTo: self.view.topAnchor).isActive = true
                    newStatusBarView.centerXAnchor
                        .constraint(equalTo: self.view.centerXAnchor).isActive = true
                        self.statusbarView?.removeFromSuperview()
                        self.statusbarView = newStatusBarView
           
                } else {
                    let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                    statusBar?.backgroundColor = UIColor.black
                }
            }
        } else {
            // user has scrolled back to the top of the scroll view
        
            UIView.animate(withDuration: 0.3) {
                if #available(iOS 13.0, *) {
                    let app = UIApplication.shared
                    let statusBarHeight: CGFloat = app.statusBarFrame.size.height

                    let newStatusBarView = UIView()
                    newStatusBarView.isOpaque = false
                    let color = UIColor.red.withAlphaComponent(0.1)
                    newStatusBarView.backgroundColor = .clear
                    self.view.addSubview(newStatusBarView)

                    newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                    newStatusBarView.heightAnchor
                        .constraint(equalToConstant: statusBarHeight).isActive = true
                    newStatusBarView.widthAnchor
                        .constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                    newStatusBarView.topAnchor
                        .constraint(equalTo: self.view.topAnchor).isActive = true
                    newStatusBarView.centerXAnchor
                        .constraint(equalTo: self.view.centerXAnchor).isActive = true

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
        return 8
        
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
            return lastLauchesObjc.count
        case 5:
            return news.count
        case 6:
            // Substituir por rockets...
            
            return rocketsObjc.count
 //           return events.count
        case 7:
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
            //            cell.configCell(with: futureLauchesObjc[indexPath.row])
            cell.configCell(with: futureLauchesObjc[indexPath.item])
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: lastLauchesObjc[indexPath.row])
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: news[indexPath.row])
            cell.backgroundColor = .tertiarySystemBackground
            cell.newsProviderLabel.isHidden = false
            return cell
        case 6:
            // Antes:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCell.identifier, for: indexPath) as? EventsCell else {return UICollectionViewCell()}
//            cell.configCell(with: events[indexPath.row])
//            cell.backgroundColor = .tertiarySystemBackground
            // Depois:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCollectionCell.identifier, for: indexPath) as? RocketCollectionCell else {return UICollectionViewCell()}
            cell.backgroundColor = .clear
            cell.configCell(with: rocketsObjc[indexPath.row])
            return cell
            
        case 7:
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
            let vc = ImageViewerController(data: unwrapped)
            //            self.navigationController?.pushViewController(vc, animated: true)
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
                alerts?.getAlert(title: "Coming Soon", message: "Nasa Observatory it's under construct.", buttonMessage: "Cancel")
                //                self.navigationController?.pushViewController(NasaObservatoryController(), animated: true)
            default: break
            }
            
        case 2:
            let vc = LaunchesItemController(lauches: nextLaunchObjc[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = LaunchesItemController(lauches: futureLauchesObjc[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = LaunchesItemController(lauches: lastLauchesObjc[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            self.openSafariPageWith(url: news[indexPath.row].url ?? "Error")
        case 6:
            //  Puxar item rocket
//            let vc = EventsItem(events: events[indexPath.row])
//            self.navigationController?.pushViewController(vc, animated: true)
//            let vc = RocketSupernovaController(rocketControllerData: rocketsObjc[indexPath.row])
//            self.navigationController?.pushViewController(vc, animated: true)
//
            let vc = RocketItemUI(data: rocketsObjc[indexPath.row])
            let hostingController = UIHostingController(rootView: vc)
            self.navigationController?.pushViewController(hostingController, animated: true)
        case 7:
            let vc = ImageViewerController(data: picturesOfTheDays[indexPath.row])
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
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Future Lauches"
                header?.seeAllButton.tag = 2
                header?.lastUpdatedLabel.isHidden = false
                header?.lastUpdatedLabel.text = "Last Updated at \(lastUpdated)"
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 4:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Past Launches"
                header?.seeAllButton.tag = 3
                header?.lastUpdatedLabel.isHidden = true
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 5:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Last News"
                header?.seeAllButton.tag = 4
                header?.lastUpdatedLabel.isHidden = true
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 6:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 5
//                header?.titleCollectionLabel.text = "Last Events"
                header?.titleCollectionLabel.text = "Rockets"
                header?.lastUpdatedLabel.isHidden = true
                return header ?? UICollectionReusableView()
            case 7:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 6
                header?.lastUpdatedLabel.isHidden = true
                header?.titleCollectionLabel.text = "Nasa Observatory"
                return header ?? UICollectionReusableView()
            default: break
            }
            
            //        case UICollectionView.elementKindSectionFooter:
            //            if indexPath.section == 6 {
            //                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageControlFooter.identifier, for: indexPath) as? PageControlFooter else {return UICollectionReusableView()}
            ////                footer.backgroundColor = .red
            //
            ////                let itemCount = self.datasource.snapshot().numberOfItems(inSection: indexPath.section)
            //                footer.numberOfItems(numberOfItems: self.picturesOfTheDays.count)
            //                footer.homePageControl.tag = 100
            //                print("DEBUG MODE: CRT PAGE \(footer.homePageControl.currentPage)")
            ////                footer.homePageControl.currentPage = 2
            //                return footer
            //            }
        default:
            break
        }
        return UICollectionReusableView()
    }
    
}
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("DEBUG MODE: DID END DECELERATING")
// //       let visibleRect = CGRect(origin: (self.homeScreen?.homeCollectionView.contentOffset)!, size: (self.homeScreen?.homeCollectionView.bounds.size)!)
////              let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
////               guard let indexPath = self.homeScreen?.homeCollectionView.indexPathForItem(at: visiblePoint) else {
////                   return
//               }
//
////                  if let footerView = self.homeScreen?.homeCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 6)),
////                     let pageControl = footerView.viewWithTag(100) as? UIPageControl {
////                        pageControl.currentPage = indexPath.row
//                }

        
    
    
    // TODO Implementar page control funcionando corretamente.
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let pictureCell = cell as? PicturesOfTheDaysCell else {return}
//
//        guard let visible = collectionView.visibleCells.last else {return}
//        guard let index = collectionView.indexPath(for: visible)?.row else {return}
//        self.ind = index
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let pictureCell = cell as? PageControlFooter else {return}
//
//        guard let visible = collectionView.visibleCells.last else {return}
//        guard let index = collectionView.indexPath(for: visible)?.row else {return}
//    }
    
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
            guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        case 4:
            guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        case 5:
            guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        case 6:
            guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        case 7:
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
            guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .identity
            }
        case 4:
            guard let cell = collectionView.cellForItem(at: indexPath) as? ExploreCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .identity
            }
        case 5:
            guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .identity
            }
        case 6:
            guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.transform = .identity
        
            }
        case 7:
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
            alerts?.getAlert(title: "Coming Soon", message: "Nasa Observatory it's under construct.", buttonMessage: "Cancel")
//            self.navigationController?.pushViewController(NasaObservatoryController(), animated: true)
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
                return LayoutType.LastLauchesLayout.getLayout()
            case 5:
                return LayoutType.tableLayout.getLayout()
            case 6:
//                return LayoutType.tableLayout.getLayout()
                return LayoutType.rocketLayout.getLayout()
            case 7:
                return LayoutType.pictureOfTheDay.getLayout()
            default:
                return LayoutType.tableLayout.getLayout()
            }
        }
        self.homeScreen?.homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}
