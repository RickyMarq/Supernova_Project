//
//  ViewController.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import SDWebImage
import SkeletonView

class HomeController: UIViewController {
    
    var homeScreen: HomeScreen?
    var alerts: Alerts?
    var objc = [UpcomingModel]()
    var lastLauchesObjc = [ResultedModel]()
    var futureLauchesObjc = [ResultedModel]()
    var news = [NewsModel]()
    var events = [ResultedEvents]()
    var pictureOfTheDay: PictureOfTheDay?
    var buttonsModel = HomeSectionButtonsModel().populateModel()
    var picturesOfTheDays = [PictureOfTheDay]()
        
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.getPictureOfTheDay()
        self.navigationController?.navigationBar.tintColor = .primaryColour
        self.getLastPicturesOfTheDays(limit: 5)
//        self.getUpcomingLaunches()
//        self.getLastLaunches(limit: 10)
//        self.getFutureLaunches(limit: 10)
//       self.getLastEvents(limit: 10)
        self.getNews(limit: 15)
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
                    self.alerts?.getAlert(title: "Error", message: "Error trying to fetch data, try again", buttonMessage: "Cancel")
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
            }
        }
    }
    func getFutureLaunches(limit: Int) {
        SpaceDevsInternetServices.sharedObjc.getFutureLauches(limit: limit) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.futureLauchesObjc = model ?? []
                
                DispatchQueue.main.async {
                    strongSelf.homeScreen?.homeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
    func getNews(limit: Int) {
        SpaceDevsInternetServices.sharedObjc.getFirstArticles(limit: limit, startsAt: 0) { [weak self] result in
            
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
            }
        }
    }
    func getLastEvents(limit: Int) {
        SpaceDevsInternetServices.sharedObjc.getLastEvents(limit: limit) { [weak self] result in
            
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
                    strongSelf.alerts?.getAlert(title: "Error", message: "Error: \(error)", buttonMessage: "Cancel")
                }
            }
        }
    }
}



extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return 1
        case 1:
            return buttonsModel.count
        case 2:
            return futureLauchesObjc.count
        case 3:
            return lastLauchesObjc.count
        case 4:
            return news.count
        case 5:
            return picturesOfTheDays.count
        case 6:
            return events.count
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
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: futureLauchesObjc[indexPath.row])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: lastLauchesObjc[indexPath.row])
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
            cell.configCell(with: news[indexPath.row])
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesOfTheDaysCell.identifier, for: indexPath) as? PicturesOfTheDaysCell else {return UICollectionViewCell()}
            cell.newsImageView.sd_setImage(with: URL(string: picturesOfTheDays[indexPath.row].url ?? ""))
            cell.pictureOfTheDayLabel.text = picturesOfTheDays[indexPath.row].title
            return cell
            
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.identifier, for: indexPath) as? NewsCollectionCell else {return UICollectionViewCell()}
            cell.configCellEvents(with: events[indexPath.row])
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
            self.present(vc, animated: true)
        case 1:
            
            switch indexPath.item {
            case 0:
                self.navigationController?.pushViewController(WhatsNewController(), animated: true)
            case 1:
                let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
                impactFeedbackgenerator.prepare()
                impactFeedbackgenerator.impactOccurred()
                self.navigationController?.pushViewController(NewsController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(EventsController(), animated: true)
            case 3:
                print("TODO: APRESENTAR VC")
            default: break
            }
        
        case 2:
            let vc = LauchesController(lauches: lastLauchesObjc[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = LauchesController(lauches: futureLauchesObjc[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            self.openSafariPageWith(url: news[indexPath.row].url ?? "Error")
        case 5:
            let vc = ImageViewerController(data: picturesOfTheDays[indexPath.row])
            self.present(vc, animated: true)
        case 6:
            let vc = EventsItem(events: events[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Explore"
                return header ?? UICollectionReusableView()
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Explore"
                header?.seeAllButton.tag = 1
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 2:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Future Lauches"
                header?.seeAllButton.tag = 2
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Past Launches"
                header?.seeAllButton.tag = 3
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 4:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.titleCollectionLabel.text = "Last News"
                header?.seeAllButton.tag = 4
                header?.delegate(delegate: self)
                return header ?? UICollectionReusableView()
            case 5:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 5
                header?.titleCollectionLabel.text = "Pictures Of The Day"
                return header ?? UICollectionReusableView()
            case 6:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollection.identifier, for: indexPath) as? TitleCollection
                header?.seeAllButton.tag = 6
                header?.titleCollectionLabel.text = "Last Events"
                return header ?? UICollectionReusableView()
            default: break
            }
        case UICollectionView.elementKindSectionFooter:
            if indexPath.section == 5 {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageControlFooter.identifier, for: indexPath) as? PageControlFooter else {return UICollectionReusableView()}
//                footer.backgroundColor = .red
                footer.homePageControl.numberOfPages = 5
                footer.homePageControl.currentPage = ind
                return footer
            }
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    // TODO Implementar page control funcionando corretamente.
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let pictureCell = cell as? PicturesOfTheDaysCell else {return}
        
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        self.ind = index
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let pictureCell = cell as? PageControlFooter else {return}
        
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    }

    
}

extension HomeController: TitleCollectionProtocol {
    
    func seeAllAction(reusable: TitleCollection) {
        
        switch reusable.seeAllButton.tag {
            
        case 0:
            print("APRESENTAR VC EXPLORE")
        case 1:
            print("APRESENTAR VC FUTURE LAUCHES")
        case 2:
            print("APRESENTAR VC PASR LAUCHES")
        case 3:
            print("APRESENTAR VC PASR LAUCHES")
        case 4:
            let vc = NewsController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            print("APRESENTAR VC PICTURE OF THE DAY")
        case 6:
            let vc = EventsController()
            self.navigationController?.pushViewController(vc, animated: true)
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
                return LayoutType.future.getLayout()
            case 3:
                return LayoutType.LastLauchesLayout.getLayout()
            case 4:
                return LayoutType.tableLayout.getLayout()
            case 5:
                return LayoutType.pictureOfTheDay.getLayout()
            case 6:
                return LayoutType.tableLayout.getLayout()
            default:
                return LayoutType.tableLayout.getLayout()
            }
        }
        self.homeScreen?.homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}
