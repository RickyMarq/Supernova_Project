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
    var page: Int = 10
    var news: [NewsModel] = []
    
    var arrAdUnitID: [String] = []
    var currentIndexForAdd = 0
    var currentIndexForNormalRow = 0

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
        self.getFistNews(limit: 15, startAt: 0)

    }
    
    func configNavigationController() {
        self.title = "News"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
//        let btn = UIBarButtonItem(customView: self.newsScreen?.savedNewsButton ?? UIView())
//        self.navigationItem.setRightBarButtonItems([btn], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSkeleton()
//        DispatchQueue.main.async {
//            self.newsScreen?.stopSkeletonAnimation()
//            self.newsScreen?.newsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
//        }
    }
    
    func showSkeleton() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.newsScreen?.newsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
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
}

extension NewsController: NewsScreenProtocols {
   
    func savedButtonAction() {
        let vc = SavedNewsController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    func pullToRefreshAction() {
        self.showSkeleton()
        self.news = []
        DispatchQueue.main.async {
            self.newsScreen?.newsCollectionView.reloadData()
        }
        self.getFistNews(limit: 15, startAt: 0)
        self.newsScreen?.pullToRefresh.endRefreshing()
    }
    
    
}

extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        if (indexPath.item % 9 == 0) {
            return AdsCollectionCell.identifier
        } else {
            return NewsCell.identifier
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.item % 9 == 0) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as? AdsCollectionCell else {return UICollectionViewCell()}
            cell.adsView.load(GADRequest())

//            cell.adsView.adUnitID = arrAdUnitID[1]
            currentIndexForAdd += 1
            cell.adsView.rootViewController = self
            cell.adsView.load(GADRequest())
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {return UICollectionViewCell()}
            cell.configCell(with: news[indexPath.row])
            currentIndexForNormalRow += 1
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom - 100 <= height {
            page += 10
            self.getFistNews(limit: 15, startAt: page)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item % 9 == 0) {
            return CGSize(width: UIScreen.main.bounds.width - 24, height: 320)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 24, height: 420)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = news[indexPath.item]
        self.openSafariPageWith(url: index.url ?? "Error")
    }
    
    // TODO: RESOLVER FOOTER DEPOIS
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NewsFooterLoading.identifier, for: indexPath) as? NewsFooterLoading else {return UICollectionReusableView()}

        return footer



    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)

    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    }
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
