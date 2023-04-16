//
//  NewsController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit
import SkeletonView
import GoogleMobileAds
import SafariServices

class NewsController: UIViewController {
    
    var newsScreen: NewsScreen?
    var page: Int = 0
    var news: [ResultedNewsSite] = []
//    var filterNews: [ResultedNewsSite] = []
    
    var newsSpaceRequested = false
    
    var arrAdUnitID: [String] = ["ca-app-pub-3940256099942544/2934735716"]
    
    var currentIndexForAd = 5
    
    var currentIndexForNormalRow = 2

    override func loadView() {
        self.newsScreen = NewsScreen()
        self.view = newsScreen
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       self.getCompositionalLayout()
        self.configNavigationController()
        self.newsScreen?.delegate(delegate: self)
        self.newsScreen?.newsCollectionViewProtocols(delegate: self, dataSouce: self)
        self.showSkeleton()
        self.getFistNews(limit: 15, startAt: 0)
        
        
    }
    
    func configNavigationController() {
        self.title = "Last News"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
//        let btn = UIBarButtonItem(customView: self.newsScreen?.savedNewsButton ?? UIView())

        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: nil)
        
        let menu = configButtonContextMenu()
        if #available(iOS 14.0, *) {
            filterBarButton.menu = menu
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.setRightBarButtonItems([filterBarButton], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        news.isEmpty ? showSkeleton() : updateOnTheMainThread()
    }
    
    func updateOnTheMainThread() {
        self.newsScreen?.newsCollectionView.reloadData()
    }
    
    func showSkeleton() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.newsScreen?.newsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
    }
    
    func configButtonContextMenu() -> UIMenu {
        let defaultProvider = UIAction(title: "All") { _ in
            self.news = []
            self.getFistNews(limit: 15, startAt: 0)
            self.showSkeleton()
        }
        
        let ArstechnicaProvider = UIAction(title: "Arstechnica", image: nil) { (_) in
             self.news = []
             self.getNewsBySite(startAt: 0, NewsSite: "Arstechnica")
             self.showSkeleton()
        }
        
        let CNBCProvider = UIAction(title: "CNBC", image: nil) { (_) in
             self.news = []
             self.getNewsBySite(startAt: 0, NewsSite: "CNBC")
             self.showSkeleton()
        }
        
        let SpaceNewsProvider = UIAction(title: "SpaceNews", image: nil) { (_) in
             self.news = []
             self.getNewsBySite(startAt: 0, NewsSite: "SpaceNews")
             self.showSkeleton()
        }
        
        
        let menu = UIMenu(title: "News Provider", image: nil, identifier: nil, options: .displayInline, children: [defaultProvider, ArstechnicaProvider, CNBCProvider, SpaceNewsProvider])
        
        return menu
    }
    
    func addBannerAds() {

        self.newsScreen?.newsCollectionView.layoutIfNeeded()
//        while index < news.count {
         
//            let adSize = GADAdSizeFromCGSize(
//                   CGSize(width: tableView.contentSize.width, height: adViewHeight))
//                 let adView = GADBannerView(adSize: adSize)
//                 adView.adUnitID = adUnitID
//                 adView.rootViewController = self
//                 adView.delegate = self
//             news.insert(adView, at: index)
        }

    
    func getFistNews(limit: Int, startAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFirstArticles(limit: limit, startsAt: startAt) { result in
            
            switch result {
                
            case .success(let model):
                self.news.append(contentsOf: model ?? [])
                                
                DispatchQueue.main.async {
                    self.newsScreen?.stopSkeletonAnimation()
                    self.newsScreen?.newsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.newsScreen?.newsCollectionView.reloadData()
                }
                
            case .failure(let _):
                print("Error")
            }
        }
    }
    
    func getMoreNews(limit: Int, startAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFirstArticles(limit: limit, startsAt: startAt) { result in
            
            switch result {
                
            case .success(let model):
                self.news.append(contentsOf: model ?? [])
                
                                
                DispatchQueue.main.async {
//                    let contentHeight = self.newsScreen?.newsCollectionView.collectionViewLayout.collectionViewContentSize.height
//                    self.newsScreen?.newsCollectionView.contentSize = CGSize(width: (self.newsScreen?.newsCollectionView.frame.width)!, height: contentHeight!)
//                    print("DEBUG MODE Content Height -> \(contentHeight)")
//                    self.newsScreen?.stopSkeletonAnimation()
//                    self.newsScreen?.newsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.newsScreen?.newsCollectionView.reloadData()
                }
                
            case .failure(let _):
                print("Error")
            }
        }
    }
    
    func getNewsBySite(startAt: Int, NewsSite: String) {
        SpaceDevsInternetServices.sharedObjc.getArticlesByNewsSite(startsAt: startAt, newsSite: NewsSite) { result in
            
            switch result {
                
            case .success(let model):
                self.news.append(contentsOf: model)

                DispatchQueue.main.async {
                    self.newsScreen?.stopSkeletonAnimation()
                    self.newsScreen?.newsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self.newsScreen?.newsCollectionView.reloadData()
                }
                
            case .failure(let _):
                print("DEBUG MODE: Error News By Site")

            }
        }
    }
}

extension NewsController: NewsScreenProtocols {
   
    func savedButtonAction() {
    
    }
   
