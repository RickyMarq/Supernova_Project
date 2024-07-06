//
//  LauchesController.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import UIKit
import SkeletonView


class LaunchesController: UIViewController {
    
    var index: Int = 0
    var masterArray = [ResultedModel]()
    var launchesScreen: LaunchesScreen?
    var viewModel: LaunchesViewModel?
    var alerts: Alerts?
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.launchesScreen = LaunchesScreen()
        self.view = launchesScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSkeletonView()
        self.viewModel = LaunchesViewModel(service: LaunchesServices())
        self.launchesScreen?.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
        self.viewModel?.delegate(delegate: self)
        self.alerts = Alerts(controller: self)
        self.configNavigationController()
        self.launchesScreen?.LaunchesCollectionViewProtocols(delegate: self, dataSource: self)
        self.launchesScreen?.delegate(delegate: self)
        self.viewModel?.getFutureLaunchesData()
        self.viewModel?.getLastLaunches()
    }
    
    func configNavigationController() {
        self.title = "Launches"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configNavigationController()
    }
    
    func showSkeletonView() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topBottom)
        self.launchesScreen?.LaunchesCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .backgroundColour), animation: animation)
    }
}

extension LaunchesController: LaunchesViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.launchesScreen?.LaunchesCollectionView.reloadData()
            self.launchesScreen?.LaunchesCollectionView.stopSkeletonAnimation()
            self.launchesScreen?.LaunchesCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    func failure(error: String) {
        self.alerts?.getAlert(title: "Error occurred", message: "\(error)", buttonMessage: "Cancel")
    }
}

extension LaunchesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return LaunchesCell.identifier
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.launchesScreen?.segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel?.futureLaunchesCount ?? 0
        case 1:
            return viewModel?.lastLaunchesCount ?? 0
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.launchesScreen?.segmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {return UICollectionViewCell()}
            guard let data = viewModel?.futureLaunchesIndexPath(indexPath: indexPath) else {return.init()}
            cell.configCell(with: data)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {return UICollectionViewCell()}
            guard let data = viewModel?.lastLaunchesIndexPath(indexPath: indexPath) else {return.init()}
            cell.configCell(with: data)
            return cell
        default: return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 24, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.launchesScreen?.segmentedControl.selectedSegmentIndex {
        case 0:
            guard let data = viewModel?.futureLaunchesIndexPath(indexPath: indexPath) else {return}
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: data))
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let data = viewModel?.lastLaunchesIndexPath(indexPath: indexPath) else {return}
            let vc = LaunchesItemController(viewModel: LaunchingItemViewModel(launches: data))
            self.navigationController?.pushViewController(vc, animated: true)
            
        default: break
        }
    }
}

extension LaunchesController: LaunchesScreenProtocol {
   
    func didChangedValue() {
        self.getSoftFeedbackGenerator()
        switch launchesScreen?.segmentedControl.selectedSegmentIndex {
            
        case 0:
            DispatchQueue.main.async {
                self.launchesScreen?.LaunchesCollectionView.reloadData()
                self.launchesScreen?.LaunchesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        case 1:
            DispatchQueue.main.async {
                self.launchesScreen?.LaunchesCollectionView.reloadData()
                self.masterArray.isEmpty ? print("N") : self.launchesScreen?.LaunchesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            
        default: break
        }
    }
}
