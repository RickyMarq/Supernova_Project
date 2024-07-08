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
    var alerts: Alerts?
    var page: Int = 0
    var news: [ResultedNewsSite] = []
    var newsSpaceRequested = false
    var viewModel: NewsViewModel?
    
    var arrAdUnitID: [String] = ["ca-app-pub-3940256099942544/2934735716"]

    override func loadView() {
        self.newsScreen = NewsScreen()
        self.view = newsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.viewModel = NewsViewModel(services: NewsServices())
        self.viewModel?.delegate(delegate: self)
        self.configNavigationController()
        self.newsScreen?.delegate(delegate: self)
        self.newsScreen?.newsCollectionViewProtocols(delegate: self, dataSouce: self)
        self.showSkeleton()
        self.viewModel?.getNews()
    }
    
    func configNavigationController() {
        self.title = "Last News"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: nil)
        let menu = configButtonContextMenu()
        if #available(iOS 14.0, *) {
            filterBarButton.menu = menu
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
            self.viewModel?.news = []
            self.viewModel?.getNews()
            self.showSkeleton()
        }
        
        let ArstechnicaProvider = UIAction(title: "Arstechnica", image: nil) { (_) in
             self.viewModel?.news = []
             self.viewModel?.getNewsByProvider(newsProvider: "Arstechnica")
             self.showSkeleton()
        }
        
        let CNBCProvider = UIAction(title: "CNBC", image: nil) { (_) in
             self.viewModel?.news = []
             self.viewModel?.getNewsByProvider(newsProvider: "CNBC")
             self.showSkeleton()
        }
        
        let SpaceNewsProvider = UIAction(title: "SpaceNews", image: nil) { (_) in
             self.viewModel?.news = []
             self.viewModel?.getNewsByProvider(newsProvider: "SpaceNews")
             self.showSkeleton()
        }
        
        let menu = UIMenu(title: "News Provider", image: nil, identifier: nil, options: .displayInline, children: [defaultProvider, ArstechnicaProvider, CNBCProvider, SpaceNewsProvider])
        
        return menu
    }
}

extension NewsController: NewsViewModelProtocol {
   
    func success() {
        DispatchQueue.main.async {
            self.newsScreen?.stopSkeletonAnimation()
            self.newsScreen?.newsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.newsScreen?.newsCollectionView.reloadData()
        }
    }
    
    func failure(error: String) {
        self.alerts?.getAlert(title: "Error", message: "\(error)", buttonMessage: "Cancel")
    }
}

extension NewsController: NewsScreenProtocols {
   
    func savedButtonAction() {
    
    }
   
    func pullToRefreshAction() {
        DispatchQueue.main.async {
            self.viewModel?.news = []
            self.viewModel?.getNews()
            self.showSkeleton()
            self.newsScreen?.pullToRefresh.endRefreshing()
        }
    }
    
    
}

extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let contentCellsCount = (viewModel?.newsCount ?? 0) - ((viewModel?.newsCount ?? 0) / 6)
        
          if contentCellsCount % 5 == 0 {
              return viewModel?.newsCount ?? 0
          } else {
              return (viewModel?.newsCount ?? 0) + 1
          }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return NewsCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item + 1) % 6 == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as? AdsCollectionCell else {return UICollectionViewCell()}
            cell.adsUIView.addSubview(self.newsScreen?.adsView ?? UIView())
            cell.adsView.rootViewController = self
            cell.adsView.load(GADRequest())
            return cell
        } else {
            let contentCellIndexPath = IndexPath(item: indexPath.item - (indexPath.item + 1) / 6, section: indexPath.section)

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {return UICollectionViewCell()}
            guard let dataCell = viewModel?.indexPath(indexPath: contentCellIndexPath) else {return.init()}
            cell.configCell(with: dataCell)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - 350
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            self.viewModel?.getMoreNews(nextPage: viewModel?.nextPage ?? "")
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
        guard let data = self.viewModel?.indexPath(indexPath: indexPath) else {return.init()}

        return configureContextMenu(index: indexPath.row, objc: data)
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
}