    func pullToRefreshAction() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.newsScreen?.newsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
        self.news = []
        self.getFistNews(limit: 15, startAt: 0)
        self.newsScreen?.pullToRefresh.endRefreshing()
    }
    
    
}

extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDelegate {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let adCount = news.count / currentIndexForAd
//        return news.count + adCount
        //       return news.count  + news.count/9 + 1
//        let adCellCount = (news.count - 1) / 5
//        print("DEBUG MODE News Count ->  \(news.count)")
//        print("DEBUG MODE \(news.count + adCellCount)")
//        return news.count + adCellCount
        
        
        let contentCellsCount = news.count - (news.count / 6)
          
          if contentCellsCount % 5 == 0 {
              print("DEBUG MODE: News Count -> \(news.count)")
              return news.count
          } else {
              print("DEBUG MODE: News Count -> \(news.count)")

              return news.count  + 1
          }
        
    }
    
    
//    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        
        return NewsCell.identifier

//        if ((indexPath.item % 9) != 0) {
//            return AdsCollectionCell.identifier
//        } else {
//            return NewsCell.identifier
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       // ((indexPath.item - indexPath.item/9 - 1) != 0)
        
        // ((indexPath.item - indexPath.item/9 - 1) != 0)
        
        if (indexPath.item + 1) % 6 == 0 {
        
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as? AdsCollectionCell else {return UICollectionViewCell()}
            cell.adsUIView.addSubview(self.newsScreen?.adsView ?? UIView())
            cell.adsView.rootViewController = self
            cell.adsView.load(GADRequest())
            
//            if newsSpaceRequested == true {
//                let indexed = filterNews[indexPath.row]
//            } else {
//                let indexed = news[indexPath.row]
//            }
            
            
//            let indexed = newsSpaceRequested ? filterNews : news
//            let movies = indexed[indexPath.row]
            
//
//            cell.configCell(with: news[indexPath.row])
//            cell.backgroundColor = .secondarySystemBackground
            return cell
        } else {
            let contentCellIndexPath = IndexPath(item: indexPath.item - (indexPath.item + 1) / 6, section: indexPath.section)

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {return UICollectionViewCell()}
            cell.configCell(with: news[contentCellIndexPath.item])
            cell.backgroundColor = .secondarySystemBackground
            return cell
        }
        
//
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as? AdsCollectionCell else {return UICollectionViewCell()}
////            cell.adsUIView.addSubview(self.newsScreen?.adsView ?? UIView())
//            cell.adsView.rootViewController = self
//            cell.adsView.load(GADRequest())
//            cell.backgroundColor = .green
//            DispatchQueue.main.async {
//                self.newsScreen?.adCollectionView.reloadData()
//            }
            
//            return cell
//        default: break
        
        
        
//        if (indexPath.item % currentIndexForAd == 0) {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {return UICollectionViewCell()}
//            cell.configCell(with: news[indexPath.row])
//            return cell
//        } else {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as? AdsCollectionCell else {return UICollectionViewCell()}
//            cell.adsUIView.addSubview(self.newsScreen?.adsView ?? UIView())
//            return cell
//        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - 350
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 11
            self.getMoreNews(limit: 15, startAt: page)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width - 24, height: 420)
        
        switch collectionView.tag {
            
        case 1:
            return CGSize(width: UIScreen.main.bounds.width - 24, height: 420)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width - 24, height: 300)
        default: return CGSize(width: UIScreen.main.bounds.width - 24, height: 300)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentCellIndexPath = IndexPath(item: indexPath.item - (indexPath.item + 1) / 6, section: indexPath.section)
        let index = news[contentCellIndexPath.item]
        
        self.openSafariPageWith(url: index.url ?? "Error")
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(index: indexPath.row, objc: news[indexPath.item])
        }
    
    func configureContextMenu(index: Int, objc: ResultedNewsSite) -> UIContextMenuConfiguration {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let openWithSafari = UIAction(title: "Open with Safari", image: UIImage(systemName: "safari"), identifier: nil, discoverabilityTitle: nil) { _ in
                self.openSafariPageWith(url: objc.url ?? "")
                
                
    
                
            }
            
            return UIMenu(title: "Options", image: nil, identifier: nil, options: .displayInline, children: [openWithSafari])
        }
        
        return contextMenu
    }
    
    
    // TODO: RESOLVER FOOTER DEPOIS
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch collectionView.tag {

        case 1:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NewsFooterLoading.identifier, for: indexPath) as? NewsFooterLoading else {return UICollectionReusableView()}

            return footer

        default: break
        }


        return UICollectionReusableView()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 150)

    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//
//        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else {return}
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
//            cell.transform = .init(scaleX: 0.95, y: 0.95)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else {return}
//
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
//            cell.transform = .identity
//        }
//    }
}

//extension NewsController: GADAdLoaderDelegate {
//
//    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
//        print("Failed to receive ads")
//    }
//
//    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
//       // A native ad has loaded, and can be displayed.
//       self.nativeAds.append(nativeAd)
//    }
//
//}

extension NewsController {
    
    func getCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            switch sectionNumber {
            case 0:
                return LayoutType.newsLayout.getLayout()
            case 1:
                return LayoutType.adLayout.getLayout()
            default:
                return LayoutType.newsLayout.getLayout()
            }
        }
        self.newsScreen?.newsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}
